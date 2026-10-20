require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "PushgeniusIonic"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]
  s.source       = { :git => "https://github.com/PushGenius/ionic-sdk.git", :tag => s.version.to_s }
  s.source_files = "ios/Sources/**/*.swift"
  s.ios.deployment_target = "15.0"
  s.swift_version = "5.9"
  s.frameworks   = "UserNotifications"
  s.resource_bundles = { "PushgeniusIonicPrivacy" => ["ios/Sources/PushGeniusIonic/Core/PrivacyInfo.xcprivacy"] }
  s.dependency "Capacitor"
end
