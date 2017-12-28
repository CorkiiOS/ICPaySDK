
Pod::Spec.new do |s|
  s.name             = 'ICPaySDK'
  s.version          = '1.3.0'
  s.summary          = 'ICPaySDK is an unique sdk to pay'
  s.description  = "ICPaySDK = wxpay + alipay. the api is unique"
  s.homepage         = 'https://github.com/CorkiiOS/ICPaySDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'corkiios' => '675053587@qq.com' }
  s.source           = { :git => 'https://github.com/CorkiiOS/ICPaySDK.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.source_files = 'ICPaySDK/Classes/**/*'


    s.subspec 'ICPayManager' do |mgr|

# mgr.source_files = 'ICPaySDK/Classes/IC{Error,IAliModel,IWxModel,MessageModel,PayDesignManager,PaySDKCommon,BasePayFactory,IPay,IUnionpayModel}.{h,m}'

mgr.source_files = 'ICPaySDK/Classes/ICManager/*.{h,m}'

    end

   s.subspec 'ICAliPay' do |ali|

    ali.dependency 'ICPaySDK/ICPayManager'
    ali.dependency 'AliPay_SDK'
    ali.source_files = 'ICPaySDK/Classes/ICAliPayFactory.{h,m}'

   end

    s.subspec 'ICWxPay' do |wx|

    wx.dependency 'ICPaySDK/ICPayManager'
    wx.dependency 'WechatOpenSDK'
    wx.source_files = 'ICPaySDK/Classes/ICWxPayFactory.{h,m}'

    end

    s.subspec 'UnionPay' do |un|

    un.dependency 'ICPaySDK/ICPayManager'
    un.dependency 'UnionPay_SDK_iOS'
    un.source_files = 'ICPaySDK/Classes/ICUnionpayFactory.{h,m}'

    end

end
