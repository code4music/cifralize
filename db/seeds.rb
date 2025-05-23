# frozen_string_literal: true

Role.create(name: 'Admin')
Role.create(name: 'Gerente')
Role.create(name: 'Usuário')

User.create(email: 'admin@cifralize.com.br', password: '123@tarrafa', name: 'Administrador', role: Role.find_by_name('Admin'))

Artist.find_or_create_by(name: 'Artista', slug: 'artista')

Genre.find_or_create_by(name: 'Rock')
Genre.find_or_create_by(name: 'Pop')
Genre.find_or_create_by(name: 'MPB')
Genre.find_or_create_by(name: 'Sertanejo')
Genre.find_or_create_by(name: 'Forró')
Genre.find_or_create_by(name: 'Axé')
Genre.find_or_create_by(name: 'Pagode')
Genre.find_or_create_by(name: 'Samba')
Genre.find_or_create_by(name: 'Funk')
Genre.find_or_create_by(name: 'Rap')
Genre.find_or_create_by(name: 'Hip Hop')
Genre.find_or_create_by(name: 'Reggae')
Genre.find_or_create_by(name: 'Blues')
Genre.find_or_create_by(name: 'Jazz')
Genre.find_or_create_by(name: 'Clássica')
Genre.find_or_create_by(name: 'Gospel/Religioso')
Genre.find_or_create_by(name: 'Eletrônica')
Genre.find_or_create_by(name: 'Bossa Nova')
Genre.find_or_create_by(name: 'Heavy Metal')
Genre.find_or_create_by(name: 'Country')

Song.create(
  user: User.first,
  title: 'Música',
  slug: 'musica',
  artist: Artist.find_by(slug: 'artista'),
  genre: Genre.find_by(name: 'Pop'),
  key: 'C',
  chords: 'C G Am F',
  visibility: 'unlisted',
)
