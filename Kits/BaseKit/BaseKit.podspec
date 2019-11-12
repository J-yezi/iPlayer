Pod::Spec.new do |s|

    s.version      = '0.0.1'
    s.homepage     = 'BaseKit'
    s.license      = 'MIT'
    s.author       = { '' => '' }
    s.source       = { :git => '', :tag => s.version }
    

    s.name         = 'BaseKit'
    s.summary      = '父类'

    s.ios.deployment_target = '9.0'

    s.source_files = 'BaseKit/**/*'
    s.frameworks   = 'UIKit'

end
