
import 'package:network_authority/network_authority_status.dart';
import 'network_authority_platform_interface.dart';

class NetworkAuthority {
  Future<String?> getPlatformVersion() {
    return NetworkAuthorityPlatform.instance.getPlatformVersion();
  }

  Future<void> startListening() {
    return NetworkAuthorityPlatform.instance.startListening();
  }

  Future<void> stopListening() {
    return NetworkAuthorityPlatform.instance.stopListening();
  }

  Future<NetworkAuthorityStatus> getStatus() {
    return NetworkAuthorityPlatform.instance.getStatus();
  }

  Stream<NetworkAuthorityStatus> get onStatusChanged {
    return NetworkAuthorityPlatform.instance.onStatusChanged;
  }
}
