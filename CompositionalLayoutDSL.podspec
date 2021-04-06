Pod::Spec.new do |spec|
  spec.name         = 'CompositionalLayoutDSL'
  spec.version      = '0.1.0'
  spec.summary      = 'library to ease the creation of UICollectionViewCompositionalLayout'
  spec.homepage     = 'https://github.com/faberNovel/CompositionalLayoutDSL'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { 'Alexandre Podlewski' => 'alexandre.podlewski@fabernovel.com' }
  spec.source       = { :git => 'https://github.com/faberNovel/CompositionalLayoutDSL', :tag => "v#{spec.version}" }
  spec.social_media_url = 'https://twitter.com/fabernovel'
  spec.ios.deployment_target = '13.0'
  spec.tvos.deployment_target = '13.0'
  spec.framework    = 'Foundation', 'UIKit'
  spec.swift_versions = '5.1'
  s.source_files = 'Sources/CompositionalLayoutDSL/**/*'
end
