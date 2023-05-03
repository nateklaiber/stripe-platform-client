# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'dotenv'
require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.files = Dir["lib/**/*.rb"]
end

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc "Document the Library"
task doc: [:yard]

task(:configure) do
  require 'stripe_platform/client'

  StripePlatform::Client.configure do |c|
    c.logger = StripePlatform::Logger.new(File.expand_path('../log/rake.log', __FILE__))
    c.request_logger = StripePlatform::Logger.new(File.expand_path('../log/requests.log', __FILE__))
  end

  Dotenv.load
end

desc "List out API Routes"
task(routes: :configure) do
  require 'terminal-table'

  route_definitions = StripePlatform::Client.routes

  row_display = ->(row,index) do
    [(index + 1), row.name, row.path]
  end

  title    = "Routes: %s" % [StripePlatform::Client.api_host]
  headings = ['#', 'Route Name', 'URL']
  rows     = route_definitions.each_with_index.map { |r,i| row_display.call(r,i) }

  table = Terminal::Table.new(title: title, headings: headings, rows: rows)
  puts "\n"
  puts table.to_s
  puts "\n"
end
