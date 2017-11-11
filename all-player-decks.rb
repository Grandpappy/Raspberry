require 'squib'

data = Squib.xlsx file: 'data/all-player-decks.xlsx'
layouts = ['all-player-decks-layout.yml', 'player-card-base-types.yml']
#sub_deck = data['SubDeck'] { |e| e.nil? ? data['BaseType'][i] : e }

Squib::Deck.new(cards: data['Name'].size, layout: layouts) do
  
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  rect layout: 'safe' # safe zone as defined by TheGameCrafter


  text str: data['Name'], layout: 'title'

  #, hint: :red
  text str: data['Description'], layout: 'description' do |embed|
    embed.svg key: ':strike:', file: 'icons\\revolt.svg', layout: 'embedded_icon'
    embed.svg key: ':coin:', file: 'icons\\crown-coin.svg', layout: 'embedded_icon'
    embed.svg key: ':wound:', file: 'icons\\thunder-skull.svg', layout: 'embedded_icon'
    embed.svg key: ':heal:', file: 'icons\\heart-plus.svg', layout: 'embedded_icon'
    embed.svg key: ':draw:', file: 'icons\\card-draw.svg', layout: 'embedded_icon'
    embed.svg key: ':move:', file: 'icons\\run.svg', layout: 'embedded_icon'
    embed.svg key: ':shield:', file: 'icons\\checked-shield.svg', layout: 'embedded_icon'
  end

  text str: data['Cost'], layout: 'cost'
  text str: data['Deck'], layout: 'deck_name'

  text str: Time.now, layout: 'credits'

  svg layout: data['BaseType']

  save_png prefix: 'player_'
  save_pdf file: 'all_player_decks.pdf', trim: 37.5

end
