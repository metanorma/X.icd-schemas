#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'pathname'

# Script to update all sources/sections/*.json files based on content in sources/ocsf-schema/

BASE_DIR = Pathname.new(__dir__)
SOURCES_DIR = BASE_DIR.join('sources')
SECTIONS_DIR = SOURCES_DIR.join('sections')
OCSF_SCHEMA_DIR = SOURCES_DIR.join('ocsf-schema')

# Configuration mapping: JSON file name to source directory and optional filter
CONFIG_MAP = {
  'events.json' => { dir: 'events', filter: nil },
  'objects.json' => { dir: 'objects', filter: nil },
  'profiles.json' => { dir: 'profiles', filter: nil },
  'extensions.json' => { dir: 'extensions', filter: nil }
}

def collect_json_files(base_path, filter = nil)
  return [] unless base_path.exist?

  files = []

  # Find all JSON files recursively
  Dir.glob(base_path.join('**', '*.json')).sort.each do |file|
    path = Pathname.new(file)

    # Apply filter if provided
    next if filter && !filter.call(path)

    # Convert absolute path to relative path from sources/
    relative_path = path.relative_path_from(SOURCES_DIR)
    files << relative_path.to_s
  end

  files
end

def update_config_file(config_name, config)
  output_file = SECTIONS_DIR.join(config_name)
  schema_dir = OCSF_SCHEMA_DIR.join(config[:dir])
  filter = config[:filter]

  puts "\n#{config_name}:"
  puts "  Scanning: #{schema_dir}"

  unless schema_dir.exist?
    puts "  Warning: Directory not found: #{schema_dir}"
    return
  end

  # Collect JSON files with optional filter
  paths = collect_json_files(schema_dir, filter)

  if paths.empty?
    puts "  Warning: No JSON files found"
    return
  end

  puts "  Found: #{paths.length} files"

  # Create the JSON structure
  data = {
    "paths" => paths
  }

  # Write to output file
  File.write(output_file, JSON.pretty_generate(data) + "\n")

  puts "  Updated: #{output_file}"

  # Show sample paths
  sample_size = [paths.length, 5].min
  puts "  Sample paths:"
  paths.first(sample_size).each do |path|
    puts "    - #{path}"
  end

  if paths.length > sample_size
    puts "    ... and #{paths.length - sample_size} more"
  end
end

def update_all_configs
  puts "="*60
  puts "Updating OCSF Schema Configuration Files"
  puts "="*60

  CONFIG_MAP.each do |config_name, config|
    update_config_file(config_name, config)
  end

  puts "\n" + "="*60
  puts "Update complete!"
  puts "="*60
end

# Run the script
if __FILE__ == $0
  update_all_configs
end