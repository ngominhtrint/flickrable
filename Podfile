# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def rx_swift
    pod 'RxSwift', '~> 4.0'
end

def rx_cocoa
    pod 'RxCocoa', '~> 4.0'
end

def test_pods
    pod 'RxTest', '~> 4.0'
    pod 'RxBlocking', '~> 4.0'
    pod 'Nimble'
end

target 'Flickrable' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Flickrable
  rx_cocoa
  rx_swift

  pod 'QueryKit'
  pod 'RxAlamofire'
  pod 'ObjectMapper'
  pod 'AlamofireObjectMapper'
  pod 'AlamofireImage', '~> 3.1'
  pod 'TPKeyboardAvoiding', '~> 1.3.1'

  target 'FlickrableTests' do
    inherit! :search_paths
    # Pods for testing
    
    test_pods
  end

  target 'FlickrableUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.2'
        end
    end
end
