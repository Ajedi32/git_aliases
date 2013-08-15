module GitAliases
  module Git
    class ReturnValue
      attr_accessor :output

      def initialize(output, status)
        @output = output
        @status = status
      end

      def status
        @status.to_i
      end

      def success?
        @status.success?
      end

      def output!
        return nil unless success?
        output
      end
    end
  end
end
