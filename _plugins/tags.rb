module Jekyll

  class TagGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? site.config['tag']['layout']  # If the layout for the tags exists
        site.tags.keys.each do |tag|  # Loop on all the tags used
          paginate(site, tag)
        end
      end
    end

    def paginate(site, tag)  # Create all the pages for a specific tag
      tag_posts = site.posts.find_all {|post| post.tags.include?(tag)}.sort_by {|post| -post.date.to_f}
      num_pages = TagPager.calculate_pages(tag_posts, site.config['paginate'].to_i)

      (1..num_pages).each do |page|
        pager = TagPager.new(site, page, tag_posts, tag, num_pages)
        tag_url = tag.downcase.tr(' ', '-')
        dir = File.join(site.config['tag']['path'], tag_url, page > 1 ? site.config['tag']['paginate_path'].gsub(":num", page.to_s) : '')
        page = TagPage.new(site, site.source, dir, tag)
        page.pager = pager
        site.pages << page
      end
    end
  end

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), site.config['tag']['layout'] + '.html')
      self.data['tag'] = tag
      self.data['tag_url'] = tag.downcase.tr(' ', '-')
      site.config['tag']['page_data'].each do |data|
        self.data[data[0]] = data[1].gsub("{}", tag)
      end
    end
  end

  class TagPager < Jekyll::Paginate::Pager
    attr_reader :tag

    def initialize(site, page, all_posts, tag, num_pages = nil)
      @tag = tag
      super site, page, all_posts, num_pages
    end

    alias_method :original_to_liquid, :to_liquid

    def to_liquid
      liquid = original_to_liquid
      liquid['tag'] = @tag
      liquid
    end
  end

  module Filters
    def tag_slug(tag)
      tag.downcase.tr(' ', '-')
    end
  end
end
