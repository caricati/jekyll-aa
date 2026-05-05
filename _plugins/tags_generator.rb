require "jekyll/utils"

module Jekyll
  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base

      slug = Jekyll::Utils.slugify(tag, mode: "latin")

      @dir  = "tag/#{slug}"

      @basename = "index"
      @ext      = ".html"
      @name     = "index.html"

      self.process(@name)
      self.read_yaml(File.join(base, "_layouts"), "tag.html")

      self.data["tag"] = tag
      self.data["slug"] = slug
      self.data["title"] = "Tag: #{tag}"
    end
  end

  class TagGenerator < Generator
    safe true

    def generate(site)
      site.tags.each_key do |tag|
        site.pages << TagPage.new(site, site.source, "tag", tag)
      end
    end
  end
end