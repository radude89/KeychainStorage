#
#  Be sure to run `pod spec lint KeychainStorage.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "KeychainStorage"
  s.version      = "0.1.0"
  s.summary      = "KeychainStorage is a simple wrapper for Keychain items. Use it to quickly save and retrieve sesnsitive information from Keychain."
  s.homepage     = "https://github.com/radude89/KeychainStorage"
  s.license      = "MIT"
  s.authors             = { "Radu Dan" => "contact@radude89.com" }
  s.social_media_url   = "https://twitter.com/radude89"
  s.source       = { :git => "https://github.com/radude89/KeychainStorage.git", :tag => "#{s.version}" }

  s.ios.deployment_target = "12.0"

  s.swift_version = "5.0"

  s.source_files = "KeychainStorage/*.swift"

end
