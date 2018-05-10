Pod::Spec.new do |s|

  s.name          = "PLTransition"
  s.version       = "1.0.0"
  s.summary       = "easy use transition "
  s.license       = 'MIT'
  s.description   = <<-DESC
                   A longer description of PLTransition in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage      = "https://github.com/PLTransition"
  s.author        = { "" => "n" }
  s.platform      = :ios, "7.0"
  s.source        = { :git => "https://github.com/PLTransition.git", :tag => s.version }
  #s.public_header_files = 'PLTransition/PLTransition.h'
  s.source_files  = "PLTransition/*.{h,m}"
  s.frameworks = 'UIKit','CoreGraphics'
  
end
