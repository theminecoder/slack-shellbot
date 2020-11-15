module SlackShellbot
  module Commands
    class Whoami < SlackRubyBot::Commands::Base
      match(/^whoami$/)

      def self.call(client, data, _match)
        client.say(channel: data.channel, text: "<@#{data.user}>")
        logger.info "UNAME: #{client.owner}, user=#{data.user}"
      end
    end
  end
end
