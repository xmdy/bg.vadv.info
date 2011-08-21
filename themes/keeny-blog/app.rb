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
    end
  end

  class Page
    def self.nav_items
      menu = Nesta::Config.content_path("navigation.txt")
      pages = []
      if File.exist?(menu)
        File.open(menu).each { |line| pages << Page.load(line.chomp) }
      end
      pages
    end

    def hide_comments
      @hide_comments = metadata("hide comments") || false;
    end

    def menu_title
      @menu_title = metadata("menu title") || "";
    end
  end
end
