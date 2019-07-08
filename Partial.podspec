Pod::Spec.new do |spec|
  spec.name         = "Partial"
  spec.version      = "1.0.0-rc.4"
  spec.summary      = "Type-safe wrapper to make a type's properties optional"
  spec.description  = "Type-safe wrapper to make a type's properties optional, with extra convenience for creating instances, unwrapping individual properties, and building an instance with multiple pieces of code contributing values"
  spec.homepage     = "https://github.com/JosephDuffy/Partial"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = "Joseph Duffy"
  spec.source       = {
    :git => "https://github.com/JosephDuffy/Partial.git",
    :tag => "v#{spec.version}"
  }
  spec.source_files = "Sources/Partial/*.swift"
  spec.ios.deployment_target = "8.0"
  spec.swift_versions = "5.0"
end
