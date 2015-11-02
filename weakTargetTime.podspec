Pod::Spec.new do |spec|
  spec.name             = "WeakTargetTimer"
  spec.version          = "0.0.1"
  spec.license          = { :type => "MIT", :file => "LICENSE" }
  spec.platform         = :ios, "7.0"
  spec.source           = { :git => "https://github.com/kudocc/WTTimer.git", :tag => "0.0.1" }
  spec.requires_arc     = true
end
