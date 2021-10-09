platform :ios, '13.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'WeatherHub' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WeatherHub
  pod 'SwiftGen', '~> 6.0'
  pod 'SwiftLint', '~> 0.43.1'
  pod 'SFSafeSymbols', '~> 2.1.3'


  $SurfUtils = "https://github.com/surfstudio/iOS-Utils.git"
  $Tag = '11.0.0'

  pod 'SurfUtils/StringAttributes', :git => $SurfUtils, :tag => $Tag
  pod 'SurfUtils/UIStyle', :git => $SurfUtils, :tag => $Tag
  pod 'SurfUtils/WordDeclinationSelector', :git => $SurfUtils, :tag => $Tag
  pod 'SurfUtils/CommonButton', :git => $SurfUtils, :tag => $Tag
  # pod 'SurfUtils/VibrationFeedbackManager', :git => $SurfUtils, :tag => $Tag
  pod 'SurfUtils/ItemsScrollManager', :git => $SurfUtils, :tag => $Tag
  pod 'SurfUtils/LayoutHelper', :git => $SurfUtils, :tag => $Tag
  pod 'SurfUtils/XibView', :git => $SurfUtils, :tag => $Tag
  pod 'SurfUtils/SkeletonView', :git => $SurfUtils, :tag => $Tag
  pod 'SurfUtils/KeyboardPresentable', :git => $SurfUtils, :tag => $Tag
  # pod 'SurfUtils/BlurBuilder', :git => $SurfUtils, :tag => $Tag
  pod 'SurfUtils/AdvancedNavigationStackManagement', :git => $SurfUtils, :tag => $Tag
  # pod 'SurfUtils/SettingsRouter', :git => $SurfUtils, :tag => $Tag
  pod 'SurfUtils/RouteMeasurer', :git => $SurfUtils, :tag => $Tag
  # pod 'SurfUtils/MailSender', :git => $SurfUtils, :tag => $Tag
  pod 'SurfUtils/GeolocationService', :git => $SurfUtils, :tag => $Tag


  pod 'ReactiveDataDisplayManager', '~> 7.0.0'
  pod 'NodeKit/UrlCache', :git => 'https://github.com/surfstudio/NodeKit', :tag => '3.2.0'

  target 'WeatherHubTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
