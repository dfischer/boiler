namespace :plugin do
  desc 'Install a plugin using braid'
  task :install, :repository do |t, args|
    unless args.repository.nil?
      base_name = File.basename(args.repository, ".git")
      target = "vendor/plugins/#{base_name}"
      unless File.exists?(target)
        system('braid', 'add', args.repository, target)
        system('ruby', 'script/runner', "#{target}/install.rb") if File.exists?("#{target}/install.rb")
      else
        system('braid', 'update', target)
      end 
    else
      puts "Usage: rake plugin:install <repository>"
    end
  end
end