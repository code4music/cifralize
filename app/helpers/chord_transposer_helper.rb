# frozen_string_literal: true

module ChordTransposerHelper
  NOTES = %w[C C# D D# E F F# G G# A A# B].freeze
  EQUIVALENTS = {
    'Db' => 'C#', 'Eb' => 'D#', 'Fb' => 'E', 'Gb' => 'F#',
    'Ab' => 'G#', 'Bb' => 'A#', 'Cb' => 'B',
    'E#' => 'F',  'B#' => 'C'
  }.freeze

  CHORD_REGEX = %r{\b([A-G])([b#]?)(m?(?:7|9|11|13|sus|dim|aug|add)?)(?:/([A-G][b#]?))?\b}x

  def self.transpose(text, steps = 1)
    text.gsub(CHORD_REGEX) do |match|
      transpose_chord(match, steps)
    end
  end

  def self.transpose_chord(chord, steps)
    main_chord, bass = chord.split('/')
    root, suffix = main_chord.match(/^([A-G][b#]?)(.*)$/i).captures

    root = EQUIVALENTS[root.capitalize] || root.capitalize
    index = NOTES.index(root)
    return chord unless index

    transposed_root = NOTES[(index + steps) % 12]

    if bass
      bass_root = EQUIVALENTS[bass.capitalize] || bass.capitalize
      bass_index = NOTES.index(bass_root)
      transposed_bass = bass_index ? NOTES[(bass_index + steps) % 12] : bass
      "#{transposed_root}#{suffix}/#{transposed_bass}"
    else
      transposed_root + suffix
    end
  end
end
