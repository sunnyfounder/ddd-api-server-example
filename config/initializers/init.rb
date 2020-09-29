Dir.glob(File.join(Dir.pwd, '/config/initializers/*.rb')).each do |file|
  require_relative file
end
