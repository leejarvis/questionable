Questionable
============

Installation
------------

### RubyGems

    gem install questionable

### GitHub

    git clone git://github.com/injekt/questionable.git
    gem build questionable.gemspec
    gem install questionable-<version>.gem

Usage
-----

```ruby
class Person
  include Questionable

  questionable :name, :age
  questionable :has_password? => :password

  questionable :friends_with_robert? => :friends do |friends|
    friends.include? 'Robert'
  end

  questionable :has_friend? => :friends do |friends, friend|
    friends.include? friend
  end

  def initialize(name, age, password=nil)
    @name = name
    @age = age
    @password = password
    @friends = ['Phil', 'Robert']
  end
end

roy = Person.new 'Roy', 36, 'Sekret!!'
roy.name? #=> true
roy.has_password? #=> true
roy.friends_with_robert? #=> true

dave = Person.new 'Dave', 42
dave.age? #=> true
dave.has_password? #=> false
dave.has_friend? 'Steve' #=> false
```
