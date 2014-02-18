require 'geo_pattern'

module Jekyll
  module GeoPatterns
    HASH_REGEXP = /\{(.+?)\}/
    VALID_KEYS = %w(:base_color :generator :text)

    # from a string of options, construct a hash, without using `eval`
    def self.extract_options( input )
      opts = Hash.new
      input.split(/, /).each do |entry|
        entryMap = entry.split(/\=>/)
        key = entryMap[0].strip
        next unless VALID_KEYS.include? key
        value = entryMap[1]
        opts[key.strip[1..-1].to_sym] = value.nil? ? nil : value.strip
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

    def self.scrub_options(opts, context)
      opts.each do |opt, value|
        value.gsub! /"|'/, ""

        if value =~ /([\w]+(\.[\w]+)*)/i
          context_val = GeoPatterns.look_up(context, $1)
          opts[opt] = context_val unless context_val.nil?
        end
      end
      opts
    end

    class Base64GeoPattern < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        m = HASH_REGEXP.match(@text)
        opts = GeoPatterns.extract_options(m[1])

        raise ArgumentError, "You must have the :text property passed in" if opts[:text].nil?

        opts = GeoPatterns.scrub_options(opts, context)
        GeoPattern.generate(opts[:text], opts).base64_string
      end
    end

    class SVGGeoPattern < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        m = HASH_REGEXP.match(@text)
        opts = GeoPatterns.extract_options(m[1])

        raise ArgumentError, "You must have the :text property passed in" if opts[:text].nil?

        opts = GeoPatterns.scrub_options(opts, context)
        GeoPattern.generate(opts[:text], opts).svg_string
      end
    end
  end
end

Liquid::Template.register_tag('base64_geo_pattern', Jekyll::GeoPatterns::Base64GeoPattern)
Liquid::Template.register_tag('svg_geo_pattern', Jekyll::GeoPatterns::SVGGeoPattern)
