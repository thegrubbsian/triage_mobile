require "listen"

Listen.to!(File.expand_path("../../src", __FILE__)) do
  system "rakep build && phonegap build ios"
end
