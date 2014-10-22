module MiniGiven
  module Spec

    def load_givens(givens_mod)
      include givens_mod
    end

    def given(given_name, args=nil)
      mod = Module.new do
        extend Minitest::Spec::DSL
        before do
          parameters = method(given_name).parameters.map do |param|
            symbol = (args && args[param[1]]) || param[1]
            self.instance_variable_get("@#{symbol.to_s}")
          end
          self.send(given_name, *parameters)
        end
      end

      include mod
    end

    def before &block
      mod = Module.new do
        extend Minitest::Spec::DSL
        before &block
      end
      include mod
    end
  end
end
