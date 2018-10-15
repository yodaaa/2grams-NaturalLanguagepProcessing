# coding: UTF-8
require 'csv'

class String
  def to_ngram(n)
    self.each_char
    .each_cons(n)
    .map(&:join)
  end
end

# 品詞頻度カウント
partof　= Array["動詞","形容詞","形容動詞","名詞","副詞","連体詞","接続詞","感動詞","助詞","助動詞","記号"]
cnt = Array.new(11, 0) # 動詞,形容詞,形容動詞,名詞,副詞,連体詞,接続詞,感動詞,助詞,助動詞,記号
AbcOfPartOfSpeech = ""
NumOfPartOfSpeech = ""

File.open("result.txt", mode = "rt"){|f|
  f.each_line{|line|
    #p line

    ["動詞","形容詞","形容動詞","名詞","副詞","連体詞","接続詞","感動詞","助詞","助動詞","記号"].each_with_index { |i, count|
      if line.slice(i) != nil
        p line.slice(i)
        p count
        cnt[count] = cnt[count] + 1
        puts "cnt: #{cnt[count]}"
        abc = [*'a'..'k']
        AbcOfPartOfSpeech << abc[count]
        NumOfPartOfSpeech << count.to_s
      end
    }
  }
  puts "品詞頻度: #{cnt}"
  puts "品詞アルファベット化文字列: #{AbcOfPartOfSpeech}"
}

#品詞バイグラム
gramstr = AbcOfPartOfSpeech.to_ngram(2)
#puts gramstr
#配列化
table = [*'aa'..'ak', *'ba'..'bk', *'ca'..'ck', *'da'..'dk', *'ea'..'ek', *'fa'..'fk',
   *'ga'..'gk', *'ha'..'hk', *'ia'..'ik', *'ja'..'jk', *'ka'..'kk']
#puts table[675] # table[0] => aa  table[26] => ba fin[675]
num = 0
gramtable = Array.new(121, 0)
gramtable.map!(&:to_i)

table.each do |i|
  puts "i:#{i},  num:#{num}"
  gramstr.each do |j|
    if i == j && num < 122
      puts "gramtable#{num}: #{gramtable[num]}, i: #{i}, j: #{j}"
      gramtable[num] = gramtable[num] +  1
    end
  end
  num = num + 1
end

#csv書き込み
num =1

abctable = [*'a'..'k']
csvtable = []
CSV.open("result.csv", "wb") do |test|
  gramtable.each do |i|
    print sprintf("%03d, ",i)
    csvtable.push("#{i}")
    if num % 11 == 0
      #puts
      test <<  csvtable
      num = 0
      csvtable = []
    end
    num = num +1
  end
end
