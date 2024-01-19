import 'package:flutter_test/flutter_test.dart';
import 'package:network_authority/network_authority.dart';
import 'package:network_authority/network_authority_platform_interface.dart';
import 'package:network_authority/network_authority_method_channel.dart';
import 'package:network_authority/network_authority_status.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNetworkAuthorityPlatform
    with MockPlatformInterfaceMixin
    implements NetworkAuthorityPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<NetworkAuthorityStatus> getStatus() {
    return Future(() => NetworkAuthorityStatus.checking);
  }

  @override
  Stream<NetworkAuthorityStatus> get onStatusChanged => Stream<NetworkAuthorityStatus>.fromIterable([NetworkAuthorityStatus.checking, 
    NetworkAuthorityStatus.unknown, 
    NetworkAuthorityStatus.authorized, 
    NetworkAuthorityStatus.denied]);

  @override
  Future<void> startListening() {
    return Future(() => null);
  }

  @override
  Future<void> stopListening() {
    return Future(() => null);
  }
}

void main() {
  final NetworkAuthorityPlatform initialPlatform = NetworkAuthorityPlatform.instance;

  test('$MethodChannelNetworkAuthority is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNetworkAuthority>());
  });

  test('getPlatformVersion', () async {
    NetworkAuthority networkAuthorityPlugin = NetworkAuthority();
    MockNetworkAuthorityPlatform fakePlatform = MockNetworkAuthorityPlatform();
    NetworkAuthorityPlatform.instance = fakePlatform;

    expect(await networkAuthorityPlugin.getPlatformVersion(), '42');
  });
}
