require "selfie_chain/version"
require "selfie_chain/wrapper"

class Object

	def selfie(other = nil)
		if block_given?
			yield(self) ? self : other
		else
			SelfieChain::Wrapper.new(self)
		end
	end

end