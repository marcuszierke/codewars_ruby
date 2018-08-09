def solve(s)
  res = []
  letters = ('a'..'z').to_a
  numbers = (1..26).to_a
  s.split(/[a, e, i, o, u]/).each do |combo|
    sum = 0
    if combo.length != 0
      combo.split("").each do |letter|
        sum += numbers[letters.index(letter)]
      end
    end
    res << sum
  end
  res.max
end



def kebabize(str)
  str = str.split(/(?=[A-Z])/)
  str = str.map { |word| word.tr("0-9", "").downcase }
  str.join("-").gsub(/^\W/, "")
end

strng = "/+1-541-754-3010 156 Alphand_St. <J Steeve>\n 133, Green, Rd. <E Kustur> NY-56423 ;+1-541-914-3010;\n"\
"+1-541-984-3012 <P Reed> /PO Box 530; Pollocksville, NC-28573\n :+1-321-512-2222 <Paul Dive> Sequoia Alley PQ-67209\n"\
"+1-741-984-3090 <Peter Reedgrave> _Chicago\n :+1-921-333-2222 <Anna Stevens> Haramburu_Street AA-67209\n"\
"+1-111-544-8973 <Peter Pan> LA\n +1-921-512-2222 <Wilfrid Stevens> Wild Street AA-67209\n"\
"<Peter Gone> LA ?+1-121-544-8974 \n <R Steell> Quora Street AB-47209 +1-481-512-2222!\n"\
"<Arthur Clarke> San Antonio $+1-121-504-8974 TT-45120\n <Ray Chandler> Teliman Pk. !+1-681-512-2222! AB-47209,\n"\
"<Sophia Loren> +1-421-674-8974 Bern TP-46017\n <Peter O'Brien> High Street +1-908-512-2222; CC-47209\n"\
"<Anastasia> +48-421-674-8974 Via Quirinal Roma\n <P Salinger> Main Street, +1-098-512-2222, Denver\n"\
"<C Powel> *+19-421-674-8974 Chateau des Fosses Strasbourg F-68000\n <Bernard Deltheil> +1-498-512-2222; Mount Av.  Eldorado\n"\
"+1-099-500-8000 <Peter Crush> Labrador Bd.\n +1-931-512-4855 <William Saurin> Bison Street CQ-23071\n"\
"<P Salinge> Main Street, +1-098-512-2222, Denve\n"


def phone(strng, num)
  res = ''
  count = 0
  strng.split("\n").each  do |data|
    if data.include?(num)
      count += 1
      phone = "Phone => #{num}"
      name = "Name => #{data.match(/<.+?>/)[0][1..-2]}"
      name_start = data.index('<')
      name_end = data.index('>')
      number_start = data.index('+')
      number_end = data.index('+') + num.length
      if number_start < name_start
        address_line = "#{data[0...number_start]}#{data[number_end + 1..name_start - 1]}#{data[name_end +  1..-1]}".gsub(/[^A-Za-z0-9 -]/, "")
      else
        address_line = "#{data[0...name_start]}#{data[name_end + 1..number_start - 1]}#{data[number_end +  1..-1]}".gsub(/[^A-Za-z0-9 -]/, "")
      end
      address = "Address => #{address_line.strip}"
      res = "#{phone}, #{name}, #{address}"
    end
  end
  return "Error => Too many people: #{num}" if count > 1
  return "Error => Not found: #{num}" if count == 0
  return res
end

