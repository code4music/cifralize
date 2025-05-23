module SongsHelper
  def format_chords(text)
    lines = text.lines.map do |line|
      highlighted = line.gsub(/\[([^\]]+)\]/) do
        "<span class='chord'>[#{Regexp.last_match(1)}]</span>"
      end

      chord_regex = Regexp.new(<<~REGEXP, Regexp::EXTENDED)
        (?<=\\s|^)                  # início de linha ou espaço
        (
          [A-G]                     # nota base
          (?:[#b])?                 # sustenido ou bemol opcional
          (?:m|maj|min|dim|aug|sus|add)?  # tipo opcional
          (?:[0-9]{0,2})?           # número opcional como 7, 9, 13
          (?:\\(.*?\\))?            # extensões como (b5), (#11)
          (?:/[A-G](?:[#b])?)?      # baixo (ex: C/E, D#/F#)
        )
        (?=\\s|$)                  # fim de linha ou espaço
      REGEXP


      highlighted.gsub!(chord_regex) do |match|
        "<span class='chord'>#{match}</span>"
      end

      highlighted
    end

    lines.join
  end
end
