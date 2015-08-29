require "selfie/version"

class Selfie < BasicObject

	def initialize(subject)
		@subject = subject
	end

	def method_missing(method, *args, &block)
		"s".send(:p, "method: #{method}, args: #{args}")
		"s".send(:p, "object before: #{@subject}")
		@subject = !@subject.nil? && @subject.respond_to?(method) ? @subject.public_send(method, *args, &block) : nil
		"s".send(:p, "object after: #{@subject}")

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