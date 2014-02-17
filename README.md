# Geo Pattern Plugin

A liquid tag for Jekyll to generate an SVG/Base64 geo pattern. Based on https://github.com/jasonlong/geo_pattern.

[![jekyll-geo-pattern build status](https://api.travis-ci.org/gjtorikian/jekyll-geo-pattern.png?branch=master)](https://travis-ci.org/gjtorikian/jekyll-geo-pattern)

## Setting up

Add the following to your site's `_config.yml` file

```yml
gems:
  - jekyll-geo-pattern
```

## Usage

You can choose to generate either a Base64 encoded string:

```
{% base64_geo_pattern {:text => "Mastering Markdown"} %}
```

Or, an SVG image:

```
{% svg_geo_pattern {:text => "Mastering Markdown"} %}
```

Note that you **must** provide a rocket-style hash as a parameter, and it **must**
have at lest the `:text` key. The geopattern is generated from this text.

You can also pass in the other options from the geo_pattern library:

```
{% base64_geo_pattern {:text => "Some title", :base_color => "#fc0"} %}
{% svg_geo_pattern {:text => "Another title", :generator => "sine_waves"} %}
```

With the Base64 pattern, you can generate something like this as a visual element:

```
<div style="background-image:{% base64_geo_pattern {:text => 'Mastering Markdown'} %}"></div>
```
