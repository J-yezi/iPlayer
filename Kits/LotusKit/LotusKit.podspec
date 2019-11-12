Pod::Spec.new do |s|

    s.version      = '0.0.1'
    s.homepage     = 'LotusKit'
    s.license      = 'MIT'
    s.author       = { '' => '' }
    s.source       = { :git => '', :tag => s.version }
    

    s.name         = 'LotusKit'
    s.summary      = '模块间调用协议'

    s.ios.deployment_target = '9.0'

    s.source_files = 'LotusKit/**/*'
    s.frameworks   = 'UIKit'

end
