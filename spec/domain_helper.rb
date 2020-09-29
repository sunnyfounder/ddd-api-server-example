Dir['domains/*/usecases/*.rb'].each do |file|
  require "#{Dir.pwd}/#{file}"
end
