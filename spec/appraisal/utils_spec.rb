require 'spec_helper'
require 'appraisal/utils'

describe Appraisal::Utils do
  describe '.format_string' do
    it 'prints out a nice looking hash without a brackets' do
      hash = { :foo => 'bar', 'baz' => { :ball => 'boo' } }

      expect(Appraisal::Utils.format_string(hash)).to eq(
        ':foo => "bar", "baz" => { :ball => "boo" }'
      )
    end
  end

  describe '.format_arguments' do
    it 'prints out arguments without enclosing square brackets' do
      arguments = [:foo, bar: { baz: 'ball' }]

      expect(Appraisal::Utils.format_arguments(arguments)).to eq(
        ':foo, :bar => { :baz => "ball" }'
      )
    end

    it "returns nil if arguments is empty" do
      arguments = []

      expect(Appraisal::Utils.format_arguments(arguments)).
        to eq(nil)
    end
  end

  describe ".prefix_path" do
    it "prepends two dots in front of relative path" do
      expect(Appraisal::Utils.prefix_path("test")).to eq "../test"
    end

    it "replaces single dot with two dots" do
      expect(Appraisal::Utils.prefix_path(".")).to eq "../"
    end

    it "ignores absolute path" do
      expect(Appraisal::Utils.prefix_path("/tmp")).to eq "/tmp"
    end

    it "strips out './' from path"  do
      expect(Appraisal::Utils.prefix_path("./tmp/./appraisal././")).
        to eq "../tmp/appraisal./"
    end

    it "does not prefix Git uri" do
      expect(Appraisal::Utils.prefix_path("git@github.com:bacon/bacon.git")).
        to eq "git@github.com:bacon/bacon.git"
      expect(Appraisal::Utils.prefix_path("git://github.com/bacon/bacon.git")).
        to eq "git://github.com/bacon/bacon.git"
      expect(
        Appraisal::Utils.prefix_path("https://github.com/bacon/bacon.git")
      ).to eq("https://github.com/bacon/bacon.git")
    end
  end
end
