enum DevicePlatform { iosPhone, androidPhone, appleWatch, wearOs }

class DeviceRegistration {
  final String id;
  final String userId;
  final DevicePlatform platform;
  final String pushToken;
  final DateTime registeredAt;
  final DateTime lastActiveAt;

  const DeviceRegistration({
    required this.id,
    required this.userId,
    required this.platform,
    required this.pushToken,
    required this.registeredAt,
    required this.lastActiveAt,
  });
}
