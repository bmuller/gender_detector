# -*- coding: utf-8 -*-
require 'minitest/autorun'
require 'minitest/stub_const'
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gender_detector'
require 'unicode_utils'
require 'active_support/core_ext/string/multibyte'

class GenderDetectorTest < MiniTest::Test
  def setup
    @d = GenderDetector.new
  end

  def test_get_gender
    assert_equal :male, @d.get_gender('Bob')
    assert_equal :female, @d.get_gender('Sally')
    assert_equal :andy, @d.get_gender('Pauley')
  end

  def test_gender_international
    assert @d.knows_country?(:great_britain)
    assert_equal :female, @d.get_gender('Álfrún')
  end

  def test_country_specific_preference
    assert_equal :female, @d.get_gender('Jamie')
    # jamie oliver?
    assert_equal :mostly_male, @d.get_gender('Jamie', :great_britain)
  end

  def test_case_insensitivity
    d = GenderDetector.new(case_sensitive: false)
    assert_equal :female, d.get_gender('sally')
    assert_equal :female, d.get_gender('Sally')
  end

  def test_name_exists
    d = GenderDetector.new(case_sensitive: false)
    assert d.name_exists?('Sally')
    assert d.name_exists?('Carlos')
    assert d.name_exists?('Rosario')
  end

  def test_uses_activesupport_if_available
    Object.stub_remove_const(:UnicodeUtils) do
      d = GenderDetector.new(case_sensitive: false)
      assert_equal :male, d.get_gender('Bob')
      assert_equal :female, d.get_gender('ÁLFRÚN')
    end
  end

  def test_works_without_dependencies
    Object.stub_remove_const(:UnicodeUtils) do
      ActiveSupport::Multibyte.stub_remove_const(:Chars) do
        d = GenderDetector.new(case_sensitive: false)
        assert_equal :male, d.get_gender('Bob')
        # doesn't work on unicode names anymore
        assert_equal :andy, d.get_gender('ÁLFRÚN')
      end
    end
  end
end
