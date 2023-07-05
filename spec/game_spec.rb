require_relative '../game'

describe Game do
  describe '#initialize' do
    it 'new game must be created' do
      game = Game.new(true, '01-01-2020', '01-05-2011', false)

      expect(game.multiplayer).to eq(true)
      expect(game.last_played_at).to eq('01-01-2020')
      expect(game.publish_date).to eq(Date.parse('01-05-2011'))
      expect(game.archived).to eq(false)
    end
  end

  describe '#can_be_archived?' do
    it 'should be true only if game can be archived' do
      game1 = Game.new(true, '2019-01-01', '2022-01-01', true)
      expect(game1.can_be_archived?).to eq(false)

      game2 = Game.new(true, '2022-01-01', '2022-01-01', true)
      expect(game2.can_be_archived?).to eq(false)

      game3 = Game.new(true, '01-01-2020', '01-05-2011', false)
      expect(game3.can_be_archived?).to eq(true)
    end
  end
end
