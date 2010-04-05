# Tag 1, Hands-On 2: Getting started with Rails

## Ziel

Ein Rails Projekt aufsetzen und die dazugehörige Datenbank einrichten
und migrieren können.

## Aufgabe

1. Über die Dauer des Kurses soll eine kleine aber voll funktionsfähige
Webanwendung entstehen. Dazu wollen wir zusammen den Webdienst
[Twitter](http://twitter.com/ "Twitter") nachbauen. Dabei handelt es sich um
eine Plattform auf der sich jeder kostenfrei anmelden kann und in Form von 140
Zeichen seinen aktuellen Status der Welt mitteilen kann. Eine solche
Statusmitteilung kann dabei so ziemlich alles sein was sich eben in 140
Zeichen ausdrücken lässt: Ein interessanter Link, ein lustiges Video bei
YouTube, was ich gerade Esse, wo ich gerade bin oder an was ich gerade
arbeite. Diese Statusmitteilung werden so in einer Liste dargestellt, dass
jeweils die aktuellste Mitteilung ganz oben steht. Diese Liste bezeichnen wir
daher als Timeline. Interessant wird das ganze nun, wenn man das Konzept von
"Followern" einführt. Hierbei geht es darum, dass ich als Nutzer bestimmten
anderen Leuten "folgen" kann, also deren Statusmitteilungen ebenfalls zu
meinen in meiner persönlichen Timeline angzeigt werden. So bin ich zum
Beispiel immer auf dem laufenden über das was meine Freunde gerade machen oder
für spannend im Netz erachten. Zusätzlich kann ich in meinen
Statusmitteilungen andere Nutzer explizit erwähnen, also "mention". Diese
Mentions werden mir auch dann immer in meiner persönlichen Timeline angezeigt,
wenn ich dem Nutzer nicht explizit folge. Zusätzlich zu der persönlichen
Timeline eines Benutzers (die auch nur er im eingeloggten Zustand sehen kann)
hat jeder Nutzer auch eine öffentliche Timeline, in der nur seine
Statusmitteilungen zu sehen sind, also ohne Mentions und Mitteilungen von
gefolgten Nutzern (Followee). Darüber hinaus gibt es auch eine Haupt-Timeline
in der alle Nachrichten aller Nutzer auftauchen und die für jeden öffentlich
einsehbar ist. Die wesentlichen Elemente der Anwendung sind demnach:

  * Benutzer
  * Statusmitteilungen
  * Beziehungen zwischen Benutzern (Follower)
  * Beziehungen zwischen Benutzern und Statusmitteilungen (Mentions)

2. Auf der Haupt-URL (`http://localhost:3000/`) soll die öffentliche Timeline
angezeigt werden. Dazu muss die `index.html` aus dem `public`-Verzeichnis der
Rails-Anwendung gelöscht und eine `root`-Route angelegt werden.

3. Mit Hilfe von `ActiveRecord::Migration` sollen die nötigen
Datenbank-Tabellen angelegt werden.

## Ressourcen

* [Rails Searchable API Doc](http://railsapi.com/ "Rails Searchable API Doc")
* [Rails Guides](http://guides.rails.info/ "Rails Guides")
* [Getting Started with Rails](http://guides.rails.info/getting_started.html "Getting Started with Rails")
* [Migrations](http://guides.rails.info/migrations.html "Migrations")
* *Bonus:* [A Guide to The Rails Command Line](http://guides.rails.info/command_line.html "A Guide to The Rails Command Line")

## Shortcuts

### Rails installieren und Projektstruktur initialisieren

    !!!plain_text
    $> gem update --system
    $> gem --version
    1.3.6
    $> gem install rails --pre
    
Rails-Projekt generieren:

    !!!plain_text
    $> rails <appname>

### Generatoren und rake-Tasks

Zunächst muss eine Resource mit Hilfe des folgenden Befehls generiert werden:
`rails generieren resource <ResourceName> <attribubute>:<attribute_type>`.
Dabei werden alle relevanten Dateien erzeugt, von der Migration über das
Modell bis hin zum Controller. Hier ein Beispiel:
  
    !!!plain_text
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

    !!!plain_text
     $> rails console
      irb> Message
          => Message(id: integer, content: string, created_at: datetime, updated_at: datetime)
      irb> message = Message.new(:content => "Dies ist meine erste Nachricht.")
          => #<Message id: nil, content: "Dies ist meine erste Nachricht.", created_at: nil, updated_at: nil>
      irb> message.save
          => true
      irb> message
          => #<Message id: 1, content: "Dies ist meine erste Nachricht.", created_at: "2010-03-12 17:02:41", updated_at: "2010-03-12 17:02:41">
          
#### Einrichten der Rails Console

Die Console lässt sich um einige Gimmicks erweitern, wie etwa
Syntax-Highlighting. Eine weitere sinnvolle Anpassung ist die Umleitung der
Logausgaben auf STDOUT. So kann man direkt in der Console sehen wie etwa die
SQL-Query aussieht, die von Rails generiert wird. Um dass zu erreichen, müssen
zwei kleine Gems (Ruby Bibliotheken) installiert werden:

    !!!plain_text
    $> gem install wirble
    $> gem install utility_belt

Danach muss noch eine `.irbrc`-Datei im Home-Verzeihnis angelegt mit folgendem
Inhalt angelegt werden:

    # load libraries
    require 'rubygems'
    require 'wirble'  
    require 'utility_belt'

    # start wirble (with color)
    Wirble.init
    Wirble.colorize

    IRB.conf[:SAVE_HISTORY] = 100
    IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

    if Object.const_defined?('Rails')
      Rails.logger.instance_variable_set("@log", STDOUT)
    end

Anschließend müssen nun noch die zuvor installierten Gems im Rails-Projekt
hinzugefügt werden. Dazu einfach folgende Zeilen im `Gemfile` des
Rails-Projektes hinzufügen:

    gem "wirble"
    gem "utility_belt"

### Konventionen

* ActiveRecord Klassen sind immer im Singular
* ActionController Klassen sind immer im Plural

### Wichtige Dateien

* Templates: `app/views/<ControllerName>/<action>.html.erb`
* Controller: `app/controllers/<ControllerName>_controller.rb`
* Modelle: `app/models/<ModelName>.rb`
* Konfiguration: `config/`
* Routing Konfiguration: `config/routes.rb`
* Statische Inhalte: `public`

### Routing

In der Routing-Datei (`config/routes.rb`) muss zu diesem Zeitpunkt nichts weiter getan werden, als eine
`root`-Route anzulegen. Diese beschreibt welche Action mit dazugehörigem Controller beim Aufruf der Haupt-URL (`http://localhost:3000`)
aufgerufen werden soll. Dazu fügt man folgenden Code am Ende der Routing-Definition ein:

    !!!ruby_on_rails
    route :to => "<controller>#<action>"

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