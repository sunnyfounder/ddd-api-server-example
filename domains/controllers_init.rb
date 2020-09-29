Dir.glob(File.join(Dir.pwd, '/domains/*/controllers/*.rb')).each do |file|
  require_relative file
end
