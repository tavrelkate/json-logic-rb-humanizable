# frozen_string_literal: true
require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "lib" << "test"
  t.test_files = FileList["test/test_*.rb"]
end
task default: :test
