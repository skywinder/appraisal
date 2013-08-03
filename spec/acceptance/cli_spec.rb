require 'spec_helper'

describe 'CLI' do
  context 'appraisal' do
    it 'runs generate command' do
      build_appraisal_file <<-Appraisal
        appraise '1.0.0' do
          gem 'dummy', '1.0.0'
        end
      Appraisal

      run_simple 'appraisal'

      expect_file('gemfiles/1.0.0.gemfile').to be_exists
    end
  end

  context 'appraisal generate' do
    it 'generates the gemfiles' do
      build_appraisal_file <<-Appraisal
        appraise '1.0.0' do
          gem 'dummy', '1.0.0'
        end

        appraise '1.1.0' do
          gem 'dummy', '1.1.0'
        end
      Appraisal

      run_simple 'appraisal generate'

      expect_file('gemfiles/1.0.0.gemfile').to be_exists
      expect_file('gemfiles/1.1.0.gemfile').to be_exists
      expect_file('gemfiles/1.0.0.gemfile').to contains <<-gemfile.strip_heredoc
        # This file was generated by Appraisal

        source "https://rubygems.org"

        gem "appraisal", :path=>"../../"
        gem "dummy", "1.0.0"
      gemfile
    end
  end
end
