require 'rake/testtask'

task default: :test

Rake::TestTask.new(:test)             { |t| t.pattern = 'test/**/*_test.rb' }
Rake::TestTask.new(:unit_test)        { |t| t.pattern = 'test/unit/**/*_test.rb' }
Rake::TestTask.new(:integration_test) { |t| t.pattern = 'test/integration/**/*_test.rb' }
