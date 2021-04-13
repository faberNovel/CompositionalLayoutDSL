platform :ios, '13.0'
use_frameworks!

target 'CompositionalLayoutDSLApp' do
    pod 'SwiftLint', '~> 0.42.0'
end

target 'CompositionalLayoutDSLTests' do
#    pod 'Nimble', '~> 9.0'
#    pod 'Nimble-Snapshots', '~> 9.0'
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
        end
    end
end
