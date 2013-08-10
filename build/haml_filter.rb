require "haml"

class HamlFilter < Rake::Pipeline::Filter

  def initialize(output_filename=nil, &block)
    block = proc { output_filename }
    super(&block)
  end

  def generate_output(inputs, output)
    inputs.each do |input|
      haml_engine = Haml::Engine.new(input.read)
      output.write haml_engine.render
    end
  end

end
