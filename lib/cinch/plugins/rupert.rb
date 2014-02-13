require 'date'
require 'buff'
require 'cinch'

module Cinch::Plugins
	class Rupert
		include Cinch::Plugin

		def initialize(*)
			super
			@mic = Buff::Client.new "YOURKEYHERE"
		end

		listen_to :join
		def listen(m)
			profiles(m) if m.user.nick == bot.nick
		end


		match /profiles/, method: :profiles
		def profiles(m)
			replies = []
			@mic.profiles.each do |profile|
				reply = []
				reply << "#{profile.service.upcase}/#{profile.formatted_username}"
				unless profile.statistics.empty?
					stats = profile.statistics.map { |k,v|
							{k => v} if v > 0
						}.compact.reduce :merge
					
					# Each network has different nouns
					# ("followers", "likes", "impressions", etc.).
					# Why does Google+ attach "_28" to the field names?
					unless stats.nil?
						reply << "Social: " + stats.map { |k, v|
							"#{v} #{k.gsub(/_\d+/, ' ').strip.capitalize}"
						}.join(", ")
					end
				end

				# Create a messages summary of sent, drafts, pending messages
				# Only bother mentioning the ones that are nonzero
				reply << "Messages: " + profile.counts.map { |k,v|
						"#{v} #{k}" if v != 0
					}.compact.join(", ")

				replies << reply
			end
				m.channel.topic	= "#{replies.map { |r| "#{r.join('. ')}" }.join(" || ")}"
		end

		match /publish (.*)/, method: :publish
		def publish(m, content)

			response = @mic.create_update({
					:body => {
						:text => content,
						:profile_ids => @mic.profiles.map { |p| p.id }
					}
				})
			
			m.reply response.success ? "Success!" : "Failure!"

			response.updates.map.each do |message|
				due = DateTime.strptime("#{message.due_at}", '%s')

				m.reply "#{message.profile_service.capitalize}: " +
					[
						["ID: #{message.id}"],
						["Status: #{message.status}"],
						["Due: #{due.to_s}"]
					].join(", ")
			end


			cap = 100 * response.buffer_count / response.buffer_percentage

			m.reply [
					"#{response.buffer_count}	messages in queue",
					"Using #{response.buffer_percentage}% of buffer",
					"#{cap - response.buffer_count} messages remain."
				].join(". ")

			profiles(m)
		end
	end
end
