require 'parser/current'
require 'ast'

module Gemfile
  class Parser
    class Processor < AST::Processor
      def gems
        @gems ||= []
      end

      def ruby_version
        @ruby_version
      end

      def process_children(node)
        node.updated(nil, process_all(node))
      end
      alias on_begin process_children
      alias on_block process_children

      def on_send(node)
        method = node.children[1]
        case method
        when :gem
          gems << node.children[2].children[0]
        when :ruby
          @ruby_version = node.children[2].children[0]
        end
        nil
      end
    end

    extend Forwardable
    def_delegators :processor, :gems, :ruby_version

    def initialize(gemfile)
      @gemfile = gemfile
    end

    private

    def processor
      @processor ||= begin
        parsed = ::Parser::CurrentRuby.parse(@gemfile.read)
        processor = Processor.new
        processor.process(parsed)
        processor
      end
    end
  end
end
