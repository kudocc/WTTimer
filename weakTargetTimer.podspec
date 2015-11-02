Pod::Spec.new do |s|

  s.name         = "weakTargetTimer"
  s.version      = "0.0.1"
  s.summary      = "Weak target timer for iOS."
  s.homepage     = "https://github.com/kudocc/WTTimer"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "KudoCC" => "cangmuma@gmail.com" }

  s.ios.deployment_target = "6.0"

  s.source       = { :git => "https://github.com/kudocc/WTTimer.git", :tag => "0.0.1" }
  s.source_files = "weakTargetTimer/*.{h,m}"

  s.requires_arc = true
end
