#!/usr/bin/env ruby

require 'erb'

# Build context and helpers for generating the documentation.
class Context
  def initialize(opts = {})
    @output = opts.fetch(:include_output, true)
  end

  def example_with_output(file)
    "#{example(file)}\n\n#{output_with_lead(file)}"
  end

  def example(file)
    "```ruby\n# #{file}\n#{File.read(fn(file))}```"
  end

  def output_with_lead(file)
    "Example output of #{file}:\n#{output(file)}"
  end

  def output(file)
    "```\n#{run_file(file)}```"
  end

  def run_file(file)
    return "<output of #{file}>\n" unless @output

    result = nil
    IO.popen(['ruby', fn(file)], 'r', err: [:child, :out]) do |io|
      result = io.read
    end

    result
  end

  def fn(file)
    "src_readme/examples/#{file}"
  end

  def bound
    binding
  end
end

def write_out(file, opts = {})
  template = File.read('src_readme/readme.md.erb')
  erb = ERB.new(template)
  context = Context.new(opts)

  File.write(file, erb.result(context.bound))
end

write_out('README.md')
write_out('src_readme/README_no_output.md', include_output: false)
