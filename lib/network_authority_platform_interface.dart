import 'dart:async';

import 'package:network_authority/network_authority_status.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'network_authority_method_channel.dart';

abstract class NetworkAuthorityPlatform extends PlatformInterface {
  /// Constructs a NetworkAuthorityPlatform.
  NetworkAuthorityPlatform() : super(token: _token);

  static final Object _token = Object();

  static NetworkAuthorityPlatform _instance = MethodChannelNetworkAuthority();

  /// The default instance of [NetworkAuthorityPlatform] to use.
  ///
  /// Defaults to [MethodChannelNetworkAuthority].
  static NetworkAuthorityPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NetworkAuthorityPlatform] when
  /// they register themselves.
  static set instance(NetworkAuthorityPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> startListening() {
    throw UnimplementedError('startListening() has not been implemented.');
  }

  Future<void> stopListening() {
    throw UnimplementedError('stopListening() has not been implemented.');
  }

  Future<NetworkAuthorityStatus> getStatus() {
    throw UnimplementedError('getStatus() has not been implemented.');
  }

  Stream<NetworkAuthorityStatus> get onStatusChanged {
    throw UnimplementedError('statusStream() has not been implemented.');
  }
}
