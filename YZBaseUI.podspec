#
# Be sure to run `pod lib lint YZBaseUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YZBaseUI'
  s.version          = '0.4.0'
  s.summary          = '自用的部分控件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Some Base UI
                       DESC

  s.homepage         = 'https://github.com/YuzuWang/YZBaseUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'niansi.no@gmail.com' => 'iwungsc@icloud.com' }
  s.source           = { :git => 'https://github.com/YuzuWang/YZBaseUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'YZBaseUI/Classes/*.h'
  
  # 一些基础库
  s.subspec 'YZBase' do |base|
      base.source_files = 'YZBaseUI/Classes/YZBase/**/*';
  end
  
  # 来自 SJNetwork
  # https://github.com/knightsj/SJNetwork
  s.subspec 'YZNetwork' do |net|
       net.source_files = 'YZBaseUI/Classes/YZNetwork/**/*';
       net.dependency  'AFNetworking', '~> 4.0.1'
  end
  
  # 常用类别
  s.subspec 'YZCategory' do |category|
      category.source_files = 'YZBaseUI/Classes/YZCategory/**/*';
   
  end
  
  # 搜索
  s.subspec 'YZSearch' do |search|
      search.source_files = 'YZBaseUI/Classes/YZSearch/**/*';
      search.dependency  'YZBaseUI/YZCategory';
      search.dependency  'YZBaseUI/YZBase';
      
      search.resource_bundles = {
         'YZBaseUI' => ['YZBaseUI/Assets/*.png','YZBaseUI/Assets/*.nib']
      }
  end
  
  
  # 对 QMUI 等三方的一些封装
  s.subspec 'YZComponents' do |c|
      c.source_files = 'YZBaseUI/Classes/YZComponents/**/*';
        
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
