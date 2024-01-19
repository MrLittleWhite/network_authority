import Flutter
import UIKit
import LLNetworkAccessibility_Swift

public class NetworkAuthorityPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    
    private var eventSink: FlutterEventSink?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let channel = FlutterMethodChannel(name: "network_authority/status_control", binaryMessenger: registrar.messenger())

        let streamChannel = FlutterEventChannel(name: "network_authority/status_callback", binaryMessenger: registrar.messenger())

        let instance = NetworkAuthorityPlugin()
        
        registrar.addMethodCallDelegate(instance, channel: channel)
        streamChannel.setStreamHandler(instance)
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        eventSink = nil
        LLNetworkAccessibility.stop()
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "getPlatformVersion":
                result("iOS " + UIDevice.current.systemVersion)
            case "startListening":
                startNetworkAccessibility()
                result(nil)
            case "stopListening":
                LLNetworkAccessibility.stop()
                result(nil)
            case "getStatus":
                result(LLNetworkAccessibility.getCurrentAuthState())
                result(nil)
            default:
                result(FlutterMethodNotImplemented)
        }
    }
    
    // MARK: LLNetworkAccessibility handler
    func startNetworkAccessibility() {
        LLNetworkAccessibility.start()
        LLNetworkAccessibility.configAlertStyle(type: .none)
        LLNetworkAccessibility.reachabilityUpdateCallBack = { [weak self] status in
            guard let self = self, let value = status?.rawValue else { return }
            self.eventSink?(value);
        }
    }
    
    // MARK: FlutterStreamHandler delegate
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        LLNetworkAccessibility.stop()
        eventSink = nil
        return nil
    }

}
