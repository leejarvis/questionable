require 'helper'

class Klass
  extend Questionable

  questionable :foo, :bar, :missing
  questionable :has_password => :password
  questionable :has_missing? => :missing

  questionable :has_ralf? do |i|
    i.include? 'Ralf'
  end

  questionable :has_person? => :people do |v, person|
    v.include? person
  end

  def initialize
    @foo, @bar = true, false
    @password = "sekret"
    @has_ralf = ['Ralf']
    @people = ['Lee', 'Rob']
  end
end

class QuestionableTest < TestCase
  def setup
    @klass = Klass.new
  end

  test 'questioning multiple vars' do
    assert @klass.foo?
    refute @klass.bar?
    assert_raises(RuntimeError, /@missing/) { @klass.missing? }
  end

  test 'alias/hash syntax' do
    assert @klass.has_password?
    assert_raises(RuntimeError, /@missing/) { @klass.has_missing? }
  end

  test 'blocks' do
    assert @klass.has_ralf?
    assert @klass.has_person? 'Lee'
    refute @klass.has_person? 'Ralf'
  end

end