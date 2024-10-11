class Settings {
  final int id;
  final String detectionIp;
  final String storageIp;

  const Settings({
    required this.id,
    required this.detectionIp,
    required this.storageIp
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'detection_ip': detectionIp,
      'storage_ip': storageIp,
    };
  }
}
