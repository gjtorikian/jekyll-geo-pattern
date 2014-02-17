require 'geo_pattern'

module Jekyll
  module GeoPatterns
    HASH_REGEXP = /\{.+?\}/
    VALID_KEYS = %w(base_color generator text)

    # from a string of options, construct a hash, without using `eval`
    def self.extract_options( input )
      opts = Hash.new
      input[1..-2].split(/, /).each do |entry|
        entryMap = entry.split(/\=>/)
        key = entryMap[0].strip[1..-1]
        next unless VALID_KEYS.include? key
        value = entryMap[1]
        opts[key.to_sym] = value.nil? ? nil : value.strip[1..-2]
      end
      opts
    end

    class Base64GeoPattern < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        if m = HASH_REGEXP.match(text)
          @opts = GeoPatterns.extract_options(m[0])
        end
      end

      def render(context)
        text = @opts.delete(:text)
        GeoPattern.generate(text, @opts).base64_string
      end
    end

    class SVGGeoPattern < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        if m = HASH_REGEXP.match(text)
          @opts = GeoPatterns.extract_options(m[0])
        end
      end

      def render(context)
        text = @opts.delete(:text)
        GeoPattern.generate(text, @opts).svg_string
      end
    end
  end
end

Liquid::Template.register_tag('base64_geo_pattern', Jekyll::GeoPatterns::Base64GeoPattern)
Liquid::Template.register_tag('svg_geo_pattern', Jekyll::GeoPatterns::SVGGeoPattern)
