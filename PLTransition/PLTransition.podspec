Pod::Spec.new do |s|

  s.name          = "PLTransition"
  s.version       = "0.0.1"
  s.summary       = "PLTransition"

  s.description   = <<-DESC
                   A longer description of PLTransition in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage      = "https://github.com/PLTransition"
  s.author        = { "zhuoyi" => "jiangzhuoyi@idongjia.cn" }
  s.platform      = :ios, "7.0"
  s.source        = { :git => "https://github.com/PLTransition.git", :tag => "0.1.0" }

  s.source_files  = "**/*.{h,m}"
  
end
