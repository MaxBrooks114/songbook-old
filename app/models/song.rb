class Song < ApplicationRecord
  has_many :instruments_songs, inverse_of: :songs
  has_many :instruments, through: :instruments_songs
  has_many :elements, inverse_of: :song, :dependent => :destroy
  accepts_nested_attributes_for :elements, allow_destroy: true
  belongs_to :user
  validates :title, presence: true, uniqueness: { scope: :artist }
  validates :instrument_ids, presence: true
  before_save :normalize


  def self.genres
    genres = [ "Blues","Classic Rock","Country","Dance","Disco","Funk","Grunge",
      "Hip-Hop","Jazz","Metal","New Age","Oldies","Other","Pop","R&B",
      "Rap","Reggae","Rock","Techno","Industrial","Alternative","Ska",
      "Death Metal","Pranks","Soundtrack","Euro-Techno","Ambient",
      "Trip-Hop","Vocal","Jazz+Funk","Fusion","Trance","Classical",
      "Instrumental","Acid","House","Game","Sound Clip","Gospel",
      "Noise","AlternRock","Bass","Soul","Punk","Space","Meditative",
      "Instrumental Pop","Instrumental Rock","Ethnic","Gothic",
      "Darkwave","Techno-Industrial","Electronic","Pop-Folk",
      "Eurodance","Dream","Southern Rock","Comedy","Cult","Gangsta",
      "Top 40","Christian Rap","Pop/Funk","Jungle","Native American",
      "Cabaret","New Wave","Psychadelic","Rave","Showtunes","Trailer",
      "Lo-Fi","Tribal","Acid Punk","Acid Jazz","Polka","Retro",
      "Musical","Rock & Roll","Hard Rock","Folk","Folk-Rock",
      "National Folk","Swing","Fast Fusion","Bebob","Latin","Revival",
      "Celtic","Bluegrass","Avantgarde","Gothic Rock","Progressive Rock",
      "Psychedelic Rock","Symphonic Rock","Slow Rock","Big Band",
      "Chorus","Easy Listening","Acoustic","Humour","Speech","Chanson",
      "Opera","Chamber Music","Sonata","Symphony","Booty Bass","Primus",
      "Porn Groove","Satire","Slow Jam","Club","Tango","Samba",
      "Folklore","Ballad","Power Ballad","Rhythmic Soul","Freestyle",
      "Duet","Punk Rock","Drum Solo","Acapella","Euro-House","Dance Hall", "Indie", "Indie-Rock"  ]
    end

    def self.used_genres
      select(:genre).distinct.map { |s| s.genre }
    end

    def self.used_artists
      select(:artist).distinct.map { |s| s.artist }
    end

    def self.used_albums
      select(:album).distinct.map { |s| s.album}
    end



    private
      def normalize
        self.title = title.downcase.titleize.squish
        self.artist = artist.downcase.titleize.squish
        self.album = album.downcase.titleize.squish
      end

end
