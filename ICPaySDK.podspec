
Pod::Spec.new do |s|
  s.name             = 'ICPaySDK'
  s.version          = '2.1.0'
  s.summary          = 'ICPaySDK is an unique sdk to pay'
  s.description  = "ICPaySDK = wxpay + alipay. the api is unique"
  s.homepage         = 'https://github.com/CorkiiOS/ICPaySDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'corkiios' => '675053587@qq.com' }
  s.source           = { :git => 'https://github.com/CorkiiOS/ICPaySDK.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.ios.deployment_target = '8.0'


    s.subspec 'ICPayManager' do |mgr|


   mgr.source_files = 'ICPaySDK/Base/**/*.{h,m}'

    end

   s.subspec 'ICAliPay' do |ali|

    ali.dependency 'ICPaySDK/ICPayManager'
    ali.dependency 'AlipaySDK-iOS'
    ali.source_files = 'ICPaySDK/ICAliPay/*.{h,m}'

   end

    s.subspec 'ICWxPay' do |wx|

    wx.dependency 'ICPaySDK/ICPayManager'
    wx.dependency 'WechatOpenSDK'
    wx.source_files = 'ICPaySDK/ICWxPay/*.{h,m}'

    end

end
