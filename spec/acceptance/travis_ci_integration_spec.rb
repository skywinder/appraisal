require "spec_helper"

describe "Travis CI integration" do
  context "When user has .travis.yml" do
    context "with incorrect gemfiles directive" do
      it "displays a warning with correct directive"
    end

    context "with correct gemfiles directive" do
      it "does not display any warning"
    end
  end

  context "when user does not have .travis.yml" do
    context "with --travis flag" do
      it "displays gemfiles directive for .travis.yml"
    end

    context "without --travis flag" do
      it "display suggestion about --travis flag"
    end
  end
end
