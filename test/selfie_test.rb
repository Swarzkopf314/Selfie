require 'test_helper'

class SelfieChainTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SelfieChain::VERSION
  end

  def setup
  	@h = {a: {b: {}}}
  end

  def test_with_block
		assert_equal @h[:a][:b][:c].to_i.selfie(-1) {|x| x > 0}, -1

		@h[:a][:b] = {c: "14"}
		assert_equal @h[:a][:b][:c].to_i.selfie(-1) {|x| x > 0}, 14
	end

	def test_share_selfie
		@h[:a][:b] = {c: "14"}
		assert_equal @h.selfie[:a][:b][:c]["d"].to_i.share_selfie, nil

		@h[:a][:b][:c] = {"d" => "14"}
		assert_equal @h.selfie[:a][:b][:c]["d"].to_i.share_selfie, 14
  end

  def test_share_selfie_with_block
		@h[:a][:b] = {c: "14"}
		assert_equal @h.selfie[:a][:b][:c]["d"].to_i.share_selfie(0) {|x| true}, nil  	
		assert_equal @h.selfie[:a][:b][:c]["d"].to_i.share_selfie(0) {|x| true} || 15, 15

  	@h[:a][:b][:c] = {"d" => "14"}
  	assert_equal @h.selfie[:a][:b][:c]["d"].to_i.share_selfie(0) {|x| false}, 0
  	assert_equal @h.selfie[:a][:b][:c]["d"].to_i.share_selfie(0) {|x| true}, 14
  	assert_equal @h.selfie[:a][:b][:c]["d"].to_i.share_selfie {|x| true}, 14
  	assert_equal @h.selfie[:a][:b][:c]["d"].to_i.share_selfie {|x| false}, nil  	
  end

  def test_share_selfie_selfie
		@h[:a][:b] = {c: "14"}

		assert_equal @h.selfie[:a][:b][:c]["d"].to_i.share_selfie.selfie(0) {|x| !x.nil?}, 0
		assert_equal @h.selfie[:a][:b][:c]["d"].to_i.share_selfie(0) {|x| !x.nil?}, nil
		
		assert_equal @h.selfie[:a][:b][:c]["d"].to_i.share_selfie.selfie(0) {|x| x.nil?}, nil
  end

end
