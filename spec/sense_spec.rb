require 'dotenv'
require  'byebug'

require_relative '../lib/sense'

Dotenv.load('.env.local', '.env')

describe Sense do
  let(:sense) { Sense.new }

  describe 'authentication' do
    it 'requires username and password' do
      expect { sense.authenticate() }.to raise_error ArgumentError
    end

    it 'fails with the wrong credentials' do
      sense.authenticate(username: ENV['MOTHER_USERNAME'], password: '123')
      expect(sense).to_not be_authenticated
    end

    it 'authenticates user' do
      sense.authenticate(username: ENV['MOTHER_USERNAME'], password: ENV['MOTHER_PASSWORD'])
      expect(sense).to be_authenticated
    end
  end

  describe 'nodes' do
    before do
      sense.authenticate(username: ENV['MOTHER_USERNAME'], password: ENV['MOTHER_PASSWORD'])
    end

    it 'retrives user nodes' do
      p sense.http['nodes/'].get
    end
  end
end
