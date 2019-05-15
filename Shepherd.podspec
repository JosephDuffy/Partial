Pod::Spec.new do |spec|
  spec.name         = "Partial"
  spec.version      = "0.1.0"
  spec.summary      = <<-SUMM
                   Partial implemented in Swift
                   SUMM
  spec.description  = <<-DESC
                   Partial implemented in Swift
                   DESC
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