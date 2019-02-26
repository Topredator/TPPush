
Pod::Spec.new do |s|
  s.name             = 'TPPush'
  s.version          = '0.0.1'
  s.summary          = 'A short description of TPPush.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Topredator/TPPush'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Topredator' => 'luyanggold@163.com' }
  s.source           = { :git => 'https://github.com/Topredator/TPPush.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'TPPush/Classes/TPPush.h'
  s.static_framework = true
  s.subspec 'Base' do |ss|
    ss.source_files = 'TPPush/Classes/Base/**/*'
    ss.private_header_files = 'TPPush/Classes/Base/TPPushMethodSwizzling.h'
  end

  s.subspec 'GT' do |ss|
    ss.source_files = 'TPPush/Classes/GT/**/*'
    ss.dependency 'TPPush/Base'
    ss.dependency 'GTSDK', '~> 2.3.1.0'
  end

end
