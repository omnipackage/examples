# frozen_string_literal: true

require_relative "omnipackage_example_ruby/version"

require "ruby_cowsay"

module OmnipackageExampleRuby
  def self.hello
    puts Cow.new.say("Hello world")
  end
end
