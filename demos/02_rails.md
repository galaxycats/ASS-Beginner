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
    
    rails generate scaffold message content:string
    
http://localhost:3000/messages --> database-error
rake db:migrate
http://localhost:3000/messages --> Komplettes CRUD-Interface
alle generierten Files zeigen
database.yml zeigen
routes.rb öffnen
    