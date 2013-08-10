require "ejs"

class JstFilter < Rake::Pipeline::Filter

  attr_reader :directory

  def initialize(output_filename=nil, directory=nil, &block)
    @directory = directory
    block = proc { output_filename }
    super(&block)
  end

  def generate_output(inputs, output)
    template_hash = {}
    inputs.each do |file|
      build_templates_hash(file, template_hash)
    end
    output_string = build_output(template_hash)
    output.write output_string
  end

  private

  def build_templates_hash(file, template_hash)
    path = file.path.gsub(/#{@directory}\//, "").gsub(/\.jst/, "")
    template_hash[path] = EJS.compile(file.read)
  end

  def build_output(template_hash)
    str = "var Templates = {};\n"
    template_hash.each do |k, v|
      str << "Templates[\"#{k}\"] = #{v};\n"
    end
    str
  end

end
