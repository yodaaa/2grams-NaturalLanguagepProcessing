require 'csv'

class String
  def to_ngram(n)
    self.each_char
    .each_cons(n)
    .map(&:join)
  end
end

#ファイル読み込み&2-gram計算&csv
def method2gram(filename)
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
  CSV.open("result_2gram.csv", "wb") do |test|
    #test << ["/", *'a'..'z']
    test << [*'a'..'z']
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


#ファイル読み込み
method2gram("doc1.txt")
