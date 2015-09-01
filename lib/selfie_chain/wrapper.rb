module SelfieChain
	class Wrapper < BasicObject

		def initialize(subject)
			@subject = subject
		end

		def method_missing(method, *args, &block)
			if !@subject.nil? && @subject.respond_to?(method)
				@subject = @subject.public_send(method, *args, &block)
			end
			self
		end

		# returns @subject or other, if the optional block evaluates to true (and @subject is not nil)
		def share_selfie(other = nil, &block)
			# this means it's NOT equivalent to .share_selfie.selfie(other, &block)
			return if @subject.nil?

			# block_given? isn't defined on BasicObject
			if block.nil?
				@subject
			else
				yield(@subject) ? @subject : other
			end
		end

	end
end