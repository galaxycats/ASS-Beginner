# Tag 1, Hands-On 1.1: Ruby Essentials

## Ziel

Hier zeigen wir ein paar ausführlichere Ruby Beispiel und gehen noch mal auf
die zentralen Konzepte der Objekt-Orientierung ein.

## Konzepte der OOP

### Abstraktion
 
Jedes Objekt im System kann als ein abstraktes Modell eines Akteurs
betrachtet werden, der Aufträge erledigen, seinen Zustand berichten und
ändern und mit den anderen Objekten im System kommunizieren kann, ohne
offenlegen zu müssen, wie diese Fähigkeiten implementiert sind (vgl.
abstrakter Datentyp (ADT)). Solche Abstraktionen sind entweder Klassen (in
der klassenbasierten Objektorientierung) oder Prototypen (in der
prototypbasierten Programmierung).
 
* *Klasse* Die Datenstruktur eines Objekts wird durch die Attribute (auch
  Eigenschaften) seiner Klassendefinition festgelegt. Das Verhalten des
  Objekts wird von den Methodern der Klasse bestimmt. Klassen können von
  anderen Klassen abgeleitet werden (Vererbung). Dabei erbt die Klasse die
  Datenstruktur (Attribute) und die Methoden von der vererbenden Klasse
  (Basisklasse).
* *Prototype* Objekte werden durch das Clonen bereits existierender Objekte
  erzeugt und können anderen Objekten als Prototypen dienen und damit ihre
  eigenen Methoden zur Wiederverwendung zur Verfügung stellen, wobei die
  neuen Objekte nur die Unterschiede zu ihrem Prototypen-Objekt definieren
  müssen.
 
### Datenkapselung
 
Als Datenkapselung bezeichnet man in der Programmierung das Verbergen von
Implementierungsdetails. Der direkte Zugriff auf die interne Datenstruktur
wird unterbunden und erfolgt statt dessen über definierte Schnittstellen.
Objekte können den internen Zustand anderer Objekte nicht in unerwarteter
Weise lesen oder ändern. Ein Objekt hat eine Schnittstelle, die darüber
bestimmt, auf welche Weise mit dem Objekt interagiert werden kann. Dies
verhindert das Umgehen von Invarianten des Programms.
   
### Polymorphie
 
Verschiedene Objekte können auf die gleiche Nachricht unterschiedlich
reagieren. Wird die Zuordnung einer Nachricht zur Reaktion auf die Nachricht
erst zur Laufzeit aufgelöst, dann wird dies auch späte Bindung genannt.
 
### Feedback
 
Verschiedene Objekte kommunizieren über einen
Nachricht-Antwort-Mechanismus, der zu Veränderungen in den Objekten führt
und neue Nachrichtenaufrufe erzeugt. Dafür steht die Kopplung als Index
für den Grad des Feedback.
 
### Vererbung

Vererbung heißt vereinfacht, dass eine abgeleitete Klasse die Methoden und
Attribute der Basisklasse ebenfalls besitzt, also „erbt“. Somit kann die
abgeleitete Klasse auch darauf zugreifen. Neue Arten von Objekten können
auf der Basis bereits vorhandener Objekt-Definitionen festgelegt werden. Es
können neue Bestandteile hinzugenommen werden oder vorhandene überlagert
werden. Wird keine Vererbung zugelassen, so spricht man zur Unterscheidung
oft auch von objektbasierter Programmierung.

## Everything is an Object!

### Die Basics

    "Alles sind Objekte".class # String
    6.class # Fixnum
    (5.0).class # Float

    # achja ...
    "test".class.class # Class

    # Alles sind Objekte?! Ja alles!
    7.+(7)
    m = 7.method('+')
    m.class
    m.call(7)
    # ... Wirklich alles ist ein Objekt!

    # Wissenwertes: Call-by-Reference
    def modify_arg(arg)
      arg << rand(40)
    end
    array = [12,34,54]
    modify_arg(array)
    array
    
    # Kann mit der +clone+ Methode verhindert werden.
    def modify_arg(arg)
      arg.clone << rand(40)
    end
    array = [12,34,54]
    modify_arg(array)
    array

### Dynamische Typisierung und starke Bindung

    my_string = "7"
    my_string.class # String

    number = 7
    number.class # Fixnum

    number + my_string # TypeError
    number.to_s + my_string # '7hello World' -> Explizites Casten nötig

    # in der irb ...
    self.class
    # -> Es gibt immer ein 'Root'-Objekt
    
### Strings

    # vielleicht so ...
    anzahl_schafe = 6
    new_string = 'Ich habe ' + anzahl_schafe.to_s + ' Schafe.'
    # ... oder besser so!
    new_string = "Ich habe #{anzahl_schafe} Schafe."

### Symbole

    # Symbole als andere Repräsentation von Strings
    jedi1 = {"firstname" => "Anikin", "lastname" => "Skywalker", "rank" => "Jedi Padawan"}
    jedi2 = {"firstname" => "Obi-Wan", "lastname" => "Kenobi", "rank" => "Jedi High General"}
    jedi3 = {:firstname => "Qui-Gon", :lastname => "Jinn", :rank => "Jedi Master"}
    jedi4 = {:firstname => "Mace", :lastname => "Windu", :rank => "Jedi Master"}

    object_ids_of_keys = []

    jedi1.keys.each { |key| object_ids_of_keys << key.object_id }
    jedi2.keys.each { |key| object_ids_of_keys << key.object_id }

    puts object_ids_of_keys.uniq # => 85690, 85750, 85810, 85470, 85530, 85590
    object_ids_of_keys = []

    jedi3.keys.each { |key| object_ids_of_keys << key.object_id }
    jedi4.keys.each { |key| object_ids_of_keys << key.object_id }

    puts object_ids_of_keys.uniq # => 109858, 109938, 110018

