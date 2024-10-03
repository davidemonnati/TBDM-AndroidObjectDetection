import 'package:app/entity/prediction.dart';

class Result {
  final String uuid;
  final int timestamp;
  final List<Prediction> predictions;

  Result(this.uuid, this.timestamp, this.predictions);

  Result.fromJson(Map<String, dynamic> json)
      :
        uuid = json['uuid'] as String,
        timestamp = json['timestamp'] as int,
        predictions = (json['predictions'] as List).map((p) =>
            Prediction.fromJson(p)).toList();

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'timestamp': timestamp,
    'predictions': predictions,
  };
}