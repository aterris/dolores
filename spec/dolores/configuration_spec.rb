require 'spec_helper'

describe Dolores do

  describe '#configure' do
    before do
      
    end

    describe '#wit_actions' do
      it 'returns default wit_actions' do
        expect(Dolores.configuration.wit_actions).to eq 'Dolores::Actions'
      end

      it 'returns the wit_actions' do
          Dolores.configure do |config|
          config.wit_actions = 'Custom::Actions'
        end

        expect(Dolores.configuration.wit_actions).to eq 'Custom::Actions'
      end
    end

  end
end