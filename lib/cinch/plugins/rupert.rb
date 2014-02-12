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

		match(/profiles/, method: :profiles)
		def profiles(m)
			@mic.profiles.each do |profile|
				reply = "#{profile.formatted_service} (#{profile.formatted_username}). "
				unless profile.statistics.empty?
					stats = profile.statistics.map { |k,v|
							{k => v} if v > 0
						}.compact.reduce(:merge)
					
					unless stats.nil?
						reply += "Social: " + stats.map { |k, v|
							"#{v} #{k.capitalize.gsub('_28', '').gsub('_', ' ')}"
						}.join(", ") + " "
					end
				end

				reply += "Messages: #{profile.counts.sent} sent, #{profile.counts.pending} pending, #{profile.counts.drafts} draft."

				m.reply(reply)
			end
		end

		match(/publish (.*)/, method: :publish)
		def publish(m, content)
			profile_ids = @mic.profiles.map { |p| p.id }

			response = @mic.create_update({
					:body => {
						:text => content,
						:profile_ids => profile_ids
					}
				})
			
			success = "Success"
			success = "Failure" unless response.success
			m.reply("#{success.capitalize}!")

			# Find what is not in the "buffer" state:
			response.updates.each do |message|
				due = DateTime.strptime("#{message.due_at}", '%s')
				m.reply("#{message.profile_service.capitalize}: ID: #{message.id}, Status: #{message.status}, Due: #{due.to_s}")
			end

			cap = response.buffer_count * 100 / response.buffer_percentage
			m.reply("#{response.buffer_count} messages in queue.  Using #{response.buffer_percentage}% of buffer.  #{cap - response.buffer_count} messages remain.")

			profiles(m)
		end
	end
end
