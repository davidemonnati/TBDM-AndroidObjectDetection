import 'package:app/entity/detection/directions.dart';

class Prediction {
  final String category;
  final double x;
  final double y;
  final double w;
  final double h;
  final List<Directions> directions;

  Prediction(this.category, this.x, this.y, this.w, this.h, this.directions);

  Prediction.fromJson(Map<String, dynamic> json)
      :
        category = json['category'] as String,
        x = json['x'] as double,
        y = json['y'] as double,
        w = json['w'] as double,
        h = json['h'] as double,
        directions = (json['directions'] as List).map((d) =>
            Directions.fromJson(d)).toList();

  Map<String, dynamic> toJson() =>
      {
        'category': category,
        'x': x,
        'y': y,
        'w': w,
        'h': h,
        'directions': directions,
      };
}
