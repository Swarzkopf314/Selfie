require "selfie/version"

class Selfie < BasicObject

	def initialize(subject)
		@subject = subject
	end

	def method_missing(method, *args, &block)
		@subject = !@subject.nil? && @subject.respond_to?(method) ? @subject.public_send(method, *args, &block) : nil
		self
	end

	def share_selfie
		@subject
	end

end

class Object

	def selfie(other = nil)
		if block_given?
			yield(self) ? self : other
		else
			Selfie.new(self)
		end
	end
end