### Datenstrukturen

    # In Arrays liegen die Daten sortiert und lassen sich über
    # ihren Index abrufen
    an_array = [1, 2, 3, 4]
    an_array[1]
    an_array_of_words = %w(Geige Gitarre Violine Bass) # so ...
    an_array_of_words = ["Geige", "Gitarre", "Violine", "Bass"] # ... oder so
    an_array_of_words[2]

    # In einem Hash liegen die Daten unsortiert und lassen sich
    # über ihren +key+ abrufen
    an_hash = { :author => "Dave Thomas", "title" => "Programming Ruby" } # Keys können sowohl Symbol als auch String sein
    an_hash[:author]
    an_hash['title']
    
#### Arbeiten mit Datenstrukturen

    # Iteratoren über Datenstrukturen (oder einfach alles was +Enumerable+ implementiert)
    an_hash.each { |k,v| puts "Der Key ist: #{k} und der Value ist #{v}" }
    an_array_of_words.each { |w| puts w }
    
### Klassen

    class Rectangle

      attr_accessor :width, :height

      # attr_reader :width
      # attr_writer :height

      # Konstruktor mit Parametern
      def initialize(width, height)
        # Zwei Instanzvariablen
        @width, @height = width, height # Mehrfachzuweisung ;-)
      end

      # # Getter/Setter - non-Ruby Style
      # def width
      #   @width # Es wird IMMER der letzte Wert zurückgegeben, daher oft kein +return+ noetig!
      # end
      # 
      # def width=(width)
      #   @width = width
      # end
      # 
      # def height
      #   @height
      # end
      # 
      # def height=(height)
      #   @height = height
      # end

      def area
        height * width
      end

      def to_s
        "This is a #{self.class.name} with the dimension: #{width}x#{height}"
      end

      protected

        def meine_protected_methode
          puts "protected"
        end

      private

        def meine_private_methode
          puts "private"
        end

    end

    # - Es gibt keine abstrakten Klassen!
    # - Es gibt aber Vererbung ...
    class Square < Rectangle
      def initialize(width)
        super(width, width)
      end

      def width=(width)
        self.height = width
        self.width  = width
      end

      private 
        attr_writer :height
    end
    
### Variablen

    class String
      def play
        puts "playing song: #{self} ..."
      end
    end

    # Verwendung von Klassen-, Instanzvariablen und Konstanten
    class MusicPlayer

      VENDOR_ID = "00:23:FE:89:EC:42"

      def initialize(playlist)
        @playlist = playlist
      end

      def self.overall_played_tracks
        @@overall_played_tracks ||= 0
      end

      def play_track(track_number)
        @playlist[track_number].play
        @@overall_played_tracks += 1
      end

    end

    puts MusicPlayer::VENDOR_ID # => 00:23:FE:89:EC:42

    mp = MusicPlayer.new(["Duality", "B.Y.O.B"])

    puts MusicPlayer.overall_played_tracks # => 0
    mp.play_track(0) # => playing song: Duality ...
    puts MusicPlayer.overall_played_tracks # => 1
    mp.play_track(1) # => playing song: B.Y.O.B ...
    puts MusicPlayer.overall_played_tracks # => 2
    
### Mixins

    # Über Modules können zusätzliche Funktionalitäten
    # in eine Klasse "gemixt" werden.
    module MultiplierMixin
      def multiply(times)
        data * times
      end
    end

    class MyString
      include MultiplierMixin

      def data
        "foo"
      end
    end

    class MyInteger
      include MultiplierMixin

      def data
        23
      end
    end

    str = MyString.new
    puts str.multiply(3) # => foofoofoo

    int = MyInteger.new
    puts int.multiply(3) # => 69
    
### 
    
### Schleifen und Bedingungen

    for i in 1...10
      puts i
    end

    10.times {|i| puts i}

    a = rand(2)
    if a == 0
      puts "Das war eine Null"
    else
      puts "Das war keine Null"
    end

    puts a == 0 ? "Das war eine Null" : "Das war keine Null"

    while line = gets
      puts "Ihre Eingabe: #{line}"
    end
    
### Blöcke und Procs

Einfach:

    my_proc = Proc.new { puts 'hello world' } # Ohne Uebergabewert
    my_proc.class
    my_proc.call

    my_proc = Proc.new { |to| puts "hello #{to}" } # Mit Uebergabewert
    my_proc.call 'ASS Kurs'

    # Sicherstellen, dass etwas vorher und hinterher gemacht wird.

    do_something = Proc.new { puts "Irgendwas was gemacht wird." }

    def ensure_important_stuff(any_proc)
      puts "Sehr wichtige Sache, die vorher gemacht werden muss!"
      any_proc.call
      puts "Sehr wichtige Sache, die nachher gemacht werden muss!"
    end
    
Ein bisschen komplexer:

    # Proc Objekt
    class Array
      def my_find(find_proc)
        for i in 0...size
          return self[i] if find_proc.call(self[i])
        end
        return nil
      end
    end

    puts [1,3,5,6,7].my_find Proc.new { |e| e.modulo(2) == 0 }

    # Block to Proc
    class Array
      def my_find(&find_block)
        for i in 0...size
          return self[i] if find_block.call(self[i])
        end
        return nil
      end
    end

    puts [1,3,5,6,7].my_find { |e| e.modulo(2) == 0 }

    # Block via yield
    class Array
      def my_find
        for i in 0...size
          return self[i] if yield self[i]
        end
        return nil
      end
    end

    puts [1,3,5,6,7].my_find { |e| e.modulo(2) == 0 }
    