# the better solution
def phone(strng, num)
    # clean all
    clean = strng.gsub(/[^-0-9a-z\\\s+A-Z\\\n<>.']/, " ")
    # search num
    p a = clean.scan(/.*\+#{num}.*/)
    if (a.length > 1) then return "Error => Too many people: #{num}" end
    if (a.length == 0) then return "Error => Not found: #{num}" end
    # replace num 
    c = a[0].gsub(/\+#{num}/, "")
    # name
    name = c.scan(/<.*>/)[0]
    # address
    ad = c.gsub(/<.*>/, "").gsub(/\s+/, " ").strip()
    "Phone => " + num + ", Name => " + name[1...name.length-1] + ", Address => " + ad
end

def replace(dirtyFileName)
  dirtyFileName.gsub(/\d+_/, "")
  index_punct = (0 ... dirtyFileName.length).find_all { |i| dirtyFileName[i,1] == '.' }
  dirtyFileName[0...index_punct[1]]
end

def elder_age(m,n,l,t)
  def add_up(m)
    m.zero? ? m : m + add_up(m - 1)
  end
  p immortal = add_up(m - l - 1) * n
  immortal > t ? immortal - t : immortal
end

# p elder_age(25,31,0,100007) #11925
# p elder_age(5,45,3,1000007) #4323
# p elder_age(31,39,7,2345) #1586
# p elder_age(545,435,342,1000007) #808451
# p elder_age(28827050410, 35165045587, 7109602, 13719506) #5456283


def elder_age(columns,rows,loss,time)
  require 'matrix'
  matrix = Matrix.build(rows, columns) do |row, col|
    (value = (row^col) - loss) < 0 ? 0 : value
  end
  (sum = matrix.inject(:+)) > time ? sum - time : sum
end


#p elder_age(31,39,7,2345)

def count_pal(n)  # amount of digits
  counter = 0
  (1..10**n).to_a.each do |num|
    palin = num.to_s.chars
    counter += 1 if palin == palin.reverse
  end
  counter
end

def pig_it text
  res = []
  text.split(' ').each do |word|
    if ["!", ".", "?"].include?(word)
      res << word
    else
      res << word[1..-1] + word[0] + 'ay'
    end
  end
  res.join(' ')
end

# p pig_it('O tempora o mores !')
# p pig_it('Pig latin is cool')
# p pig_it('This is my string')

def bump(x)
  x.chars.count { |item| item == "n" } < 16 ? "Woohoo!" : "Car Dead"
end 

# p bump("n")
# p bump("_nnnnnnn_n__n______nn__nn_nnn")

class Projectile
  def initialize(height, velocity, angle)
    @h = height
    @velocity = velocity
    @angle = angle
  end

  attr_reader :h, :velocity, :angle

  def angles
    @angle * Math::PI / 180
  end

  def height_eq
    if @h == 0
      "h(t) = -16.0t^2 + #{(Math.sin(self.angles) * @velocity).round(3)}t"
    else
      "h(t) = -16.0t^2 + #{(Math.sin(self.angles) * @velocity).round(3)}t + #{@h.to_f}"
    end
  end

  def horiz_eq
    "x(t) = #{(Math.cos(self.angles) * @velocity).round(3)}t"
  end

  def height(t)
    (-16 * t**2 + Math.sin(self.angles) * @velocity * t + @h).round(3)
  end

  def horiz(t)
    (@velocity * Math.cos(self.angles) * t).round(3)
  end

  def landing
    x1 = (-Math.sin(self.angles) * @velocity + ((Math.sin(self.angles) * @velocity)**2 - 4 * -16 * @h)**0.5) / -32
    x2 = (-Math.sin(self.angles) * @velocity - ((Math.sin(self.angles) * @velocity)**2 - 4 * -16 * @h)**0.5) / -32
    x_value = x1 <= 0 ? x2 : x1
    [self.horiz(x_value), 0, x_value.round(3)]
  end
end

# projectile = Projectile.new(5, 2, 45)
# p projectile.height_eq
# p projectile.horiz_eq
# p projectile.height(0.2)
# p projectile.horiz(0.2)
# p projectile.landing

def rgb_to_hex(arr)
  converter = {
    10=> "A",
    11=> "B",
    12=> "C",
    13=> "D",
    14=> "E",
    15=> "F"
  }  
  res = ''
  arr.each do |color|
    2.times do
      remain = color % 16
      color = color / 16
      remain < 10 ? res += remain.to_s : res += converter[remain]
    end
  end
  res.chars.reverse.join
end

def rgb(r, g, b)
  arr = []
  [b, g, r].each do |color|
    if color < 0
      arr << 0
    elsif color > 255
      arr << 255
    else
      arr << color
    end
  end
  rgb_to_hex(arr)
end

def feast(beast, dish)
  #checks if the first and last letter of beast match with first and last letter of dish (8kyu)
  beast[0] == dish[0] && beast[-1] == dish[-1] 
end

def find_next_square(sq)
  #finds the next square of sq if sq is a perfect sqaure. -1 otherwise (7kyu)
  base = sq**0.5
  base % 1 != 0 ? -1 : (base + 1)**2  
end

def find_pattern(arr)
  #retuns the pattern of performed calculations within an array (6kyu)
  pattern = []
  counter = 1
  (1...arr.length).to_a.each do |item|
    pattern << (arr[item] - arr[item - 1])
  end
  simple_pattern = pattern.each_slice(counter).to_a
  while simple_pattern != simple_pattern.select { |arr| arr == simple_pattern[0] }
    counter += 1
    simple_pattern = pattern.each_slice(counter).to_a
  end
  simple_pattern[0]
end

def permutations(string)
  #returns an array of all unique permutations of a given string (4kyu)
  #I am aware that there is a .permutation built-in function but I guess that's not worth 4kyu
  return [string] if string.size < 2
  ch = string[0]
  final = permutations(string[1..-1]).each_with_object([]) do |perm, result|
    (0..perm.size).each { |i| result << perm.dup.insert(i,ch) }
  end
  final.uniq
end







