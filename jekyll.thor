require 'thor'
require 'thor/group'
require 'yaml'

module Jekyll
  class Generator < Thor::Group
    include Thor::Actions
    desc 'Generate a new post'

    def self.source_root
      File.dirname(__FILE__)
    end

    def create_new_post
      config = { created_at: Time.now }
      items = YAML.load_file('config/input_items.yml')
      items.each{|key, msg| config[key.to_sym] = input_gets(msg)}
      post_file_path = "_posts/#{config[:created_at].strftime('%F')}-report1.md"
      template('templates/blog_post.tt', post_file_path, config)
    end

    private

      def input_gets(message)
        print message
        STDIN.gets.chomp
      end
  end
end
