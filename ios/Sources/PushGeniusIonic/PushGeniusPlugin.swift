import Capacitor

/// Capacitor bridge over the vendored PushGenius iOS SDK (Core/).
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
    CAPPluginMethod(name: "removeTags", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "addAlias", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "requestPermission", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "optIn", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "optOut", returnType: CAPPluginReturnPromise),
  ]

  @objc func setHost(_ call: CAPPluginCall) {
    PushGenius.setHost(call.getString("url") ?? "")
    call.resolve()
  }

  @objc func initialize(_ call: CAPPluginCall) {
    guard let appId = call.getString("appId"), !appId.isEmpty else {
      call.reject("appId is required")
      return
    }
    BigBrain.initialize(appId)
    call.resolve()
  }

  @objc func login(_ call: CAPPluginCall) {
    guard let externalId = call.getString("externalId"), !externalId.isEmpty else {
      call.reject("externalId is required")
      return
    }
    BigBrain.login(externalId)
    call.resolve()
  }

  @objc func logout(_ call: CAPPluginCall) {
    BigBrain.logout()
    call.resolve()
  }

  @objc func addTags(_ call: CAPPluginCall) {
    let tags = (call.getObject("tags") ?? [:]).mapValues { "\($0)" }
    BigBrain.User.addTags(tags)
    call.resolve()
  }

  @objc func removeTags(_ call: CAPPluginCall) {
    let keys = (call.getArray("keys") ?? []).compactMap { $0 as? String }
    BigBrain.User.removeTags(keys)
    call.resolve()
  }

  @objc func addAlias(_ call: CAPPluginCall) {
    guard let label = call.getString("label"), let id = call.getString("id") else {
      call.reject("label and id are required")
      return
    }
    BigBrain.User.addAlias(label: label, id: id)
    call.resolve()
  }

  @objc func requestPermission(_ call: CAPPluginCall) {
    BigBrain.Notifications.requestPermission(true) { granted in
      call.resolve(["granted": granted])
    }
  }

  @objc func optIn(_ call: CAPPluginCall) {
    BigBrain.User.pushSubscription.optIn()
    call.resolve()
  }

  @objc func optOut(_ call: CAPPluginCall) {
    BigBrain.User.pushSubscription.optOut()
    call.resolve()
  }
}
