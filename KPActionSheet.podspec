Pod::Spec.new do |s|
  s.name         = "KPActionSheet"
  s.version      = "1.0"
  s.summary      = "A replacement of default action sheet, but has very simple usage."
  s.homepage     = "https://github.com/khuong291/KPActionSheet"
  s.license      = 'MIT'
  s.author       = { "khuong291" => "dkhuong291@gmail.com" }
  s.source       = { :git => "https://github.com/khuong291/KPActionSheet.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = "KPActionSheet", "KPActionSheet/**/*.{h,m,swift}"
end