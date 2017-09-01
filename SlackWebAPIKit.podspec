Pod::Spec.new do |s|
  s.name             = 'SlackWebAPIKit'
  s.version          = '0.1.5'
  s.summary          = 'Robust Slack Web API Kit in Swift.'

  s.description      = <<-DESC
                        The easy to use Slack Web API Kit in Swift
                        DESC

  s.homepage         = 'https://github.com/MoralAlberto/SlackWebAPIKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MoralAlberto' => 'alberto.moral.g@gmail.com' }
  s.source           = { :git => 'https://github.com/MoralAlberto/SlackWebAPIKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/albertmoral'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.source_files = 'SlackWebAPIKit/Classes/**/*'
  s.frameworks = 'Foundation'
  s.dependency 'Alamofire', '~> 4.4'
  s.dependency 'ObjectMapper', '~> 2.2.8'
  s.dependency 'RxSwift', '~> 3.0'
end
