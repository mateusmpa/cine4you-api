audio_visual_productions = {
  'ação' => {
    'filme' => ['duro de matar', 'mad max: estrada da fúria', 'john wick'],
    'série' => ['24 horas', 'breaking bad', 'arrow']
  },
  'aventura' => {
    'filme' => ['indiana jones: os caçadores da arca perdida', 'o senhor dos anéis: a sociedade do anel', 'piratas do caribe: a maldição do pérola negra'],
    'série' => ['game of thrones', 'stranger things', 'the witcher']
  },
  'animação' => {
    'filme' => ['o rei leão', 'toy story', 'frozen: uma aventura congelante'],
    'série' => ['avatar: a lenda de aang', 'rick and morty', 'bojack horseman']
  },
  'comédia' => {
    'filme' => ['se beber, não case!', 'superbad: é hoje', 'esqueceram de mim'],
    'série' => ['friends', 'the office (us)', 'brooklyn nine-nine']
  },
  'crime' => {
    'filme' => ['pulp fiction', 'o poderoso chefão', 'os infiltrados'],
    'série' => ['sherlock', 'mindhunter', 'true detective']
  },
  'documentário' => {
    'filme' => ['march of the penguins', 'supersize me: a dieta do palhaço', 'planeta terra'],
    'série' => ['making a murderer', 'planet earth ii', 'the last dance']
  },
  'drama' => {
    'filme' => ['o resgate do soldado ryan', 'clube da luta', 'forrest gump'],
    'série' => ['breaking bad', 'the crown', 'this is us']
  },
  'família' => {
    'filme' => ['harry potter e a pedra filosofal', 'procurando nemo', 'o rei leão'],
    'série' => ['stranger things', 'the mandalorian', 'the simpsons']
  },
  'fantasia' => {
    'filme' => ['harry potter e as relíquias da morte - parte 2', 'o senhor dos anéis: o retorno do rei', 'alice no país das maravilhas'],
    'série' => ['game of thrones', 'the witcher', 'his dark materials']
  },
  'ficção científica' => {
    'filme' => ['blade runner', 'matrix', 'interestelar'],
    'série' => ['black mirror', 'doctor who', 'westworld']
  },
  'horror' => {
    'filme' => ['o iluminado', 'o exorcista', 'a noite dos mortos-vivos'],
    'série' => ['the haunting of hill house', 'stranger things', 'american horror story']
  },
  'mistério' => {
    'filme' => ['sherlock holmes', 'o código da vinci', 'garota exemplar'],
    'série' => ['sherlock', 'true detective', 'mindhunter']
  },
  'musical' => {
    'filme' => ['o rei do show', 'la la land: cantando estações', 'moulin rouge!'],
    'série' => ['glee', 'crazy ex-girlfriend', 'empire']
  },
  'romance' => {
    'filme' => ['titanic', 'orgulho e preconceito', 'simplesmente acontece'],
    'série' => ['outlander', 'poldark', 'modern love']
  },
  'suspense' => {
    'filme' => ['psicose', 'o silêncio dos inocentes', 'seven: os sete crimes capitais'],
    'série' => ['stranger things', 'breaking bad', 'mindhunter']
  },
  'terror' => {
    'filme' => ['o sexto sentido', 'o chamado', 'halloween'],
    'série' => ['the haunting of hill house', 'american horror story', 'stranger things']
  },
  'western' => {
    'filme' => ['era uma vez no oeste', 'os imperdoáveis', 'bravura indômita'],
    'série' => ['westworld', 'deadwood', 'hell on wheels']
  }
}

audio_visual_productions.each do |genre_kind, category_catalogs|
  genre = Genre.create!(kind: genre_kind)

  category_catalogs.each do |category_kind, catalog_titles|
    category = Category.find_or_create_by!(kind: category_kind)

    catalog_titles.each do |catalog_title|
      Catalog.create!(
        category_id: category.id,
        genre_id: genre.id,
        title: catalog_title
      )
    end
  end
end
