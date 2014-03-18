require 'geo_pattern'

module Jekyll
  module GeoPatterns
    VALID_KEYS = %w(:base_color :color :generator :text)
    VALID_SYNTAX = /([\w-]+)\s*=\s*(?:"([^"\\]*(?:\\.[^"\\]*)*)"|'([^'\\]*(?:\\.[^'\\]*)*)'|([\w\.-]+))/

    # from a string of options, construct a hash, without using `eval`
    def self.extract_options( input, context )
      opts = {}
      markup = input

      while match = VALID_SYNTAX.match(markup) do
        markup = markup[match.end(0)..-1]

        value = if match[2]
          match[2].gsub(/\\"/, '"')
        elsif match[3]
          match[3].gsub(/\\'/, "'")
        elsif match[4]
          context[match[4]]
        end

        opts[match[1].to_sym] = value
      end
      GeoPatterns.scrub_options(opts, context)
    end

    def self.scrub_options(opts, context)
      opts.each do |opt, value|
        next if value.nil? # ignore properties that have no corresponding value

        value.gsub! /"|'/, ""

        if value =~ /^(\w+?(\.[\w]+)*)/i
          context_val = GeoPatterns.look_up(context, $1)
          opts[opt] = context_val unless context_val.nil?
        end
      end
      opts
    end

    # set it up such that variables, like `post.title`, are still processed
    def self.look_up(context, name)
      lookup = context

      name.split(".").each do |value|
        lookup = lookup[value]
      end

      lookup
    end

    class Base64GeoPattern < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        opts = GeoPatterns.extract_options(@text, context)

        raise ArgumentError, "You must have the :text property passed in" if opts[:text].nil?

        GeoPattern.generate(opts[:text], opts).base64_string
      end
    end

    class SVGGeoPattern < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        opts = GeoPatterns.extract_options(@text, context)

        raise ArgumentError, "You must have the :text property passed in" if opts[:text].nil?

        GeoPattern.generate(opts[:text], opts).svg_string
      end
    end

    class UriImageGeoPattern < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        opts = GeoPatterns.extract_options(@text, context)

        raise ArgumentError, "You must have the :text property passed in" if opts[:text].nil?

        GeoPattern.generate(opts[:text], opts).uri_image
      end
    end
  end
end

Liquid::Template.register_tag('base64_geo_pattern', Jekyll::GeoPatterns::Base64GeoPattern)
Liquid::Template.register_tag('svg_geo_pattern', Jekyll::GeoPatterns::SVGGeoPattern)
Liquid::Template.register_tag('uri_geo_pattern', Jekyll::GeoPatterns::UriImageGeoPattern)
