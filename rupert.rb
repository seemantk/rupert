require 'cinch'
require_relative "lib/cinch/plugins/rupert"

bot = Cinch::Bot.new do
	configure do |c|
		c.server = "127.0.0.1"
		c.channels = ["#bufferapp"]
		c.nick = "rupert"

		c.plugins.plugins = [
			Cinch::Plugins::Rupert
		]
	end
end

bot.start
