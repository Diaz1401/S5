// lib/src/utils/fuzzy_evaluator.dart
// Implementasi Fuzzy Mamdani untuk 4 input (pH, temperature, tds, turbidity)
// Output: kategori risiko {RSR, RR, RS, RT, RST} + nilai defuzzifikasi (0..100)

import 'dart:math';

typedef MF = double Function(double x);

class FuzzyEvaluator {
  // --- PUBLIC: panggil evaluate untuk mendapatkan hasil ---
  // returns Map: { 'label': 'RS'|'RR'|..., 'score': double (0..100) }
  static Map<String, dynamic> evaluate({
    required double ph,
    required double temperature,
    required double tds,
    required double turbidity,
  }) {
    // 1) Fuzzifikasi: hitung derajat keanggotaan tiap linguistic term
    final phMFs = _phMemberships(ph);
    final tempMFs = _tempMemberships(temperature);
    final tdsMFs = _tdsMemberships(tds);
    final turbMFs = _turbMemberships(turbidity);

    // 2) Rule base Mamdani
    // Rule didefinisikan sebagai:
    // { 'if': {'ph':'N'|'L'|'H', 'temp':..., 'tds':..., 'turb':...}, 'then': 'RSR'|'RR'|'RS'|'RT'|'RST' }
    // Kita gunakan banyak kombinasi umum. Edit rules ini sesuai PDF-mu bila perlu.
    final List<Map<String, dynamic>> rules = [
      // contoh aturan: semua normal -> risiko sangat rendah
      {
        'if': {'ph': 'N', 'temp': 'N', 'tds': 'N', 'turb': 'N'},
        'then': 'RSR',
      },
      // sebagian kecil gangguan -> risiko rendah
      {
        'if': {'ph': 'N', 'temp': 'N', 'tds': 'N', 'turb': 'H'},
        'then': 'RR',
      },
      {
        'if': {'ph': 'N', 'temp': 'N', 'tds': 'H', 'turb': 'N'},
        'then': 'RR',
      },
      // kondisi sedang
      {
        'if': {'ph': 'N', 'temp': 'H', 'tds': 'N', 'turb': 'N'},
        'then': 'RS',
      },
      {
        'if': {'ph': 'L', 'temp': 'N', 'tds': 'N', 'turb': 'N'},
        'then': 'RS',
      },
      // risiko tinggi: beberapa input di level tinggi/berbahaya
      {
        'if': {'ph': 'H', 'temp': 'H', 'tds': 'H', 'turb': 'H'},
        'then': 'RST',
      },
      {
        'if': {'ph': 'H', 'temp': 'H', 'tds': 'N', 'turb': 'H'},
        'then': 'RT',
      },
      {
        'if': {'ph': 'L', 'temp': 'H', 'tds': 'H', 'turb': 'N'},
        'then': 'RT',
      },
      // banyak aturan tambahan untuk cakupan wajar:
      {
        'if': {'ph': 'L', 'temp': 'L', 'tds': 'L', 'turb': 'L'},
        'then': 'RSR',
      },
      {
        'if': {'ph': 'L', 'temp': 'L', 'tds': 'N', 'turb': 'N'},
        'then': 'RR',
      },
      {
        'if': {'ph': 'N', 'temp': 'N', 'tds': 'L', 'turb': 'N'},
        'then': 'RR',
      },
      {
        'if': {'ph': 'H', 'temp': 'N', 'tds': 'H', 'turb': 'N'},
        'then': 'RS',
      },
      {
        'if': {'ph': 'H', 'temp': 'H', 'tds': 'H', 'turb': 'N'},
        'then': 'RT',
      },
      {
        'if': {'ph': 'N', 'temp': 'H', 'tds': 'H', 'turb': 'H'},
        'then': 'RST',
      },
      // fallback rule: jika tidak cocok, set RS (risiko sedang)
      // (Rule base ini dapat diperluas agar match persis dengan PDF)
    ];

    // 3) Untuk setiap rule: hitung firing strength = min(degrees of the specified terms)
    //    Perlu mapping dari term letter -> membership degree
    final Map<String, double> outputAggregation = {
      'RSR': 0.0,
      'RR': 0.0,
      'RS': 0.0,
      'RT': 0.0,
      'RST': 0.0,
    };

    for (final rule in rules) {
      final cond = rule['if'] as Map<String, String>;
      final outLabel = rule['then'] as String;

      final phDeg = phMFs[cond['ph']!] ?? 0.0;
      final tDeg = tempMFs[cond['temp']!] ?? 0.0;
      final tdDeg = tdsMFs[cond['tds']!] ?? 0.0;
      final tbDeg = turbMFs[cond['turb']!] ?? 0.0;

      final firing = min(min(phDeg, tDeg), min(tdDeg, tbDeg)); // AND = min
      // aggregate by maximum (Mamdani)
      outputAggregation[outLabel] = max(outputAggregation[outLabel]!, firing);
    }

    // 4) Defuzzifikasi: kita representasikan output linguistic -> numeric range
    // gunakan representasi titik/centroid: RSR ~ 0, RR ~ 25, RS ~ 50, RT ~ 75, RST ~ 100
    final Map<String, double> outputCenters = {
      'RSR': 0.0,
      'RR': 25.0,
      'RS': 50.0,
      'RT': 75.0,
      'RST': 100.0,
    };

    // centroid sederhana: weighted average of centers by aggregated membership
    double numerator = 0.0;
    double denominator = 0.0;
    outputAggregation.forEach((label, mu) {
      numerator += mu * outputCenters[label]!;
      denominator += mu;
    });

    final double score = (denominator == 0) ? 50.0 : (numerator / denominator);

    // find highest label by aggregated mu
    String bestLabel = 'RS';
    double bestMu = -1.0;
    outputAggregation.forEach((label, mu) {
      if (mu > bestMu) {
        bestMu = mu;
        bestLabel = label;
      }
    });

    return {
      'label': bestLabel,
      'score': double.parse(score.toStringAsFixed(2)),
      'aggregation': outputAggregation,
      'centers': outputCenters,
    };
  }

