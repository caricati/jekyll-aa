# require "jekyll/utils"

# module Jekyll

#   class TagPage < Page

#     def initialize(site, base, dir, tag, lang)

#       @site = site
#       @base = base

#       slug = Jekyll::Utils.slugify(tag, mode: "latin")

#       if lang == "en"
#         @dir = "en/tag/#{slug}"
#       else
#         @dir = "tag/#{slug}"
#       end

#       @basename = "index"
#       @ext      = ".html"
#       @name     = "index.html"

#       self.process(@name)

#       self.read_yaml(
#         File.join(base, "_layouts"),
#         "tag.html"
#       )

#       self.data["layout"] = "tag"

#       self.data["tag"] = tag
#       self.data["slug"] = slug
#       self.data["lang"] = lang
#       self.data["ref"] = "tag-#{slug}"

#       if lang == "en"

#         self.data["title"] =
#           "Tag: #{tag}"

#         self.data["description"] =
#           "Explore related articles about #{tag} and discover automotive news, reviews, launches, and trends."

#       else

#         self.data["title"] =
#           "Tag: #{tag}"

#         self.data["description"] =
#           "Explore artigos relacionados à tag #{tag} e descubra notícias, reviews, lançamentos e tendências automotivas."

#       end

#     end

#   end

#   class TagGenerator < Generator

#     safe true

#     def generate(site)

#       pt_tags = {}
#       en_tags = {}

#       site.posts.docs.each do |post|

#         post.data["tags"]&.each do |tag|
#           pt_tags[tag] = true
#         end

#       end

#       if site.collections["posts_en"]

#         site.collections["posts_en"].docs.each do |post|

#           post.data["tags"]&.each do |tag|
#             en_tags[tag] = true
#           end

#         end

#       end

#       pt_tags.keys.each do |tag|
#         site.pages << TagPage.new(
#           site,
#           site.source,
#           "tag",
#           tag,
#           "pt"
#         )
#       end

#       en_tags.keys.each do |tag|
#         site.pages << TagPage.new(
#           site,
#           site.source,
#           "tag",
#           tag,
#           "en"
#         )
#       end

#     end

#   end

# end