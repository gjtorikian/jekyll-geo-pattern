require "spec_helper"

describe "Geo Pattern Tag" do
  def setup(file, layout)
    @post = setup_post(file)
    do_render(@post, layout)
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
end
