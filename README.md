# Mongoid3 Sequence

Mongoid3 Sequence allows you to specify fields to behave like a sequence number (exactly like the "id" column in
conventional SQL flavors).

Mongoid3 Sequence works with Mongoid > 3.x, and is not backward compatible.
There are other Mongoid sequence gems that sequences the _id field, but with this gem, you can assign any
field as sequenced.


## Credits

This gem is derived from Mongoid Sequence Gem by [goncalossilva](https://github.com/goncalossilva/mongoid-sequence).

## General Usage

Include `Mongoid::Sequence` in your class and call `sequence(:field)`.

Like this:

```ruby
class Sequenced
	include Mongoid::Document
	include Mongoid::Sequence

	field :my_sequence, :type => Integer
	sequence :my_sequence
end

s1 = Sequenced.create
s1.sequence #=> 1

s2 = Sequenced.create
s2.sequence #=> 2 # and so on
```

## _id Field Usage

You can auto-assign sequenced ID to Mongod's _id field.  Note that you have to declare
_id is Integer type.   This is because Mongoid3 defaults to treating _id as string, which will cause mongoid _id
queries to return nil.   i.e. in the example below, Sequenced.where( _id: "2" ) will return nil.

```ruby
class Sequenced
	include Mongoid::Document
	include Mongoid::Sequence

  field :_id, type Integer
	sequence :_id
end

s1 = Sequenced.create
s1.id #=> 1

s2 = Sequenced.create
s2.id #=> 2 # and so on
```

## Consistency

Mongoid::Sequence uses the atomic [findAndModify](http://www.mongodb.org/display/DOCS/findAndModify+Command) command, so you shouldn't have to worry about the sequence's consistency.

## Installation

Add it to your projects' `Gemfile`:

```ruby
gem 'mongoid3-sequence', git: 'git://github.com/akiatoji/mongoid3-sequence.git'
```

<hr/>

Copyright © 2013 Aki Atoji, released under the MIT license
