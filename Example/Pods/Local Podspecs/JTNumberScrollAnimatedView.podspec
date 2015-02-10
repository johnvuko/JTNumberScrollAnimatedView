Pod::Spec.new do |s|
  s.name         = "JTNumberScrollAnimatedView"
  s.version      = "1.0.0"
  s.summary      = "A scroll animation for display number for iOS"
  s.homepage     = "https://github.com/jonathantribouharet/JTNumberScrollAnimatedView"
  s.license      = { :type => 'MIT' }
  s.author       = { "Jonathan Tribouharet" => "jonathan.tribouharet@gmail.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/jonathantribouharet/JTNumberScrollAnimatedView.git", :tag => s.version.to_s }
  s.source_files  = 'JTNumberScrollAnimatedView/*'
  s.requires_arc  = true
  s.screenshots   = ["https://raw.githubusercontent.com/jonathantribouharet/JTNumberScrollAnimatedView/master/Screens/example.gif"]
end
