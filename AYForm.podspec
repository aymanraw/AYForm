#
# Be sure to run `pod lib lint AYForm.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AYForm'
  s.version          = '0.2.2'
  s.summary          = 'Create forms in swift 3.0, it works by giving your tableview dataSource.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!


#

  s.description      = <<-DESC
Small library that creates forms in swift 3.0, it works by giving your tableview dataSource to the AYForm and the library take cares of returning the cells and saving all fields to future access.
                       DESC

  s.homepage         = 'https://github.com/aymanraw/AYForm'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aymanraw' => 'ayman.rawashdeh@hotmail.com' }
  s.source           = { :git => 'https://github.com/aymanraw/AYForm.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AYForm/**/*','AYForm/AYForm/**/*', 'AYForm/AYForm/*'
  
  # s.resource_bundles = {
  #   'AYForm' => ['AYForm/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/AYForm/*.h'
    s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
