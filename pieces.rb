require 'pg'
require_relative 'composer'

class PieceBuild
  def initialize(options)
    @composer_last_name = options[:composer_last_name]
    @date_composed = options[:date_composed]
    @tonic = options[:tonic]
    @period = options[:period]
    @orchestration = options[:orchestration]
    @id = options[:id]
    @comp_id = options[:comp_id]
    @conn = PG.connect(dbname: 'test')
  end

  def save
    if @id == nil
      result = @conn.exec('INSERT INTO classical_pieces (composer_last_name, ' \
      'date_composed, tonic, period, orchestration) ' \
        "VALUES ('#{@composer_last_name}', '#{@date_composed}', '#{@tonic}', '#{@period}', '#{@orchestration}') RETURNING id")

      @id = result[0]['id'].to_i
    else
      @conn.exec('UPDATE newfactdata SET ' \
    "composer_last_name = '#{@composer_last_name}', " \
    "date_composed = '#{@date_composed}', " \
    "tonic = '#{@tonic}', " \
    "period = '#{@period}', " \
    "orchestration = '#{@orchestration}', " \
    "WHERE id = '#{@id}'")
    end
  end
end

def create_table(conn)
  conn = PG.connect(dbname: 'test')
  conn.exec('CREATE TABLE IF NOT EXISTS classical_pieces(id SERIAL PRIMARY KEY, composer_last_name VARCHAR, date_composed INTEGER, tonic VARCHAR, period VARCHAR, orchestration VARCHAR)')
end

def alter_foreign(conn)
  conn = PG.connect(dbname: 'test')
  conn.exec('ALTER TABLE classical_pieces
  ADD FOREIGN KEY (id) REFERENCES classical_composers (composer_id);')
end

def main
  conn = PG.connect(dbname: 'test')
  create_table(conn)
  moonlight = PieceBuild.new(composer_last_name: "Beethoven", date_composed: 1801, tonic: "c sharp minor", period: "Classical", orchestration: "Piano")
  moonlight.save
  p moonlight
  alter_foreign(conn)
end


main if __FILE__ == $PROGRAM_NAME
