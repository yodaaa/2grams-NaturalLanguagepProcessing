require 'csv'

class String
  def to_ngram(n)
    self.each_char
    .each_cons(n)
    .map(&:join)
  end
end

#ファイル読み込み&2-gram計算&csv
def method2gram(filename, output_filename)
  f = File.open(filename)
  str = f.read
  gramstr = str.to_ngram(2)
  #puts 2gramstr
  #puts "t".ord
  f.close

  #配列化
  table = [*'aa'..'zz']
  #puts table[675] # table[0] => aa  table[26] => ba fin[675]
  num = 0
  gramtable = Array.new(676)
  gramtable.map!(&:to_i)

  table.each do |i|
    gramstr.each do |j|
      if i == j
        gramtable[num] = gramtable[num] + 1
      end
    end
    num = num +1
  end

  #csv書き込み
  num =1
  num2 = 0
  abctable = [*'a'..'z']
  csvtable = []
  CSV.open(output_filename, "wb") do |test|
    #test << ["/", *'a'..'z']
    #test << [*'a'..'z']
    #csvtable = abctable[num2]
    gramtable.each do |i|
      #print sprintf("%03d, ",i)
      csvtable.push("#{i}")
      if num % 26 == 0
        #puts
        test <<  csvtable
        num = 0
        csvtable = []
      end
      num = num +1
    end
  end

end

def result_2gram(input_filename)
  row_all = []
  row_hoge = []
  CSV.foreach("result_2gram.csv") do |row|
    26.times do |i|
      row_all << row[i].to_i
      #p row_all
    end
  end

  CSV.foreach(input_filename) do |row|
    26.times do |i|
      row_hoge << row[i].to_i
      #p row_hoge
    end
  end

  675.times do |i|
    row_all << row_all[i] + row_hoge[i]
  end
  p row_all

  CSV.open("result_2gram", "wb") do |test|

  end
end


#ファイル読み込み
9.times do |file|
  method2gram("doc#{file+1}.txt", "result_2gram_doc#{file+1}.csv")
end

#結果csvファイル合算
9.times do |file|
  result_2gram("result_2gram_doc#{file+1}.csv")
end

#合算csvファイル合算
method2gram("doc.txt", "result_2gram_doc.csv")
method2gram("doc_espanol.txt", "result_2gram_doc_espanol.csv")
