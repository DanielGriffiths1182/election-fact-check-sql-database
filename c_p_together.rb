require_relative 'composer'
require_relative 'pieces'


def main
  comp_id = connect_to_pieces(composer_last_name)
  #def all_hillary(conn)
  #  clinton = conn.exec("SELECT * FROM factcheck_table WHERE statement_author = 'Hillary Clinton'")
  #  clinton.each_entry do |clinton_stuff|
  #    puts "#{clinton_stuff['statement_author']} made a #{clinton_stuff['true_or_false']} statement on #{clinton_stuff['topic']}, in reference to #{clinton_stuff['reffering_to']}. She said : #{clinton_stuff['statement']}."
  #  end
  #end
end
  #
  #hillary1 = ElectionFact.new(statement_author: "hilary",  \
  # topic: "economy", reffering_to: "bush", statement: "hello", \
  # true_or_false: true, why: "why")
  #
  # hillary1.save
  #
  # p hillary1
  #input = gets.chomp

#Pieces.new(1, 2, 3, 4, 5, 6, comp_id, 8)
#end

main if __FILE__ == $PROGRAM_NAME
