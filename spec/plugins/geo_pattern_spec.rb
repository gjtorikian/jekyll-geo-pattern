require "spec_helper"

describe "Geo Pattern Tag" do
  def setup(file, layout)
    @post = setup_post(file)
    do_render(@post, layout)
  end

  context "base64_string" do
    it "understands basic geopattern" do
      setup("1984-03-06-basic-geopattern-base64.md", "basic_geopattern_base64.html")
      expect(@post.output).to match /PHN2ZyB4bWxucz0iaHR0cDovL3d3dy/
    end

    it "fails for geopattern missing text" do
      expect { setup("1984-03-06-geopattern-missing-text-base64.md", "geopattern_missing_text_base64.html") }.to raise_error
    end
  end
end
