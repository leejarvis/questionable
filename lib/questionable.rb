module Questionable
  VERSION = '0.1.0'

  # Extend `klass` with Questionable. This means nothing more than
  # a user can use both `include` and `extend`
  #
  # @param [Class] klass
  def self.included(klass)
    klass.extend self
  end

  # Add questionable items
  #
  # @example
  #   class Person
  #     include Questionable
  #
  #     questionable :name, :age
  #     questionable :has_password? => :password
  #
  #     questionable :friends_with_robert? => :friends do |friends|
  #       friends.include? 'Robert'
  #     end
  #
  #     questionable :has_friend? => :friends do |friends, friend|
  #       friends.include? friend
  #     end
  #
  #     def initialize(name, age, password=nil)
  #       @name = name
  #       @age = age
  #       @password = password
  #       @friends = ['Phil', 'Robert']
  #     end
  #   end
  #
  #   roy = Person.new 'Roy', 36, 'Sekret!!'
  #   roy.name? #=> true
  #   roy.has_password? #=> true
  #   roy.friends_with_robert? #=> true
  #
  #   dave = Person.new 'Dave', 42
  #   dave.age? #=> true
  #   dave.has_password? #=> false
  #   dave.has_friend? 'Steve' #=> false
  def questionable(*items, &block)
    if items.first.respond_to? :keys
      __create_questionable_method *items[0].shift, &block
    else
      if items.size == 1
        __create_questionable_method items.shift, &block
      else
        items.each { |i| __create_questionable_method i, &block }
      end
    end
  end

  private

  def __create_questionable_method(to, from=nil, &block)
    from ||= to
    meth_name = to.to_s.chomp('?').insert(-1, '?').to_sym
    ivar = from.to_s.sub(/\A@/, '').insert(0, '@').chomp('?')

    if block_given?
      define_method(meth_name) do |*a|
        if instance_variable_defined? ivar
          yield instance_variable_get(ivar), *a
        else
          raise RuntimeError, "Instance variable #{ivar} is undefined"
        end
      end
    else
      define_method(meth_name) do
        if instance_variable_defined? ivar
          !!instance_variable_get(ivar)
        else
          raise RuntimeError, "Instance variable #{ivar} is undefined"
        end
      end
    end
  end

end
