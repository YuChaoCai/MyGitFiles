Pod::Spec.new do |s|
  s.name         = "YIInnerShadowView"
  s.version      = "1.1.0"
  s.license      = { :type => 'Beerware', :text => 'If we meet some day, and you think this stuff is worth it, you can buy me a beer in return.' }
  s.homepage     = "https://github.com/inamiy/YIInnerShadowView"
  s.author       = { "Yasuhiro Inami" => "inamiy@gmail.com" }
  s.summary      = "Inner-shadow UIView/CALayer for iOS."
  s.screenshots  = [ "https://raw.githubusercontent.com/inamiy/YIInnerShadowView/master/Screenshots/screenshot.jpg" ]
  s.source       = { :git => 'https://github.com/inamiy/YIInnerShadowView.git', :tag => "#{s.version}" }
  s.source_files = 'Classes/*.{h,m}'
  s.requires_arc = true
  s.platform     = :ios, '5.0'
  s.frameworks   = 'QuartzCore'
end
