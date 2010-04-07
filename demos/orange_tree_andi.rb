class OrangeTree
  
  # meters of growth per year
  GROW_PER_YEAR = 1
  
  # zears before tree dies
  YEARS_TO_LIFE = 10
  
  # after how many years yields tree fruits
  YIELD_FRUITS_AFTER = 3
  
  # how many fruits yields the tree per year
  FRUITS_PER_YEAR = 10
  
  # fruits per year age factor
  AGE_FACTOR = 0.6
  
  # orange-tasts
  ORANGE_TASTS = [
    "this was a bad one",
    "mhh tasty",
    "wow, really great",
    "~ wurgh ~",
    "this was really the best one you have ever tasted"
  ]
  
  
  # accessors
  attr_reader :height
  attr_reader :alive
  
  def initialize
    @age = 0
    @height = 0
    @orange_count = 0
    @alive = true
    puts "You planted an orange-tree."
  end
  
  def one_year_passes
    if age == YEARS_TO_LIFE
      die
    else
      # grow
      self.height = height + GROW_PER_YEAR
      # get older
      self.age = age + 1
      # yield oranges
      self.orange_count = FRUITS_PER_YEAR * age * AGE_FACTOR if age >= YIELD_FRUITS_AFTER
      puts "You orange-tree is now #{age} year#{age == 1 ? "" : "s"} old and yields #{orange_count} orange#{orange_count == 1 ? "" : "s"}."
    end
  end
  
  def pick_an_orange
    if orange_count > 0
      self.orange_count = orange_count - 1
      puts ORANGE_TASTS[rand(ORANGE_TASTS.size)]
    else
      puts "No more oranges for this year."
    end
  end
  
  def count_oranges
    puts "#{orange_count} orange#{orange_count == 1 ? "" : "s"} left in this year."
  end

  private
    attr_accessor :orange_count
    attr_accessor :age
    attr_writer :height
    attr_writer :alive
    
    def die
      self.alive = false
      @height = 0
      @orange_count = 0
      puts "your orange-tree died after #{age} years."
    end
    
end

%w(one_year_passes count_oranges pick_an_orange).each do |method|
  OrangeTree.class_eval <<-eval_code
    alias_method :#{method}_without_die, :#{method}
    
    def #{method}
      if alive
        #{method}_without_die
      else
        puts "Your orange-tree is dead"
      end
    end
    eval_code
end


ot = OrangeTree.new

13.times do
  ot.one_year_passes
  rand(20).times { ot.pick_an_orange }
end