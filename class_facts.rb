require 'pg'

class ElectionFact
  def initialize(options)
    @statement_author = options[:statement_author]
    @topic = options[:topic ]
    @reffering_to = options[:reffering_to]
    @statement = options[:statement]
    @true_or_false = options[:true_or_false]
    @why = options[:why]
    @id = options[:id]
    @conn = PG.connect(dbname: 'test')
  end

  def self.create_table
      conn = PG.connect(dbname: 'test')
      conn.exec('CREATE TABLE IF NOT EXISTS newfactdata ' \
        '(id SERIAL PRIMARY KEY,
         statement_author VARCHAR, ' \
        'topic VARCHAR),
         reffering_to VARCHAR,
          statement VARCHAR, ' \
        'true_or_false BOOLEAN,
         why VARCHAR')
  end

  def save
    if @id == nil
      result = @conn.exec('INSERT INTO newfactdata (statement_author, ' \
      'topic, reffering_to, statement, true_or_false, why) ' \
        "VALUES ('#{@statement_author}', '#{@topic}', '#{@reffering_to}', ' \
        ''#{@statement}', '#{@true_or_false}', '#{@why}') RETURNING id'")

      @id = result[0]['id'].to_i
    else
      @conn.exec('UPDATE newfactdata SET ' \
    "statement_author = '#{@statement_author}', " \
    "topic = '#{@topic}', " \
    "reffering_to = '#{@reffering_to}', " \
    "statement = '#{@statement}', " \
    "true_or_false = '#{@true_or_false}', " \
    "why = '#{@why}' " \
    "WHERE id = '#{@id}'")
    end
  end
end

# def all_facts(conn)
#   result = conn.exec('SELECT count(*) FROM factcheck_table')
#   count_all = result.getvalue(0,0).to_i
#   puts "The number of fact check entries = #{count_all}."
# end
#
# def find_by_author(conn)
#   c = conn.exec('SELECT * FROM factcheck_table ORDER BY statement_author ASC')
#   c.each_entry do |f|
#     puts "On the #{f['topic']}, #{f["statement_author"]}: #{f['statement']} | #{f['true_or_false']} | #{f['why']}."
#   end
# end
#
# def multi_vett(conn)
#   chickens = conn.exec("SELECT * FROM factcheck_table WHERE topic = 'Economy' AND statement_author = 'Hillary Clinton'")
#   chickens.each_entry do |chicken|
#     puts "#{chicken['statement_author']} said : #{chicken['statement']} while speaking about the #{chicken['topic']}. | #{chicken['true_or_false']} |."
#   end
# end
#
# def all_hillary(conn)
#   clinton = conn.exec("SELECT * FROM factcheck_table WHERE statement_author = 'Hillary Clinton'")
#   clinton.each_entry do |clinton_stuff|
#     puts "#{clinton_stuff['statement_author']} made a #{clinton_stuff['true_or_false']} statement on #{clinton_stuff['topic']}, in reference to #{clinton_stuff['reffering_to']}. She said : #{clinton_stuff['statement']}."
#   end
# end

def main
  hillary1 = ElectionFact.new(statement_author: "hilary",  \
  topic: "economy", reffering_to: "bush", statement: "hello", \
  true_or_false: true, why: "why")

  hillary1.save

  p hillary1
end
