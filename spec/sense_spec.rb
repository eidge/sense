require_relative '../lib/sense'

describe Sense do
  let(:sense) { Sense.new }

  describe 'authentication' do
    it 'requires username and password' do
      expect { sense.authenticate() }.to raise_error ArgumentError
    end
  end
end
