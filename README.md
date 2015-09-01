# SelfieChain

Now every object can take a selfie. SelfieChain is an attempt to complement ruby's ternary operator, null guard and somehow extend Rails' :try method (but you don't need Rails), all in one-shot. I realised that there are use cases, that the above mentioned tools fail to address in sufficently elegant way. Look below for some explanatory examples and start taking selfies :)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'selfie_chain'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install selfie_chain

## Usage

SelfieChain adds a :selfie method to Object class (as well as a SelfieChain:Wrapper < BasicObject class). Calling it with or without a block changes it's behavior as follows:

####1. With block (and one optional argument that defaults to nil). 

Passes the receiver to the block. If the block returns true, then the whole method returns the receiver; otherwise it returns the argument:

	h = {a: {b: {}}} (hashes make nice examples)
	
	h[:a][:b][:c].to_i.selfie(-1) {|x| x > 0} => -1 
	
	h[:a][:b] = {c: "14"}
	h[:a][:b][:c].to_i.selfie(-1) {|x| x > 0} => 14

You don't have to repeat the long method call chain, selfie let's you replace this expression with mere 'x' inside the block (that's where the name comes from: "self-if", transmutes into "selfie" quite easily)

####2. Without block (no arguments needed).

This let's you stop worrying about checking for possible nil every time you chain another method*:

	h.selfie[:a][:b][:c]["d"].to_i.share_selfie => nil

	h[:a][:b][:c] = {"d" => "14"}
	h.selfie[:a][:b][:c]["d"].to_i.share_selfie => 14

This time selfie returns SelfieChain.new(self) - instance of SelfieChain < BasicObject class that wraps the receiver. This wrapper delegates every method call (except for :share_selfie and those defined by BasicObject)
to the wrapped object - and swaps it with the result unless the wrapped object doesn't respond_to? the method, in which case the wrapper stores nil. NOTE, that once the wrapped object hits nil, it always stays nil (this conforms to the Rails' :try method mechanics). You can end this method calling chain party and retrieve the result by calling :share_selfie.

####3. Share_selfie with block (from v.1.1.0)

Now you can pass a block to share selfie:

	h[:a][:b][:c] = {"d" => "14"}
	h.selfie[:a][:b][:c]["d"].to_i.share_selfie(-1) {|x| false} => -1
	
It works just like (...).share_selfie.selfie(-1) {|x| false} with the only exception, that when share_selfie is to yield nil, it still yields nil no matter what the given block would evaluate to (it's not called at all):

	h[:a][:b] = {c: "14"}
	h.selfie[:a][:b][:c]["d"].to_i.share_selfie(-1) {|x| false} => nil
	h.selfie[:a][:b][:c]["d"].to_i.share_selfie.selfie(-1) {|x| false} => -1


----------------------------
* Here we use string "d" instead of symbol :d to avoid known "no implicit conversion of Symbol into Integer" exception raised by calling "14"[:d].


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
														
To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/swarzkopf314/selfie_chain.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
