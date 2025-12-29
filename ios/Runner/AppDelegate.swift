import UIKit
import flutter_downloader
import Flutter
import GoogleMaps
import QuickLook
import AuthenticationServices
// import Firebase
import SwiftKeychainWrapper
import flutter_local_notifications

                                 
@main
@objc class AppDelegate: FlutterAppDelegate {
    private var _latestLink: String?
    private var latestLink: String? {
        get {
            _latestLink
        }
        set(latestLink) {

            _latestLink = latestLink
            if _eventSink != nil {
                _eventSink?(_latestLink)
            }
        }
    }

        private var _eventSink: FlutterEventSink?
    var fileURL: URL!
    var result : FlutterResult?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //   FirebaseApp.configure()
      FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
               GeneratedPluginRegistrant.register(with: registry)
             }

            if #available(iOS 10.0, *) {
              UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            }
    GMSServices.provideAPIKey("Your_Map_API_Key")
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let mlkitChannel = FlutterMethodChannel(name: "com.oddo.flutter/channel",
                                                  binaryMessenger: controller.binaryMessenger)
    mlkitChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if call.method == "mlKit"{
        let vc = MLKitViewController(nibName: "MLKitViewController", bundle: nil)
            vc.detectorType = (call.arguments as? String ) ?? "" == "imageSearch" ? .image : .text
        vc.modalPresentationStyle = .overFullScreen
        vc.suggestedData = { data in
            result(data)
        }
        controller.present(vc, animated: true, completion: nil)
        }else if call.method == "fileviewer"{
            if let urlString = call.arguments as? String, let url = self.showFileWithPath(urlString){
                self.fileURL = url
            let previewController = QLPreviewController()
            previewController.dataSource = self
            previewController.delegate = self
            previewController.modalPresentationStyle = .fullScreen
        controller.present(previewController, animated: true, completion: nil)
            }
        }
        })

    let chargingChannel = FlutterEventChannel(
        name: "uni_links/events",
        binaryMessenger: controller.binaryMessenger)
    chargingChannel.setStreamHandler(self)
    
    GeneratedPluginRegistrant.register(with: self)
        FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    func showFileWithPath(_ path: String) -> URL?{
        if let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
        print(documentsUrl)
        let destinationFileUrl = documentsUrl.appendingPathComponent(path)
        print(documentsUrl)
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destinationFileUrl.path) {
            print("FILE AVAILABLE")
            return destinationFileUrl
        }
       }
        return nil
    }

    override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

        if userActivity.activityType == "NSUserActivityTypeBrowsingWeb" {
            print(userActivity.webpageURL as Any)
            setLatestLink(userActivity.webpageURL?.description)
        }
        return true
        
    }
}
private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
    }
}
extension AppDelegate: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    override func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        print(#function)
        print(userActivityType)
        return true
    }
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let url = fileURL
        return url! as QLPreviewItem
    }

}

extension AppDelegate: FlutterStreamHandler {
        func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
            _eventSink = events
            return nil
        }
    
        func onCancel(withArguments arguments: Any?) -> FlutterError? {
            _eventSink = nil
            return nil
        }
    func setLatestLink(_ latestLink: String?) {
        self.latestLink = latestLink
        if (_eventSink != nil) {
            _eventSink?(self.latestLink)
        }
    }
    }
