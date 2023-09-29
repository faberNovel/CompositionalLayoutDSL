Pod::Spec.new do |spec|
  spec.name         = 'CompositionalLayoutDSL'
  spec.version      = '0.1.1'
  spec.summary      = 'library to ease the creation of UICollectionViewCompositionalLayout'
  spec.homepage     = 'https://github.com/faberNovel/CompositionalLayoutDSL'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { 'Alexandre Podlewski' => 'alexandre.podlewski@fabernovel.com' }
  spec.source       = { :git => 'https://github.com/faberNovel/CompositionalLayoutDSL', :tag => "v#{spec.version}" }
  spec.social_media_url = 'https://twitter.com/fabernovel'
  spec.ios.deployment_target = '13.0'
  spec.tvos.deployment_target = '13.0'
  spec.osx.deployment_target = '10.15'
  spec.framework      = 'Foundation'
  spec.ios.framework  = 'UIKit'
  spec.osx.framework  = 'AppKit'
  spec.swift_versions = ['5.1', '5.2', '5.3', '5.4']
  spec.source_files = 'Sources/CompositionalLayoutDSL/**/*'
end
