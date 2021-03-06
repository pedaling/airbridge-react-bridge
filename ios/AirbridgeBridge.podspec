
Pod::Spec.new do |s|
  s.name         = "AirbridgeBridge"
  s.version      = "1.0.0"
  s.summary      = "AirbridgeBridge"
  s.description  = <<-DESC
                  AirbridgeBridge
                   DESC
  s.homepage     = "http://www.example.com"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/AirbridgeBridge.git", :tag => "master" }
  s.source_files  = "*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  s.dependency "AirBridge"
  #s.dependency "others"

end

  
