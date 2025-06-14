SitemapGenerator::Sitemap.default_host = "https://cifralize.com.br"

# bundle exec rake sitemap:refresh
SitemapGenerator::Sitemap.create do
  Song.find_each do |song|
    add home_song_path(song.artist.slug, song.slug), lastmod: song.updated_at
  end
end
