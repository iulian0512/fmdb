Pod::Spec.new do |s|
  s.name = 'FMDB'
  s.version = '2.7.8'
  s.summary = 'A Cocoa / Objective-C wrapper around SQLite.'
  s.homepage = 'https://github.com/ccgus/fmdb'
  s.license = 'MIT'
  s.author = { 'August Mueller' => 'gus@flyingmeat.com' }
  s.source = { :git => 'https://github.com/iulian0512/fmdb.git', :tag => "master" }
  s.requires_arc = true
  s.ios.deployment_target = '11.0'
  s.default_subspec = 'spatialite'
  #exclude arm arch from simulator builds
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  # # use sqlite3 + spatialite
  # s.subspec 'spatialite' do |ss|
  #   ss.source_files = 'src/fmdb/FM*.{h,m}' , 'src/spatialite/include/**/*.h'
  #   ss.exclude_files = 'src/fmdb.m'
  #   ss.preserve_paths = 'src/spatialite/include/**/*.h'
  #   #ss.private_header_files = 'src/spatialite/include/**/*.h'
  #   #ss.pod_target_xcconfig = { 'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/FMDB/src/spatialite/include'}
  #   ss.vendored_libraries= 'src/spatialite/lib/*.a'
  #   ss.libraries= 'c++','iconv','charset','z'
  #   ss.header_mappings_dir = "src/spatialite/include"
  #   ss.header_dir = 'src'
  # end

  s.subspec 'spatialite' do |ss|
    ss.source_files = 'src/fmdb/FM*.{h,m}'
    ss.exclude_files = 'src/fmdb.m'
    ss.header_dir = 'fmdb'
    ss.preserve_paths = 'src/spatialite/include/**/*.h'
    ss.pod_target_xcconfig = { 'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/FMDB/src/spatialite/include'}
    ss.vendored_libraries= 'src/spatialite/lib/*.a'
    ss.libraries= 'c++','iconv','charset','z'
  end
  
  # use the built-in library version of sqlite3
  s.subspec 'standard' do |ss|
    ss.library = 'sqlite3'
    ss.source_files = 'src/fmdb/FM*.{h,m}'
    ss.exclude_files = 'src/fmdb.m'
    ss.header_dir = 'fmdb'
  end

  # use the built-in library version of sqlite3 with custom FTS tokenizer source files
  s.subspec 'FTS' do |ss|
    ss.source_files = 'src/extra/fts3/*.{h,m}'
    ss.dependency 'FMDB/standard'
  end

  # build the latest stable version of sqlite3
  s.subspec 'standalone' do |ss|
    ss.xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DFMDB_SQLITE_STANDALONE' }
    ss.dependency 'sqlite3'
    ss.source_files = 'src/fmdb/FM*.{h,m}'
    ss.exclude_files = 'src/fmdb.m'
    ss.header_dir = 'fmdb'
  end

  # build with FTS support and custom FTS tokenizer source files
  s.subspec 'standalone-fts' do |ss|
    ss.xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DFMDB_SQLITE_STANDALONE' }
    ss.source_files = 'src/fmdb/FM*.{h,m}', 'src/extra/fts3/*.{h,m}'
    ss.exclude_files = 'src/fmdb.m'
    ss.header_dir = 'fmdb'
    ss.dependency 'sqlite3/fts'
  end

  # use SQLCipher and enable -DSQLITE_HAS_CODEC flag
  s.subspec 'SQLCipher' do |ss|
    ss.dependency 'SQLCipher', '~> 4.0'
    ss.source_files = 'src/fmdb/FM*.{h,m}'
    ss.exclude_files = 'src/fmdb.m'
    ss.header_dir = 'fmdb'
    ss.xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_HAS_CODEC -DHAVE_USLEEP=1 -DSQLCIPHER_CRYPTO', 'HEADER_SEARCH_PATHS' => 'SQLCipher' }
  end
  
end
