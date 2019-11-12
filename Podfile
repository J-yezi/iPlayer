platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!

def read_local_kit_or_modules(path)
 Dir.entries(path).each do |sub|
     if sub != '.' && sub != '..'
         relativePath = "#{path}/#{sub}"
         if File.directory?(relativePath)
             # only dig one level
             yield sub, path
         end
     end
 end
end

target 'iPlayer' do
  
  pod 'CcExtensions'
  pod 'SnapKit'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'LookinServer', :configurations => ['Debug']
  pod 'lottie-ios', '2.5.3'

  # 添加工具
  read_local_kit_or_modules 'Kits' do |name, path|
    puts "auto-add kits: pod '#{name}', :path => '#{path}/#{name}'"
    pod name, :path => "#{path}/#{name}"
  end

end
