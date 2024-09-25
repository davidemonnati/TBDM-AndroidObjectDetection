class Prediction {
  final String category;
  final double x;
  final double y;
  final double w;
  final double h;

  Prediction(this.category, this.x, this.y, this.w, this.h);

  Prediction.fromJson(Map<String, dynamic> json)
      :
        category = json['category'] as String,
        x = json['x'] as double,
        y = json['y'] as double,
        w = json['w'] as double,
        h = json['h'] as double;
}
