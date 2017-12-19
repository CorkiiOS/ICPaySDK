
Pod::Spec.new do |s|
  s.name             = 'ICPaySDK'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ICPaySDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "ICPaySDK = wxpay + alipay. the api is unique"

  s.homepage         = 'https://github.com/corkiios/ICPaySDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'corkiios' => '675053587@qq.com' }
  s.source           = { :git => 'https://github.com/corkiios/ICPaySDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ICPaySDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ICPaySDK' => ['ICPaySDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

s.subspec 'ICAliPay' do |ss|
ss.source_files = 'ICPaySDK/Classes/ICPay/ICAliPayFactory.{h,m}'
ss.frameworks = 'Security'
ss.dependency 'AliPay_SDK'

end

s.subspec 'ICWxPay' do |ss|
ss.source_files = 'ICPaySDK/Classes/ICPay/ICWxPayFactory.{h,m}'
ss.frameworks = 'Security'
ss.dependency 'WechatOpenSDK'

end


end
