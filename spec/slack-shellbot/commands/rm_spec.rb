require 'spec_helper'

describe SlackShellbot::Commands::Rm do
  let(:team) { Fabricate(:team) }
  let(:app) { SlackShellbot::Server.new(team: team) }
  let(:client) { app.send(:client) }
  let(:message_hook) { SlackRubyBot::Hooks::Message.new }
  context 'rm' do
    let!(:fs) { team.fs['channel'] }
    context 'a file' do
      let!(:file) { Fabricate(:file_entry, name: 'test.txt', parent_directory_entry: fs.root_directory_entry) }
      it 'returns removed file name' do
        expect do
          expect(client).to receive(:say).with(channel: 'channel', text: '/test.txt')
          message_hook.call(client, Hashie::Mash.new(team: team, text: "rm test.txt", channel: 'channel'))
        end.to change(FileEntry, :count).by(-1)
      end
    end
    context 'a file with a >' do
      let!(:file) { Fabricate(:file_entry, name: '> test.txt', parent_directory_entry: fs.root_directory_entry) }
      it 'returns removed file name' do
        expect do
          expect(client).to receive(:say).with(channel: 'channel', text: '/> test.txt')
          message_hook.call(client, Hashie::Mash.new(team: team, text: "rm \"> test.txt\"", channel: 'channel'))
        end.to change(FileEntry, :count).by(-1)
      end
    end
  end
end
