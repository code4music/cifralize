class ImportCifraclubJob < ApplicationJob
  queue_as :default

  def perform(url, user_id)
    cifra_url = "https://www.cifraclub.com.br#{url}"
    cifraclub = CifraclubScraper.pegar_cifra(cifra_url)

    title = cifraclub[:title]
    artist = Artist.find_or_create_by(name: cifraclub[:artist])
    genre = Genre.find_or_create_by(name: cifraclub[:genre])
    user = User.find(user_id)

    return if Song.where("LOWER(title) = ? AND artist_id = ?", title.downcase, artist.id).exists?

    Song.create!(
      user: user,
      title: title,
      artist: artist,
      genre: genre,
      key: cifraclub[:key],
      cifraclub_url: cifra_url,
      from_cifraclub: true,
      chords: cifraclub[:cifra]
    )
  end
end
