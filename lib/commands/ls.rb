module SlackShellbot
  module Commands
    class Ls < Base
      match(/^ls$/)

      def self.call(client, data, _match)
        fs = client.owner.fs[data.channel]
        dirs = fs.current_directory_entry.map(&:to_s).join("\n")
        client.say(channel: data.channel, text: dirs)
        logger.info "LS: #{client.owner}, #{fs}, user=#{data.user}"
      end
    end
  end
end
