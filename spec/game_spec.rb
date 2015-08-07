require 'spec_helper'

describe 'Game' do
  let(:subject) {Game.new(6, 7, 3)}

  describe '#new' do
    it 'create a new game board' do
      expect(subject.board).to be_instance_of(Board)
    end
  end

  describe '#switch_players' do
    it 'Swapped the players' do
      current = subject.current_player.symbol
      other = subject.other_player.symbol
      subject.switch_players
      expect(subject.current_player.symbol).to eq(other)
      expect(subject.other_player.symbol).to eq(current)
    end

    describe '#validate_and_place_piece' do
      before :each do
        allow(subject).to receive(:get_input).and_return(100)
      end

      it 'doesnt move th piece if out of range column number is entered' do
        expect(subject).to receive(:place_piece_in_column).with(100).exactly(0).times
        subject.validate_and_place_piece
      end
    end

  end
end
