#
# Be sure to run `pod lib lint CoreNetWorking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  # 组件名称
  s.name             = 'CoreNetWorkingLib'
  # 组件版本
  s.version          = '0.4.0'
  # 组件概要说明
  s.summary          = '杭州空灵智能科技有限公司基于AFNetworking所开发的网络请求库,支持get、post、upload等功能.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  # 组件详细说明
  s.description      = <<-DESC
  杭州空灵智能科技有限公司基于AFNetworking所开发的网络请求库,支持get、post、upload、以及网络检测等功能.
                       DESC
  # 首页地址
  s.homepage         = 'https://github.com/sunzhenglin/CoreNetWorkingLib'
  # 截图
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  # 许可
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  # 作者
  s.author           = { 'szl' => '393992811@qq.com' }
  # 资源所在地
  s.source           = { :git => 'https://github.com/sunzhenglin/CoreNetWorkingLib.git', :tag => s.version.to_s }
  # 社交URL
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  # 支持的版本
  s.ios.deployment_target = '8.0'
  # 资源文件
  s.source_files = 'CoreNetWorkingLib/Classes/**/*.{h,m}'
  # 依赖
  s.dependency 'AFNetworking', '~> 3.2.1'
  s.dependency 'SVProgressHUD', '~> 2.2.5'
  s.dependency 'TXModel', '~> 1.0.1'
  # 公开的头文件
  s.prefix_header_contents = '#import "CoreNetworking.h"'
end
