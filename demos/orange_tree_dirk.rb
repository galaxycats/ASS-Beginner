# Make an OrangeTree class. It should have a height method which returns its
# height, and a one_year_passes method, which, when called, ages the tree one
# year. Each year the tree grows taller (however much you think an orange tree
# should grow in a year), and after some number of years (again, your call)
# the tree should die. For the first few years, it should not produce fruit,
# but after a while it should, and I guess that older trees produce more each
# year than younger trees... whatever you think makes most sense. And, of
# course, you should be able to count_the_oranges (which returns the number of
# oranges on the tree), and pick_an_orange  (which reduces the @orange_count by
# one and returns a string telling you how delicious the orange was, or else
# it just tells you that there are no more oranges to pick this year). Make
# sure that any oranges you don't pick one year fall off before the next year.
# 
# Taken from http://pine.fm/LearnToProgram/?Chapter=09
# 
# Coded by Dirk Breuer @ 2008

class OrangeTree
  
  attr_reader :age, :orange_count, :mature_age, :time_to_die, :height
  
  TASTY_TYPES              = %w(delicious foul sweet sour modly biohazard like\ old\ feet)

  FRUITS_PER_YEAR          = 23

  MINIMAL_MATURE_AGE       = 5

  MINIMAL_TIME_TO_LIFE     = 20

  GROW_RANGE_PER_EACH_YEAR = 100
  
  PUBLIC_METHODS           = %w(one_year_passes count_the_oranges pick_an_orange height)
  
  def initialize
    self.age = 1
    self.orange_count = 0
    self.mature_age = rand(MINIMAL_MATURE_AGE) + 1
    self.time_to_die = rand(MINIMAL_TIME_TO_LIFE) + 2*self.mature_age
    self.height = 0
    self.alive = true
  end
  
  def method_missing(meth, *args, &blk)
    puts <<-WARN
The OrangeTree doesn't understands you. Try one of those commands:
  #{PUBLIC_METHODS.join(', ')}
WARN
  end
  
  def tell_height
    puts "The tree #{height} cm high this year."
  end
  
  def pick_an_orange
    if orange_count > 0
      puts "You picked and orange and eat it. It tasted #{TASTY_TYPES[rand(TASTY_TYPES.size)]}."
      self.orange_count -= 1
    else
      puts "There are no more oranges to pick this year. Wait untill next year."
    end
  end
  
  def count_the_oranges
    puts "You see #{orange_count} orange#{orange_count == 1 ? '' : 's'} hanging on the tree."
  end
  
  def one_year_passes
    fall_all_oranges_left
    die_if_too_old
    self.age += 1
    puts "The tree grows and prospers."
    grow_fruits_if_old_enough
    grow_in_height
  end
  
  private
  
    attr_writer :age, :orange_count, :mature_age, :height, :alive, :time_to_die
  
    def fall_all_oranges_left
      puts "All oranges fallen down."
      self.orange_count = 0
    end
    
    def alive?
      @alive
    end
    
    def die_if_too_old
      puts "age: #{age}"
      puts "time_to_die: #{time_to_die}"
      if age >= time_to_die
        puts "The tree is too old and has died!"
        exit(0)
      end
    end
    
    def grow_in_height
      self.height += (rand * GROW_RANGE_PER_EACH_YEAR).ceil
      tell_height
    end
    
    def grow_fruits_if_old_enough
      if age >= mature_age
        self.orange_count += rand(FRUITS_PER_YEAR) + age
        puts orange_count > 0 ? "The tree growed #{orange_count} fruits." : "Sorry, no fruits this year."
      else
        puts "The tree isn't old enough to grow fruits yet."
      end
    end
end

puts
puts <<-WEL
This is the little Orange Tree simulator.
You have one Orange Tree in your garden that
grows each year and will grow fruits you can
eat. You can make the tree grow by calling
one_year_passes and see how many oranges have
been grown with count_the_oranges. Pick one of
them and eat it with pick_an_orange.

But be aware, someday your little tree will die.

Enjoy!
WEL
puts

orange_tree = OrangeTree.new

while true
  print "> "
  what_to_do = STDIN.gets.strip
  case what_to_do
  when "help"
    puts "You can do the following: #{OrangeTree::PUBLIC_METHODS.join(', ')}"
  when "quit"
    exit(0)
  else
    orange_tree.send(what_to_do)
  end
  puts
end