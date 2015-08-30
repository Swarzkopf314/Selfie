require 'test_helper'

class SelfieChainTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SelfieChain::VERSION
  end

  def test_on_hash
		h = {a: {b: {}}}

		assert_equal h[:a][:b][:c].to_i.selfie(-1) {|x| x > 0}, -1

		h[:a][:b] = {c: "14"}
		assert_equal h[:a][:b][:c].to_i.selfie(-1) {|x| x > 0}, 14

		assert_equal h.selfie[:a][:b][:c]["d"].to_i.share_selfie, nil

		h[:a][:b][:c] = {"d" => "14"}
		assert_equal h.selfie[:a][:b][:c]["d"].to_i.share_selfie, 14
  end
end
