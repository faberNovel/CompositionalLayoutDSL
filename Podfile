platform :ios, '13.0'
use_frameworks!

target 'CompositionalLayoutDSLApp' do
    pod 'SwiftLint', '~> 0.42.0'
end

target 'CompositionalLayoutDSLTests' do
    pod 'ADLayoutTest', '~> 1.0'
    pod 'SnapshotTesting', '~> 1.8'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|

            # Change the Optimization level for each target/configuration
            if !config.name.include?("Distribution")
                config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
            end

            # Disable Pod Codesign
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"

            # Fix build issue on Xcode 15
            if ["SwiftCheck", "ADLayoutTest", "ADAssertLayout"].include? target.name
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = 11.0
                config.build_settings['TVOS_DEPLOYMENT_TARGET'] = 11.0
            end
        end
    end
end
