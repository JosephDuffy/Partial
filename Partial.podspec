Pod::Spec.new do |spec|
  spec.name         = "Partial"
  spec.version      = "0.1.0"
  spec.summary      = "Type-safe wrapper to make a type's properties all optional via KeyPaths"
  spec.description  = "Type-safe wrapper to make a type's properties all optional via KeyPaths, with extra convenience for creating instances, unwrapping individual properties, and building an instance with multiple pieces of code contributing values"
  spec.homepage     = "https://github.com/JosephDuffy/Partial"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = "Joseph Duffy"
  spec.source       = {
    :git => "https://github.com/JosephDuffy/Partial.git",
    :tag => "v#{spec.version}"
  }
  spec.source_files = "Source/**/*.{swift,h,m}"
  spec.ios.deployment_target = '8.0'
end