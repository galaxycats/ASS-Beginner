# Tag 1, Hands-On 1: Getting started with Ruby

## Ziel

Ruby Syntax verstehen und in den Grundzügen schreiben können.

## Aufgabe

1. Gib auf vier verschiedene Arten den String "Hello World!" viermal auf dem
Bildschirm aus. Die unterschiedlichen Methoden sollten möglichst kreativ sein!

2. Eine Liste von Studenten, die Matrikelnummern den Namen der Studenten
zuweist (mind. 4 Studenten in der Liste). Aus dieser Liste sollen die Namen
sortiert ausgegeben werden.

3. Make an `OrangeTree` class. It should have a `height` method which returns
its height, and a `one_year_passes` method, which, when called, ages the tree
one year. Each year the tree grows taller (however much you think an orange
tree should grow in a year), and after some number of years (again, your call)
the tree should die. For the first few years, it should not produce fruit, but
after a while it should, and I guess that older trees produce more each year
than younger trees... whatever you think makes most sense. And, of course, you
should be able to `count_the_oranges` (which returns the number of oranges on
the tree), and `pick_an_orange` (which reduces the `@orange_count` by one and
returns a string telling you how delicious the orange was, or else it just
tells you that there are no more oranges to pick this year). Make sure that
any oranges you don't pick one year fall off before the next year. (["Learn to
Program"](http://pine.fm/LearnToProgram/ "Learn to Program, by Chris Pine") von *Chris Pine*)

## Ressourcen

* [Rails Searchable API Doc](http://railsapi.com/ "Rails Searchable API Doc")
* [Ruby Quick Reference Card](http://www.scribd.com/doc/7991776/Refcard-30-Essential-Ruby "Refcard #30: Essential Ruby")

## Shortcuts

### Environment Setup

    export PATH=/usr/local/bin:$PATH

### Strings

    "Das ist ein String"
    'Das hier auch'

### Symbols    

    :das_ist_ein_symbol

### Arrays

    [1,2,3]
    %w(eins zwei drei)

### Hash
  
    { :key => 'value', :another_key => 'another_value' }

### Ranges

    0..4

### Schleifen
    
    4.times { |n| puts n }

    while i &lt; 10 
      # do something 
    end

    [1,2,3].each { |x| puts x+1 }

    for i in 0..10 do |n| 
      # do something with 'n'
    end 

### Ausgabe

    puts string # => Die String Representation eines Objektes (durch Aufruf der Methode 'to_s')
    
    puts obj.inspect # => i.d.R. mehr Details über ein Object bei der Ausgabe

### Allgemeines

* Ruby Source Dateien: `my_ruby_prog.rb`
* Ruby Interpreter starten: `ruby <dateiname>.rb`
* Interactive Ruby Shell starten: `irb`
* Interactive Ruby Shell starten und Bibliothek laden: `irb -r bib.rb`
* Rückgabewerte: Eine Funktion gibt **immer den zuletzt evaluierten Wert zurück**, auch ohne Angabe des Schlüsselworts `return`. 

### Konventionen

* Klassen-/Modulnamen werden in CamelCase notiert
* Methodenamen werden mit Unterstrichen notiert (`find_by_name`)
* Methoden, die das Callerobjekt verändern haben einen Ausrufezeichen (`sort!`) 
* Methoden, die true oder false zurückgeben haben ein Fragezeichen (`instance_of?`) 


