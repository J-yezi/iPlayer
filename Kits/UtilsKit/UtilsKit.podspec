Pod::Spec.new do |s|

    s.version      = '0.0.1'
    s.homepage     = 'UtilsKit'
    s.license      = 'MIT'
    s.author       = { '' => '' }
    s.source       = { :git => '', :tag => s.version }
    

    s.name         = 'UtilsKit'
    s.summary      = '工具'

    s.ios.deployment_target = '9.0'

    s.source_files = 'UtilsKit/**/*'
    s.frameworks   = 'UIKit'
    
    s.dependency 'RxSwift'
    s.dependency 'RxCocoa'

end
