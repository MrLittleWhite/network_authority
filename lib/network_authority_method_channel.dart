import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_authority/network_authority_status.dart';

import 'network_authority_platform_interface.dart';

/// An implementation of [NetworkAuthorityPlatform] that uses method channels.
class MethodChannelNetworkAuthority extends NetworkAuthorityPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('network_authority/status_control');

  @visibleForTesting
  final eventChannel = const EventChannel('network_authority/status_callback');

  Stream<NetworkAuthorityStatus>? _onStatusChanged;

  @override
  Future<String?> getPlatformVersion() async {
    return methodChannel.invokeMethod<String>('getPlatformVersion');
  }

  @override
  Future<void> startListening() {
    return methodChannel.invokeMethod('startListening');
  }

  @override
  Future<void> stopListening() {
    return methodChannel.invokeMethod('stopListening');
  }

  @override
  Future<NetworkAuthorityStatus> getStatus() {
    return methodChannel.invokeMethod<NetworkAuthorityStatus>('getStatus').then((value) => value ?? NetworkAuthorityStatus.unknown);
  }

  @override
  Stream<NetworkAuthorityStatus> get onStatusChanged {
    _onStatusChanged ??= eventChannel.receiveBroadcastStream().map((dynamic event) {
      return NetworkAuthorityStatus.values[event];
    });
    return _onStatusChanged!;
  }

}
