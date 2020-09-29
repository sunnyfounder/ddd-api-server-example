Dir.glob(File.join(Dir.pwd, '/domains/*/workers/*.rb')).each do |file|
  require_relative file
end
