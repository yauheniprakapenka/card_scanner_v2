import Flutter
import UIKit
import AVFoundation

public class SwiftCardScannerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "card_scanner_method", binaryMessenger: registrar.messenger())
        let instance = SwiftCardScannerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    var result: FlutterResult?
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "scan_card") {
            let scanProcessor: ScanProcessor = ScanProcessor(withOptions: CardScannerOptions(from: call.arguments as? [String: String]))
            
            scanProcessor.scanProcessorDelegate = self
            var secondsRemaining = CardScannerOptions(from: call.arguments as? [String: String]).cardScannerTimeOut
            
            do {
                try isCameraAccessDenied()
                
                DispatchQueue.main.async {
                    scanProcessor.startScanning()
                }
                
                if secondsRemaining != 0 {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                        if secondsRemaining <= 0 {
                            Timer.invalidate()
                            DispatchQueue.main.async {
                                UIApplication.shared.keyWindow?.rootViewController?.dismiss(
                                    animated: true,
                                    completion: nil
                                )
                            }
                        } else {
                            secondsRemaining -= 1
                        }
                    }
                }
                
                self.result = result
                
            } catch {
                result(FlutterError(
                    code: "camera_access_denied",
                    message: "No permission for the camera. Turn on permission in app settings",
                    details: nil))
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}

extension SwiftCardScannerPlugin: ScanProcessorDelegate {
    public func scanProcessor(_ scanProcessor: ScanProcessor, didFinishScanning card: CardDetails) {
        if let result = self.result {
            result(card.dictionary)
        }
    }
    
    func isCameraAccessDenied() throws {
        if AVCaptureDevice.authorizationStatus(for: .video) == .denied {
            throw CameraError.accessDenied
        }
    }
}
