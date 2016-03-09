require 'rake'

def full_path
  return "#{Options.path}/#{Options.app_name}".gsub(/\/\//, "/")
end


task :make_app_direcotry do
  unless Dir.exists?(Options.path)
    puts "Folder '#{Options.path.underline.bright}' does not exist!"
    exit
  end

  Dir.chdir(Options.path)

  if Dir.exists?(Options.app_name)
    # app directory already exist, ask if the user wants to continue
    menu = Carbonara::Menu.new("The folder #{full_path.color(:green)} already exists. Do you want to continue?")
    menu.on('y') # continue
    menu.on('n', default: true){ exit }
    menu.run!
  else
    # make a new directory for the application
    Dir.mkdir(Options.app_name)
    puts "\tcreate\t#{full_path}".color(:green).bright
  end

  # move into application directory
  Dir.chdir(Options.app_name)
end


task :add_gemfile do
  if File.exists?('Gemfile')
    menu = Carbonara::Menu.new("Gemfile".color(:green) + " already exists. Do you want to overwrite the Gemfile?")
    menu.on('y') { Rake::Task[:write_gemfile].invoke }
    menu.on('n', default: true) # continue
    menu.run!
  else
    Rake::Task[:write_gemfile].invoke
  end
end


task :write_gemfile do
  IO.write 'Gemfile', <<-EOF
source "https://rubygems.org"

# Fleck gem allows you to define consumer and clients which
# comunicate over RabbitMQ service by sending JSON messages
gem 'fleck'

# Idler is a tiny gem that allows you to make the current thread
# to wait until an another thread will wakeup it
gem 'idler'

# An useful gem for configurations management
gem 'configatron'
EOF
end


task :install_bundler do
  begin
    require 'bundler'
    puts "bundler".color(:green) + " gem already installed"
  rescue LoadError
    # bundler is not installed
    puts "going to install " + "bundler".color(:green) + " gem"
    sh 'gem install bundler'
  end
end


task :install_gems do
  sh 'bundle install'
end


task :new do
  Rake::Task[:make_app_direcotry].invoke
  Rake::Task[:add_gemfile].invoke
  Rake::Task[:install_bundler].invoke
  Rake::Task[:install_gems].invoke
end