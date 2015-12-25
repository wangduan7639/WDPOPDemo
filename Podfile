platform :ios, :deployment_target => "8.0"

pod 'Masonry', '0.6.1'
pod 'ReactiveCocoa', '2.4.7'
pod 'RETableViewManager', '1.6'
pod 'SVProgressHUD', '1.1.3'
pod 'pop', :git => 'https://github.com/facebook/pop.git'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_STRICT_OBJC_MSGSEND'] = 'NO'
        end
    end
end

inhibit_all_warnings!



