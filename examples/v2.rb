require "bundler/setup"

require 'scamp'
require 'scamp-campfire'

Scamp.new do |bot|
  bot.adapter :campfire, Scamp::Campfire::Adapter, :subdomain => 'SUBDOMAIN', 
                                                   :api_key => 'YOUR_API_KEY',
                                                   :rooms => [123]

  bot.match /^ping/ do |channel, msg|
    channel.reply "pong"
  end

  bot.match /^come to the pub (?<name>\w+)/ do |channel, msg|
    channel.say "ROGER DODGER  #{msg.matches.name.upcase}!"
    channel.reply "ON MY WAY!"
    channel.paste <<-STR
      bot.match /^come to the pub (?<name>\w+)/ do |channel, msg|
        channel.say "ROGER DODGER!"
        channel.reply "ON MY WAY! #{msg.matches.name}"
        channel.play(:nyan)
      end
    STR
    channel.play(:nyan)
  end

  bot.connect!
end