  // ----------------------------
  // Membership functions per variabel
  // Output: Map<termLetter, degree>
  // term letters: 'L' = Low/Rendah, 'N' = Normal, 'H' = High/Tinggi
  // ----------------------------

  static Map<String, double> _phMemberships(double x) {
    // contoh batas: Rendah <6.5, Normal 6.5-8.5, Tinggi >8.5
    return {
      'L': _leftTrapezoid(x, 0.0, 0.0, 6.0, 6.5),
      'N': _triangular(x, 6.0, 7.5, 8.5),
      'H': _rightTrapezoid(x, 8.0, 8.5, 14.0, 14.0),
    };
  }

  static Map<String, double> _tempMemberships(double x) {
    // suhu (°C) contoh: Rendah <24, Normal 24-32, Tinggi >32
    return {
      'L': _leftTrapezoid(x, -10.0, -10.0, 20.0, 24.0),
      'N': _triangular(x, 20.0, 27.0, 32.0),
      'H': _rightTrapezoid(x, 28.0, 32.0, 50.0, 50.0),
    };
  }

  static Map<String, double> _tdsMemberships(double x) {
    // TDS (mg/L) contoh: Rendah <300, Normal 300-500, Tinggi >500
    return {
      'L': _leftTrapezoid(x, 0.0, 0.0, 200.0, 300.0),
      'N': _triangular(x, 250.0, 400.0, 500.0),
      'H': _rightTrapezoid(x, 450.0, 500.0, 2000.0, 2000.0),
    };
  }

  static Map<String, double> _turbMemberships(double x) {
    // Turbidity (NTU): Rendah <5, Normal 5-25, Tinggi >25
    return {
      'L': _leftTrapezoid(x, 0.0, 0.0, 2.0, 5.0),
      'N': _triangular(x, 3.0, 12.0, 25.0),
      'H': _rightTrapezoid(x, 20.0, 25.0, 100.0, 100.0),
    };
  }

  // ----------------------------
  // Basic membership shapes
  // ----------------------------
  static double _triangular(double x, double a, double b, double c) {
    if (x <= a || x >= c) return 0.0;
    if (x == b) return 1.0;
    if (x < b) return (x - a) / (b - a);
    return (c - x) / (c - b);
  }

  static double _leftTrapezoid(
    double x,
    double a,
    double b,
    double c,
    double d,
  ) {
    // rise from a->b, plateau b->c, fall c->d (but here used for left open shapes)
    if (x <= b) return 1.0;
    if (x >= d) return 0.0;
    if (x > b && x < c) return (x - b) / (c - b);
    // between c and d: linear fall
    return (d - x) / (d - c);
  }

  static double _rightTrapezoid(
    double x,
    double a,
    double b,
    double c,
    double d,
  ) {
    // left rise a->b, plateau b->c, right fall c->d (used for right open shapes)
    if (x <= a) return 0.0;
    if (x >= c) return 1.0;
    if (x > a && x < b) return (x - a) / (b - a);
    // between b and c: plateau -> 1
    return 1.0;
  }
}
