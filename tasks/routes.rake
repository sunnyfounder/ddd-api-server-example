desc '列出所有路徑'
task :routes do
  require './app'
  routes_array = App.routes.map do |method, routes|
    routes.map { |r| r.first.to_s }.map do |route|
      "#{method.rjust(7, ' ')} #{route}"
    end
  end

  routes_array.flatten.sort.each do |route|
    puts route
  end
end
