class Settings {
  final String detectionIp;
  final String storageIp;

  const Settings({
    required this.detectionIp,
    required this.storageIp
  });

  Map<String, Object?> toMap() {
    return {
      'detection_ip': detectionIp,
      'storage_ip': storageIp,
    };
  }
}
