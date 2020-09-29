Dir.glob(File.join(File.dirname(__FILE__), '*.rb')).each do |file|
  require_relative file
end
