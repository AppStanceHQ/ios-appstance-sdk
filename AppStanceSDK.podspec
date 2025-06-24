Pod::Spec.new do |s|
  s.name             = "AppStanceSDK"
  s.version          = "0.7.3"
  s.summary          = "iOS library for Apple Search Ads attribution and ROAS measurement"
  s.description      = "AppStanceSDK Apple Ads MMP SDK module for iOS applications providing Apple Ads attribution and ROAS measurement capabilities"
  s.homepage         = "https://github.com/AppStanceHQ/ios-appstance-sdk"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "AppStance HQ" => "appstancehq@gmail.com" }
  s.source           = { :git => "https://github.com/AppStanceHQ/ios-appstance-sdk.git", :tag => "#{s.version}" }
  s.vendored_frameworks = "AppStanceSDK.xcframework"
  s.platform         = :ios, "13.0"
  s.swift_version    = "5.7"

  s.weak_framework = 'AdServices'
end