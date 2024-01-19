#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint network_authority.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'network_authority'
  s.version          = '0.0.1'
  s.summary          = 'Flutter iOS plugin for LLNetworkAccessibility'
  s.description      = <<-DESC
  This plugin allows Flutter apps to discover network authority on ios platform.
                       DESC
  s.homepage         = 'https://github.com/MrLittleWhite'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'LiuYunzhi' => 'luffy243077002@163.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'LLNetworkAccessibility-Swift'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
