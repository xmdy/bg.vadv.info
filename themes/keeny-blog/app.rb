# Use the app.rb file to load Ruby code, modify or extend the models, or
# do whatever else you fancy when the theme is loaded.

module Nesta
  class App
    # This code tells Nesta to look for assets in the theme's public folder.
    # Highly recommended if your theme contains images or JavaScript.
    #
    # Put your assets in themes/keeny/public/keeny.
    #
    # use Rack::Static, :urls => ["/keeny"], :root => "themes/keeny/public"

    helpers do
      def set_common_variables
        @menu_items = Page.menu_items
        @nav_items = Page.nav_items
        @site_title = Nesta::Config.title
        set_from_config(:title, :subtitle, :google_analytics_code)
        @heading = @title
      end

			def current_page?(page)
				current_url? '/'+page.path
			end
			
			def current_url?(url)
				# LOGGER.info "CURRENT: #{request.path_info} URL: #{url}"
				# TODO: If subpage then return "child"
				(url == request.path_info)? "current" : ""
			end
			
    end
  end

end

class Page < FileModel
  module ClassMethods
    def menu_items
      menu = Nesta::Config.content_path("menu.txt")
      pages = []
      if File.exist?(menu)
        File.open(menu).each { |line| pages << Page.load(line.chomp) }
      end
      pages
    end

		def nav_items
      top_nav = Nesta::Config.content_path("top_navigation.txt")
      pages = []
      if File.exist?(top_nav)
        File.open(top_nav).each { |line| pages << Page.load(line.chomp) }
      end
      pages
    end
  end

  extend ClassMethods

	def hide_comments
    @hide_comments = metadata("hide comments") || false;
  end

  def menu_title
    @menu_title = metadata("menu title") || "";
  end

end