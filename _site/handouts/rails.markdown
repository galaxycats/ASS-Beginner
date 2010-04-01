# Tag 1, Hands-On 2: Getting started with Rails

## Ziel des Hands-on

Ein Rails Projekt aufsetzen können und die Datenbank einrichten und migrieren

## Aufgabe

1. Es soll die Projektstruktur für die "MyBlog" Applikation angelegt werden.
Anschließend soll als erstes die Datenbank angelegt werden, anschließend soll
das erste Modell der Applikation erzeugt werden. Als Hilfestellung dient das
angefügte Flowchart der Blog-Applikation. Am Ende sollen die CRUD
Funktionalitäten für das erzeugte Modell verfügbar sein und über den Browser
ansprechbar sein. Mögliche Felder für einen Blogeintrag wären zum Beispiel:

  * Titel
  * Author (Name / Email)
  * Inhalt

2. Damit beim Aufruf der URL direkt die Liste aller Blogeinträge angezeigt
wird, und nicht die "Welcome aboard" Nachricht von Rails, soll eine Default
Route eingerichtet werden.

3. Mit Hilfe von `ActiveRecord::Migration` sollen die nötigen
Datenbank-Tabellen angelegt werden.

## Ressourcen

* [http://railsapi.com](http://railsapi.com/ "Rails Searchable API Doc")
* Rails Guides ([http://guides.rails.info/](http://guides.rails.info/ "Rails Guides"))
* [http://guides.rails.info/getting_started.html](http://guides.rails.info/getting_started.html "Getting Started with Rails")
* [http://guides.rails.info/migrations.html](http://guides.rails.info/migrations.html "Migrations")
* Bonus: [http://guides.rails.info/command_line.html](http://guides.rails.info/command_line.html "A Guide to The Rails Command Line")

## Shortcuts

### Rails Projektstruktur initialisieren

    rails <appname>

### Generatoren und rake-Tasks

Zunächst muss eine Resource mit Hilfe des folgenden Befehls generiert werden:
`rails generieren resource <ResourceName> <attribubute>:<attribute_type>`.
Dabei werden alle relevanten Dateien erzeugt, von der Migration über das
Modell bis hin zum Controller. Hier ein Beispiel:
  
    rails generate resource message content:string
    ($> ~/projects/ass/twitter-clone)
        invoke  active_record
        create    db/migrate/20100312165212_create_messages.rb
        create    app/models/message.rb
        invoke    test_unit
        create      test/unit/message_test.rb
        create      test/fixtures/messages.yml
        invoke  controller
        create    app/controllers/messages_controller.rb
        invoke    erb
        create      app/views/messages
        invoke    test_unit
        create      test/functional/messages_controller_test.rb
        invoke    helper
        create      app/helpers/messages_helper.rb
        invoke      test_unit
        create        test/unit/helpers/messages_helper_test.rb
         route  resources :messages
  
Jetzt kann man direkt die erzeugte Migration ausführen und den Server starten:
  
* Migration ausführen: `rake db:migrate` 
* Server starten: `rails server`

**Aber** wir wollen uns das ganze erstmal ohne Web Server auf der *Console*
ansehen:

     $> rails console
      irb> Message
          => Message(id: integer, content: string, created_at: datetime, updated_at: datetime)
      irb> message = Message.new(:content => "Dies ist meine erste Nachricht.")
          => #<Message id: nil, content: "Dies ist meine erste Nachricht.", created_at: nil, updated_at: nil>
      irb> message.save
          => true
      irb> message
          => #<Message id: 1, content: "Dies ist meine erste Nachricht.", created_at: "2010-03-12 17:02:41", updated_at: "2010-03-12 17:02:41">

### Konventionen

* ActiveRecord Klassen sind immer im Singular
* ActionController Klassen sind immer im Plural

### Wichtige Dateien

* Templates: `RAILS_ROOT/app/views/<ControllerName>/<action>.html.erb`
* Controller: `RAILS_ROOT/app/controllers/<ControllerName>_controller.rb`
* Modelle: `RAILS_ROOT/app/models/<ModelName>.rb`
* Konfiguration: `RAILS_ROOT/config/`
* Routing Konfiguration: `RAILS_ROOT/config/routes.rb`
* Statische Inhalte: `RAILS_ROOT/public`

### Migrationen

Migrationsdateien: `db/XXX_<name>.rb` wobei XXX ein automatisch generierter
Timestamp ist.

Wichtige Methoden:

* `create_table / drop_table`
* `t.string :spalten_name` erzeugt eine neue Spalte vom Typ `string` während des `create_table` Blocks
* `t.integer :spalten_name` erzeugt eine neue Spalte vom Typ `string` während des `create_table` Blocks
* `add_column(table_name, column_name, type, options) / remove_column(table_name, column_name)`

Datentypen:

* Die Datentypen werden in die spezifischen DB Typen übersetzt. 
* `integer, float, datetime, date, timestamp, time, text, string, binary, boolean`
* relevant sind für uns hauptsächlich `integer, string, text, datetime und boolean`

**Wichtig** In der `self.down` Methode müssen immer die Aktionen der `self.up`
Methode rückgängig gemacht werden.


