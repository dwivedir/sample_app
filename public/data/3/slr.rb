# slr parsing for grammar
#    E -> T + E
#    E -> T
#    T -> i

hash = {}
hash["s0"] = {}
hash["s1"] = {}
hash["s2"] = {}
hash["s3"] = {}
hash["s4"] = {}
hash["s5"] = {}
hash.default = -1

# parsing table
hash["s0"]["i"] = "s3"
hash["s0"]["E"] = 1
hash["s0"]["T"] = 2

hash["s1"]["$"] = "Accept"

hash["s2"]["+"] = "s4"
hash["s2"]["$"] = "r2"

hash["s3"]["+"] = "r3"
hash["s3"]["$"] = "r3"

hash["s4"]["i"] = "s3"
hash["s4"]["E"] = 5
hash["s4"]["T"] = 2

hash["s5"]["$"] = "r1"

# formation of hash table completed 
# default value -1 means a parsing error
#

input = gets.chomp
input = input.split("")
input.push("$")
input.reverse!
stack = []
stack.push("s0")

while stack.last != "Accept"
  puts stack.inspect
  puts input.inspect


  value = hash[stack.last][input.last]
  if value == -1 || value.nil?
    puts "parsing error"
    break
  else
    if value == "Accept" || value.include?("s")
      puts "shift operation"
      stack.push(value)
      input.pop
    else
      puts "reduce operation #{value}"
      if value == "r1"
        right = "E"
        stack.pop
        stack.pop
        stack.pop
      elsif value == "r2"
        stack.pop
        right = "E"
      else
        stack.pop
        right = "T"
      end
      state = "s"
      state += hash[stack.last][right].to_s
      stack.push(state)
    end
  end
end

if stack.last == "Accept"
  puts "statement is syntactically correct !!!"
end


