# coding: UTF-8
require 'csv'

class String
  def to_ngram(n)
    self.each_char
    .each_cons(n)
    .map(&:join)
  end
end

def file_output(content)
  File.open("result_6.txt", mode = "a"){|f|
    f.write("#{content}\n")  # ファイルに書き込む
  }
end

# 品詞頻度カウント
cnt = Array.new(11, 0) # 動詞,形容詞,形容動詞,名詞,副詞,連体詞,接続詞,感動詞,助詞,助動詞,記号
AbcOfPartOfSpeech = ""

File.open("result_6.txt", mode = "w"){|f|
  f.write("")  # ファイルに書き込む
}

File.open("result.txt", mode = "rt"){|f|
  part_of_speech = ["動詞","形容詞","形容動詞","名詞","副詞","連体詞","接続詞","感動詞","助詞","助動詞","記号"]
  f.each_line{|line|
    #p line

    ["動詞","形容詞","形容動詞","名詞","副詞","連体詞","接続詞","感動詞","助詞","助動詞","記号"].each_with_index { |i, count|
      if line != nil && line.slice("EOS") != "EOS"
        array = line.split
        #puts array
        array = array[1].split(",")
        #puts array[0]

        if array[0] == i #一致した場合
          cnt[count] = cnt[count] + 1
          #puts "cnt: #{cnt[count]}"
          abc = [*'a'..'k']
          AbcOfPartOfSpeech << abc[count]
        end
      end
    }
  }
  #計算結果(頻度)表示 && 品詞アルファベット化文字列表示
=begin
  puts "------------------------------------"
  part_of_speech.zip(cnt).each {|part, row|
    puts "#{part} : #{row}"
  }
  puts "------------------------------------\n\n"
=end

  file_output("・品詞の頻度をカウント\n------------------------------------")
  part_of_speech.zip(cnt).each {|part, row|
     file_output("#{part} : #{row}")
  }
  file_output("------------------------------------\n")

  #puts "品詞アルファベット化文字列: #{AbcOfPartOfSpeech}"
  file_output("品詞アルファベット化文字列: #{AbcOfPartOfSpeech}\n")
  file_output("------------------------------------\n")
}

#品詞バイグラム
gramstr = AbcOfPartOfSpeech.to_ngram(2)
#puts gramstr
#配列化
table = [*'aa'..'ak', *'ba'..'bk', *'ca'..'ck', *'da'..'dk', *'ea'..'ek', *'fa'..'fk',
  *'ga'..'gk', *'ha'..'hk', *'ia'..'ik', *'ja'..'jk', *'ka'..'kk']

  num = 0
  gramtable = Array.new(121, 0)
  gramtable.map!(&:to_i)

  table.each do |i|
    gramstr.each do |j|
      if i == j && num < 122
        #puts "gramtable#{num}: #{gramtable[num]}, i: #{i}, j: #{j}"
        gramtable[num] = gramtable[num] +  1
      end
    end
    num = num + 1
  end

  #csv書き込み
  num =1
  abctable = [*'a'..'k']
  csvtable = []

  file_output("・品詞バイグラムをカウント\n")
  CSV.open("result.csv", "wb") do |test|
    gramtable.each do |i|
      #print sprintf("%03d, ", i)
      csvtable.push("#{i}")
      if num % 11 == 0
        #puts
        test <<  csvtable
        file_output("#{csvtable}\n")
        num = 0
        csvtable = []
      end
      num = num +1
    end
  end

  file_output("------------------------------------\n")

  #それぞれの品詞について、連続する品詞の確率を計算
  num = 1
  sum = []
  count = 0
  ptable = Array.new(0, 0)
  ptable.map!(&:to_i)
  probabilityOfSuccessivePartsOfSpeech = Array.new(0, 0) #連続する品詞の確率配列
  probabilityOfSuccessivePartsOfSpeech.map!(&:to_i)

  file_output("・それぞれの品詞について、連続する品詞の確率を計算\n")
  gramtable.each_with_index do |i, count|
    ptable.push(i)
    if ptable.length == 11 && count != 0
      sum[(count/10)-1] = ptable.inject(:+)
      ptable = []
    end
  end
  puts "sum: #{sum.compact!}"

  ptable = []
  gramtable.each_with_index do |i, count|
    ptable.push(i)
    if sum[count/11] == 0 then
      probabilityOfSuccessivePartsOfSpeech[count] = 0.0
    else
      probabilityOfSuccessivePartsOfSpeech[count] = ptable[count]/sum[(count)/11].to_f
    end
  end

  part_of_speech = ["動詞","形容詞","形容動詞","名詞","副詞","連体詞","接続詞","感動詞","助詞","助動詞","記号"]
  probabilityOfSuccessivePartsOfSpeech.each_with_index do |i, count|
    if count % 11 == 0 || count == 0
      file_output("- - -\n・#{part_of_speech[(count/11)]}\n")
    end

    #print "#{probabilityOfSuccessivePartsOfSpeech[count]}, "
    file_output("#{probabilityOfSuccessivePartsOfSpeech[count]}, ")

  end
