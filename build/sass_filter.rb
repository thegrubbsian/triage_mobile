require "sass"

class SassFilter < Rake::Pipeline::Filter

  def initialize(output_filename=nil, &block)
    block = proc { output_filename }
    super(&block)
  end

  def generate_output(inputs, output)
    inputs.each do |input|
      output.write Sass.compile(input.read, sass_options_for_file(input))
    end
  end

  private

  def sass_options_for_file(file)
    {
      :filename => file.fullpath,
      :syntax => file.path.match(/\.sass$/) ? :sass : :scss
    }
  end

end
