audio_visual_productions = {
  'ação' => {
    'filme' => ['Duro de Matar', 'Mad Max: Estrada da Fúria', 'John Wick'],
    'série' => ['24 Horas', 'Breaking Bad', 'Arrow']
  },
  'aventura' => {
    'filme' => ['Indiana Jones: Os Caçadores da Arca Perdida', 'O Senhor dos Anéis: A Sociedade do Anel', 'Piratas do Caribe: A Maldição do Pérola Negra'],
    'série' => ['Game of Thrones', 'Stranger Things', 'The Witcher']
  },
  'animação' => {
    'filme' => ['O Rei Leão', 'Toy Story', 'Frozen: Uma Aventura Congelante'],
    'série' => ['Avatar: A Lenda de Aang', 'Rick and Morty', 'Bojack Horseman']
  },
  'comédia' => {
    'filme' => ['Se Beber, Não Case!', 'Superbad: É Hoje', 'Esqueceram de Mim'],
    'série' => ['Friends', 'The Office (US)', 'Brooklyn Nine-Nine']
  },
  'crime' => {
    'filme' => ['Pulp Fiction', 'O Poderoso Chefão', 'Os Infiltrados'],
    'série' => ['Sherlock', 'Mindhunter', 'True Detective']
  },
  'documentário' => {
    'filme' => ['March of the Penguins', 'Supersize Me: A Dieta do Palhaço', 'Planeta Terra'],
    'série' => ['Making a Murderer', 'Planet Earth II', 'The Last Dance']
  },
  'drama' => {
    'filme' => ['O Resgate do Soldado Ryan', 'Clube da Luta', 'Forrest Gump'],
    'série' => ['Breaking Bad', 'The Crown', 'This Is Us']
  },
  'família' => {
    'filme' => ['Harry Potter e a Pedra Filosofal', 'Procurando Nemo', 'O Rei Leão'],
    'série' => ['Stranger Things', 'The Mandalorian', 'The Simpsons']
  },
  'fantasia' => {
    'filme' => ['Harry Potter e as Relíquias da Morte - Parte 2', 'O Senhor dos Anéis: O Retorno do Rei', 'Alice no País das Maravilhas'],
    'série' => ['Game of Thrones', 'The Witcher', 'His Dark Materials']
  },
  'ficção Científica' => {
    'filme' => ['Blade Runner', 'Matrix', 'Interestelar'],
    'série' => ['Black Mirror', 'Doctor Who', 'Westworld']
  },
  'horror' => {
    'filme' => ['O Iluminado', 'O Exorcista', 'A Noite dos Mortos-Vivos'],
    'série' => ['The Haunting of Hill House', 'Stranger Things', 'American Horror Story']
  },
  'mistério' => {
    'filme' => ['Sherlock Holmes', 'O Código Da Vinci', 'Garota Exemplar'],
    'série' => ['Sherlock', 'True Detective', 'Mindhunter']
  },
  'musical' => {
    'filme' => ['O Rei do Show', 'La La Land: Cantando Estações', 'Moulin Rouge!'],
    'série' => ['Glee', 'Crazy Ex-Girlfriend', 'Empire']
  },
  'romance' => {
    'filme' => ['Titanic', 'Orgulho e Preconceito', 'Simplesmente Acontece'],
    'série' => ['Outlander', 'Poldark', 'Modern Love']
  },
  'suspense' => {
    'filme' => ['Psicose', 'O Silêncio dos Inocentes', 'Seven: Os Sete Crimes Capitais'],
    'série' => ['Stranger Things', 'Breaking Bad', 'Mindhunter']
  },
  'terror' => {
    'filme' => ['O Sexto Sentido', 'O Chamado', 'Halloween'],
    'série' => ['The Haunting of Hill House', 'American Horror Story', 'Stranger Things']
  },
  'western' => {
    'filme' => ['Era uma Vez no Oeste', 'Os Imperdoáveis', 'Bravura Indômita'],
    'série' => ['Westworld', 'Deadwood', 'Hell on Wheels']
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
