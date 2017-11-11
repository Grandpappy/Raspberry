require 'squib'

data = Squib.xlsx file: 'data/test-deck.xlsx'
layouts = ['test-deck-layout.yml', 'player-card-base-types.yml']

Squib::Deck.new(cards: data['name'].size, layout: layouts) do
  
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  rect layout: 'safe' # safe zone as defined by TheGameCrafter
  text str: data['name'], layout: 'title'

  text str: data['text'], layout: 'description' do |embed|
    embed.svg key: ':strike:', file: 'icons\\revolt.svg', width: 40, height: 40
    embed.svg key: ':coin:', file: 'icons\\crown-coin.svg', width: 40, height: 40 
  end


  text str: Time.now, layout: 'credits'

  svg layout: data['basetype']

  save_png prefix: 'test-deck_'
  # save_pdf file: 'test-deck.pdf', trim: 37.5

end
