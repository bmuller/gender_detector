require 'minitest/autorun'
require 'sexmachine'

class SexMachineTest < MiniTest::Test
  def setup
    @d = SexMachine::Detector.new
  end

  def test_get_gender
    assert_equal :male, @d.get_gender("Bob")
    assert_equal :female, @d.get_gender("Sally")
    assert_equal :andy, @d.get_gender("Pauley")
  end

  def test_gender_international
    assert @d.knows_country?(:great_britain)
    assert_equal :female, @d.get_gender("Álfrún")
  end

  def test_country_specific_preference
    assert_equal :female, @d.get_gender("Jamie")
    assert_equal :mostly_male, @d.get_gender("Jamie", :great_britain) #jamie oliver?
  end

  def test_case_insensitivity
    d = SexMachine::Detector.new(:case_sensitive => false)
    assert_equal :female, d.get_gender("sally")
    assert_equal :female, d.get_gender("Sally")
  end
end
