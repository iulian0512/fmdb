Pod::Spec.new do |s|
  s.name = 'FMDB'
  s.version = '2.7.8'
  s.summary = 'A Cocoa / Objective-C wrapper around SQLite.'
  s.homepage = 'https://github.com/ccgus/fmdb'
  s.license = 'MIT'
  s.author = { 'August Mueller' => 'gus@flyingmeat.com' }
  s.source = { :git => 'https://github.com/iulian0512/fmdb.git', :branch => "master" }
  s.requires_arc = true
  s.ios.deployment_target = '12.0'
  s.default_subspec = 'spatialite'
  s.prepare_command = <<-CMD
    wget "https://intergraphro-my.sharepoint.com/:u:/g/personal/iulian_ingr_ro/Ed6UxDdxklROveoFFsGOG1QBoZJ3NYOVsRklPVnHa4vzUg?e=BQPCuH&download=1" -O libspatialite510_xcframework.zip && 
    unzip -o libspatialite510_xcframework.zip -d .
CMD
  
  # use sqlite3 + spatialite from libspatialite.xcframework 
  s.subspec 'spatialite' do |ss|
    ss.source_files = 'src/fmdb/FM*.{h,m}'
    ss.exclude_files = 'src/fmdb.m'
    ss.header_dir = 'fmdb'
    ss.vendored_frameworks = 'libspatialite.xcframework'
    ss.libraries= 'c++','iconv','charset','z'
  end
    
end
