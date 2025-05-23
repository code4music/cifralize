require 'open-uri'

module CifraclubScraper
  def self.pegar_cifra(url)
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)

    title = doc.at_css('h1.t1')&.text&.strip
    artist = doc.at_css('h2.t3 a')&.text&.strip
    genre = doc.at('li[itemprop="itemListElement"] meta[itemprop="position"][content="2"]')&.parent&.at('span[itemprop="name"]')&.text
    key = doc.at('#cifra_tom a')&.text
    cifra = doc.css('pre').text.strip

    {
      title: title,
      artist: artist,
      genre: genre,
      key: key,
      cifra: cifra,
    }
  rescue => e
    "Erro ao acessar ou processar a URL: #{e.message}"
  end

  def self.get_artist_songs(url)
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)

    music_links = doc.css('ul.art_musics li a.art_music-link')
    urls = music_links.map { |link| link['href'] }
    urls
  rescue => e
    "Erro ao acessar ou processar a URL: #{e.message}"
  end
end
