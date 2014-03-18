require "spec_helper"

describe "Geo Pattern Tag" do
  def setup(file, layout)
    @post = setup_post(file)
    do_render(@post, layout)
  end

  it "understands all numeral hex colors geopattern" do
    setup("1984-03-06-basic-geopattern-all-nums.md", "basic_geopattern_all_nums.html")
    expect(@post.output).to match /L3d3dy53My5vcmcv/
  end

  it "ignores null properties" do
    setup("1984-03-06-ignore-null-generator.md", "ignore_null_generator.html")
    expect(@post.output).to match /cmcvMjAwMC9zdmciIHdpZHRoPSIyMDMiIGhlaWdodD0iMjAzIj48/
  end

  context "base64_string" do
    it "understands basic geopattern" do
      setup("1984-03-06-basic-geopattern-base64.md", "basic_geopattern_base64.html")
      expect(@post.output).to match /PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmc/
    end

    it "fails for geopattern missing text" do
      expect { setup("1984-03-06-geopattern-missing-text-base64.md", "geopattern_missing_text_base64.html") }.to raise_error
    end

    it "understands base color" do
      setup("1984-03-06-geopattern-base-color-base64.md", "geopattern_base_color_base64.html")
      expect(@post.output).to match /I0LjAiICAvPjwvZz48ZyBmaWxsPSIjZG/
    end

    it "understands generation" do
      setup("1984-03-06-geopattern-generator-base64.md", "geopattern_generator_base64.html")
      expect(@post.output).to match /sZT0ib3BhY2l0eTowLjA2MzMzMzMzMzMzMzMzMzM0O3N0/
    end
  end


  context "svg" do
    it "understands basic geopattern" do
      setup("1984-03-06-basic-geopattern-svg.md", "basic_geopattern_svg.html")
      expect(@post.output).to match /g fill="#ddd" style="opacity:0.14133333333333334;" transform="translate\(-33.948,-33.948\)/
    end

    it "fails for geopattern missing text" do
      expect { setup("1984-03-06-geopattern-missing-text-svg.md", "geopattern_missing_text_svg.html") }.to raise_error
    end

    it "understands base color" do
      setup("1984-03-06-geopattern-base-color-svg.md", "geopattern_base_color_svg.html")
      expect(@post.output).to match /fill=\"#222\" style=\"opacity:0.13266666666666665;\" transform=\"translate\(33.948,169.74\) rotate\(45,/
    end

    it "understands generation" do
      setup("1984-03-06-geopattern-generator-svg.md", "geopattern_generator_svg.html")
      expect(@post.output).to match /opacity:0.08066666666666666;stroke-width:26px;\" transform=\"translate\(-95, 1017.5\)\"/
    end
  end

  context "uri_image" do
    it "understands basic geopattern" do
      setup("1984-03-06-basic-geopattern-uri.md", "basic_geopattern_uri.html")
      expect(@post.output).to match /url\(data:image\/svg\+xml;base64,PHN2ZyB4bWxu/
    end

    it "fails for geopattern missing text" do
      expect { setup("1984-03-06-geopattern-missing-text-uri.md", "geopattern_missing_text_uri.html") }.to raise_error
    end

    it "understands base color" do
      setup("1984-03-06-geopattern-base-color-uri.md", "geopattern_base_color_uri.html")
      expect(@post.output).to match /url\(data:image\/svg\+xml;base64,PHN2ZyB4bWxucz0i/
    end

    it "understands generation" do
      setup("1984-03-06-geopattern-generator-uri.md", "geopattern_generator_uri.html")
      expect(@post.output).to match /url\(data:image\/svg\+xml;base64,PHN2ZyB4bWxucz0ia/
    end
  end
end
