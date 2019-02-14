
Pod::Spec.new do |s|

  s.name         = "HLPhoto"
  s.version      = "1.0.0"
  s.summary      = "基于Photo简单封装，便于获取图片"
  s.description  = <<-DESC
  pod私有库-照片访问。
                   DESC

  s.homepage     = "https://github.com/yuhongli1989/PhotoDemo"

  s.license      = "MIT"
  s.author             = { "yuhongli" => "753597827@qq.com" }
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/yuhongli1989/PhotoDemo/.git", :tag => "#{s.version}" }

  s.source_files  = 'HLPhoto/*.swift'
  s.frameworks = 'UIKit', 'Photos'
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

   s.requires_arc = true



end
