require 'pg'
require_relative 'pieces'

class ComposerBuild
  def initialize(options)
    @first_name = options[:first_name]
    @last_name = options[:last_name ]
    @period = options[:period]
    @nationality = options[:nationality]
    @birthday = options[:birthday]
    @favorite_instrument = options[:favorite_instrument]
    @composer_id = options[:composer_id]
    @id = options[:id]
    @conn = PG.connect(dbname: 'test')
  end

  def save
    if @C_id == nil
      result = @conn.exec('INSERT INTO two_composers (first_name, ' \
      'last_name, period, nationality, birthday, favorite_instrument, composer_id) ' \
        "VALUES ('#{@first_name}', '#{@last_name}', '#{@period}', '#{@nationality}', '#{@birthday}', '#{@favorite_instrument}', '#{@composer_id}') RETURNING C_id")

      @C_id = result[0]['id'].to_i
    else
      @conn.exec('UPDATE two_composers SET ' \
    "first_name = '#{@first_name}', " \
    "last_name = '#{@last_name}', " \
    "period = '#{@period}', " \
    "nationality = '#{@nationality}'," \
    "birthday = '#{@birthday}', " \
    "favorite_instrument = '#{@favorite_instrument}', " \
    "composer_id = '#{@composer_id}', " \
    "WHERE C_id = '#{@C_id}'")
    end
  end
end

def create_table(conn)
  conn = PG.connect(dbname: 'test')
  conn.exec('CREATE TABLE IF NOT EXISTS two_composers' \
    '(C_id SERIAL PRIMARY KEY, first_name VARCHAR, ' \
    'last_name VARCHAR, period VARCHAR, nationality VARCHAR, birthday INTEGER, ' \
    'favorite_instrument VARCHAR, composer_id INTEGER)')
end



def main
  conn = PG.connect(dbname: 'test')
  create_table(conn)
  bach = ComposerBuild.new(first_name: "Johann S.", last_name: "Bach", period: "Baroque", nationality: "German", birthday: 1685, favorite_instrument: "Organ", composer_id: 1)
  bach.save
  p bach
  chopin = ComposerBuild.new(first_name: "Frederick", last_name: "Chopin", period: "Romantic", nationality: "Polish", birthday: 1810, favorite_instrument: "Piano", composer_id: 2)
  chopin.save
  p chopin
  beethoven = ComposerBuild.new(first_name: "Ludwig van", last_name: "Beethoven", period: "Classical", nationality: "Austrian", birthday: 1770, favorite_instrument: "Chamber", composer_id: 3)
  beethoven.save
  p beethoven
  mozart = ComposerBuild.new(first_name: "Wolfgang", last_name: "Mozart", period: "Classical", nationality: "Austrian", birthday: 1755, favorite_instrument: "Piano", composer_id: 4)
  mozart.save
  p mozart
end

main if __FILE__ == $PROGRAM_NAME
