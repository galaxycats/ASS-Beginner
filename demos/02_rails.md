# Rails Projekt aufsetzen

    mkdir tmp
    cd tmp
    rails twitter-clone
    ll
    mate twitter-clone (alternativ open . und dann Verzeichnis per Drag&Drop auf TextMate ziehen)

--> Projektstruktur zeigen
    
    cd twitter-clone
    rails server
    
http://localhost:3000
index.html löschen
http://localhost:3000 --> Fehler
    
    rails generate scaffold message content:text
    
http://localhost:3000/messages --> database-error
    
    rake db:migrate
    
http://localhost:3000/messages --> Komplettes CRUD-Interface
alle generierten Files zeigen
database.yml zeigen
routes.rb öffnen

in Gemfile eintragen, damit Consolen-Logger funktioniert

    sudo gem install wirble utility_belt

    gem "wirble"
    gem "utility_belt"

Dann weiter in der Console

    rails console
    
    message = Message.new
    message.save
    
    Message.all
    Message.all.size
    Message.count
    
    message = Message.new(:content => "Meine erste Nachricht mit Inhalt, erzeugt ueber die console")
    message.save
    
    Message.count
    
    message = Message.create(:content => "Meine erste Nachricht mit Inhalt, erzeugt ueber die console und direkt gespeichert")
    
    Message.all
    Message.first
    Message.last
    empty_messages = Message.where(:content => nil)
    empty_messages.all
    empty_messages.first
    empty_messages.last
    messages_with_nachricht = Message.where(["content LIKE ?", "%Nachricht%"])
    messages_with_nachricht.all
    
    