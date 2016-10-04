require 'pg'
require 'pry'
def create_table(conn)
  conn.exec(
    'CREATE TABLE IF NOT EXISTS factcheck_table ' +
    '(statement_author varchar(20), topic varchar(20), ' +
    'reffering_to varchar(20), statement varchar(250), ' +
    'true_or_false varchar(10), why varchar(250));')
end
#change stuff to boolean
def create_data(conn)
  conn.exec(
    "INSERT INTO factcheck_table VALUES ('Donald Trump', 'Crime', 'Black Youth', 'Hillary Clinton called black youth superpredators.', 'True', 'True'),
    ('Hillary Clinton', 'Economy', 'George W. Bush', 'Great Recession in large part due to tax policies of G. W. B.', 'False', 'Unable to provide citation for claims.'),
    ('Donald Trump', 'Foreign Policy', 'Hillary Clinton', 'Hillary Clinton gave up 20 percent of U.S. uranium to Russia.', 'True', 'True'),
    ('Donald Trump', 'Economy', 'Hillary Clinton', 'My Trans-Pacific Partnership position made Hillary change her stance.', 'False', 'More likely, Bernie’s voting base did.'),
    ('Donald Trump', 'Immigration', 'Hillary Clinton', 'Clinton would bring in 620,000 refugees in her first term.', 'False', 'Based in speculation, although her policy includes an increase.'),
    ('Hillary Clinton', 'Crime', 'Black Youth', 'Gun deaths for young black males outpace next 9 causes combined.', 'True', 'true'),
    ('Donald Trump', 'Economy', 'Hillary Clinton', 'Hillary Clinton lauded controversial Trans-Pacific trade deal.', 'True', 'True'),
    ('Donald Trump', 'Economy', 'China', 'They’re using our country as a piggy bank to rebuild china.', 'True', 'This oversimplified statement is more half true, in ballpark.'),
    ('Hillary Clinton', 'Economy', 'Donald Trump', 'Trump would give the biggest tax cuts for the top percent of the people in this country.', 'True', 'Trump however, has revised his tax plan.'),
    ('Hillary Clinton', 'Economy', 'Donald Trump', 'He started his business with $14 million, borrowed from his father.', 'True', 'According to 1985 WSJ report.'),
    ('Donald Trump', 'Economy', 'Donald Trump', 'My father gave me a very small loan in 1975.', 'True', 'Loan value 1M, however his father gave him further loans later on.'),
    ('Hillary Clinton', 'Economy', 'Donald Trump', 'He said, back in 2006, ‘Gee, I hope it does collapse, because then I can go in and buy some and make some money.', 'True', 'He mentioned that it would provide business opportunity.'),
    ('Donald Trump', 'Economy', 'Obama Administration', 'The Obama administration has doubled the national debt in eight years.', 'True', 'Over simplified'),
    ('Hillary Clinton', 'Economy', 'Donald Trump', 'You have taken business bankruptcy six times.', 'True', 'True');")
end

def all_facts(conn)
  result = conn.exec('SELECT count(*) FROM factcheck_table')
  count_all = result.getvalue(0,0).to_i
  puts "The number of fact check entries = #{count_all}."
end

def find_by_author(conn)
  c = conn.exec('SELECT * FROM factcheck_table ORDER BY statement_author ASC')
  c.each_entry do |f|
    puts "On the #{f['topic']}, #{f["statement_author"]}: #{f['statement']} | #{f['true_or_false']} | #{f['why']}."
  end
end

def multi_vett(conn)
  chickens = conn.exec("SELECT * FROM factcheck_table WHERE topic = 'Economy' AND statement_author = 'Hillary Clinton'")
  chickens.each_entry do |chicken|
    puts "#{chicken['statement_author']} said : #{chicken['statement']} while speaking about the #{chicken['topic']}. | #{chicken['true_or_false']} |."
  end
end

def all_hillary(conn)
  clinton = conn.exec("SELECT * FROM factcheck_table WHERE statement_author = 'Hillary Clinton'")
  clinton.each_entry do |clinton_stuff|
    puts "#{clinton_stuff['statement_author']} made a #{clinton_stuff['true_or_false']} statement on #{clinton_stuff['topic']}, in reference to #{clinton_stuff['reffering_to']}. She said : #{clinton_stuff['statement']}."
  end
end

def main
  conn = PG.connect(dbname: 'test')
  all_facts(conn)
  find_by_author(conn)
  multi_vett(conn)
  all_hillary(conn)
end

main if __FILE__ == $PROGRAM_NAME
