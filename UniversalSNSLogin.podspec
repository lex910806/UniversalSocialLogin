#
# Be sure to run `pod lib lint UniversalSNSLogin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UniversalSNSLogin'
  s.version          = '0.1.0'
  s.summary          = 'Package for Naver, Kakao, Facebook, Google'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://Lee-JiHoon@bitbucket.org/2jihoon/universalsociallogin_cocoapods'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lex910806' => 'lex910806@gmail.com' }
  s.source           = { :git => 'https://Lee-JiHoon@bitbucket.org/2jihoon/universalsociallogin_cocoapods.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.instagram.com/_2jihoon/'

  s.ios.deployment_target = '9.0'

  s.source_files = 'UniversalSNSLogin/Classes/**/*'
  s.dependency 'naveridlogin-sdk-ios'
  s.dependency 'Firebase/Auth'
  s.dependency 'GoogleSignIn'
  s.dependency 'FBSDKLoginKit'
  s.vendored_frameworks = 'KakaoOpenSDK.framework'
end
