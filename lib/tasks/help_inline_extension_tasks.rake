namespace :radiant do
  namespace :extensions do
    namespace :help_inline do
      
      desc "Runs the migration of the Help Inline extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          HelpInlineExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          HelpInlineExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Help Inline to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[HelpInlineExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(HelpInlineExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
