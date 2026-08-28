import Capacitor
import PushGenius

@objc(PushGeniusPlugin)
public class PushGeniusPlugin: CAPPlugin, CAPBridgedPlugin {
  public let identifier = "PushGeniusPlugin"
  public let jsName = "PushGenius"
  public let pluginMethods: [CAPPluginMethod] = [
    CAPPluginMethod(name: "setHost", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "initialize", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "login", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "logout", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "addTags", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "requestPermission", returnType: CAPPluginReturnPromise),
  ]

  @objc func setHost(_ call: CAPPluginCall) {
    PushGenius.setHost(call.getString("url") ?? "")
    call.resolve()
  }

  @objc func initialize(_ call: CAPPluginCall) {
    OneSignal.initialize(call.getString("appId") ?? "", withLaunchOptions: nil)
    call.resolve()
  }

  @objc func login(_ call: CAPPluginCall) {
    OneSignal.login(call.getString("externalId") ?? "")
    call.resolve()
  }

  @objc func logout(_ call: CAPPluginCall) {
    OneSignal.logout()
    call.resolve()
  }

  @objc func addTags(_ call: CAPPluginCall) {
    if let tags = call.getObject("tags") as? [String: String] {
      OneSignal.User.addTags(tags)
    }
    call.resolve()
  }

  @objc func requestPermission(_ call: CAPPluginCall) {
    OneSignal.Notifications.requestPermission(true) { granted in
      call.resolve(["granted": granted])
    }
  }
}
