require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'cucumber/rake/task'
require 'rake/clean'

CLEAN.include(FileList['coverage'])

task default: [:test]
task test: [:clean, :rubocop, :spec, :clean, :features, :docs]
task docs: [:examples, :build_docs, :no_doc_change]

RSpec::Core::RakeTask.new(:spec) do |s|
  s.pattern = 'spec/**/*.rb'
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['**/*.rb']
  task.fail_on_error = true
end

Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --format pretty"
end

task :build_docs do
  pid = fork do
    exec('ruby', 'src_readme/make.rb')
  end

  Process.wait(pid)

  if $?.exitstatus > 0
    puts "Readme build failed!"
    exit 1
  end
end

task :no_doc_change do
  pid = fork do
    exec('git', 'diff', '--exit-code', 'src_readme/README_no_output.md')
  end

  Process.wait(pid)

  if $?.exitstatus > 0
    puts "Readme build changed the README.md! Must rebuild and commit."
    exit 1
  end
end

task :examples do
  FileList['src_readme/examples/*.rb'].each do |file|
    puts "Testing example: #{file}"

    pid = fork do
      exec('ruby', file)
    end
    Process.wait(pid)

    if $?.exitstatus > 0
      puts "Example #{file} failed!"
      exit 1
    end

    puts ""
  end
end
