Pod::Spec.new do |s|
  s.name             = 'UniversalSNSLogin'
  s.version          = '0.1.0'
  s.summary          = 'Package for Naver, Kakao, Facebook, Google'
  s.homepage         = 'https://github.com/lex910806/UniversalSocialLogin'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lex910806' => 'lex910806@gmail.com' }
  s.source           = { :git => 'https://github.com/lex910806/UniversalSocialLogin.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.instagram.com/_2jihoon/'

  s.ios.deployment_target = '9.0' # Bacaues of naver...
  s.source_files = 'UniversalSNSLogin/Classes/**/*'

  s.dependency 'naveridlogin-sdk-ios'
  s.dependency 'Firebase/Auth'
  s.dependency 'GoogleSignIn'
  s.dependency 'FBSDKLoginKit'
  s.vendored_frameworks = 'KakaoOpenSDK.framework'
end
