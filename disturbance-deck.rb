require 'squib'

data = Squib.xlsx file: 'data/disturbance-deck.xlsx'
layouts = ['all-decks-layout.yml', 'disturbance-deck-layout.yml', 'card-base-types.yml']

health_icons = data['Health'].map do |e| 
  e.nil? ? nil : 'icons/hearts.svg'
end

# thirdskills = data['Default3'].map do |default|
#   default.nil? ? nil : 'thirdskill.svg'
# end

Squib::Deck.new(cards: data['Name'].size, layout: layouts, width: 900, height: 900) do
# Squib::Deck.new(cards: 1, layout: layouts) do
  
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
    embed.svg key: ':heart:', file: 'icons\\heart-organ.svg', layout: 'embedded_icon'
    embed.svg key: ':corruption:', file: 'icons\\death-skull.svg', layout: 'embedded_icon'
    embed.svg key: ':W:', file: 'icons\\inverted-dice-5-white.svg', layout: 'embedded_icon'
    embed.svg key: ':R:', file: 'icons\\inverted-dice-5-red.svg', layout: 'embedded_icon'
    embed.svg key: ':G:', file: 'icons\\inverted-dice-5-green.svg', layout: 'embedded_icon'
  end

  text str: data['CombatDice'], layout: 'combat_dice' do |embed|
    embed.svg key: ':W:', file: 'icons\\inverted-dice-5-white.svg', layout: 'embedded_icon'
    embed.svg key: ':R:', file: 'icons\\inverted-dice-5-red.svg', layout: 'embedded_icon'
    embed.svg key: ':G:', file: 'icons\\inverted-dice-5-green.svg', layout: 'embedded_icon'
  end

  # text str: data['Cost'], layout: 'cost'
  # text str: data['Deck'], layout: 'deck_name'

  svg layout: data['BaseType']

  # if current['health'] != nil
    svg layout: 'health-icon', file: health_icons
    text str: data['Health'], layout: 'health-text'
  # end

  # Use timestamp for a version number
  text str: Time.now, layout: 'credits'

  # save_png prefix: 'disturbance_'
  save_pdf file: 'disturbance_deck.pdf', trim: 37.5, sprue: 'square-sprue.yml'
end