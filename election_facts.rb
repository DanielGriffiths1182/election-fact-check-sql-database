require 'pg'

def create_table(conn)
  conn.exec(
    'CREATE TABLE IF NOT EXISTS factcheck_table ' +
    '(statement_author varchar(20), topic varchar(20), ' +
    'reffering_to varchar(20), statement varchar(250), ' +
    'true_or_false varchar(15), why varchar(250));')
end

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

  puts result
end

def find_by_author(conn)
  conn.exec('SELECT * FROM factcheck_table ORDER BY statement_author ASC')
end

def multi_vett
conn.exec('SELECT * FROM factcheck_table WHERE topic = 'Economy' AND statement_author = 'Berlin'')
end

def main
  conn = PG.connect(dbname: 'test')
  all_facts(conn)
  find_by_author(conn)
  multi_vett
end

main if __FILE__ == $PROGRAM_NAME
