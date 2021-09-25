platform :ios, '13.0'

target 'WeatherHub' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WeatherHub
  pod 'SwiftGen', '~> 6.0'
  pod 'SwiftLint', '~> 0.43.1'
  pod 'SFSafeSymbols', '~> 2.1.3'

  pod 'SurfUtils/GeolocationService', :git => "https://github.com/surfstudio/iOS-Utils.git"
  pod 'SurfUtils/CommonButton', :git => "https://github.com/surfstudio/iOS-Utils.git"
  pod 'SurfUtils/LoadingView', :git => "https://github.com/surfstudio/iOS-Utils.git"
  pod 'SurfUtils/ItemsScrollManager', :git => "https://github.com/surfstudio/iOS-Utils.git"

  pod 'ReactiveDataDisplayManager', "~> 7.0.0"

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
