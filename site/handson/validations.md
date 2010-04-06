# Tag 1, Hands-On 3: Validierungen

## Ziel

Objekte vor ihrer Speicherung in der Datenbank validieren können.

## Aufgabe

1. Ein zentraler Gedanke bei Twitter (und damit auch bei unserem Klon) ist es,
dass die Nachrichten sehr kurz sind. Sie werden daher auf 140 Zeichen
beschränkt (ja, noch weniger als SMS mit 160 Zeichen). Damit auch in unserer
Anwendung keine längeren Mitteilungen geschrieben werden können, soll ein
entsprechender Validator hinzugefügt werden. Kleiner Tipp noch: Leere
Mitteilungen machen nicht wirklich Sinn.

2. Falls ein Nutzer zu viele Zeichen eingegeben hat, oder überhaupt gar keine,
dann sollen ihn entsprechende Fehler darauf aufmerksam machen.

## Ressourcen

* [Active Record Validations](http://guides.rails.info/activerecord_validations_callbacks.html "Active Record Validations and Callbacks")

## Wichtige Informationen

* Die Validierung findet statt bevor das Objekt gespeichert wird.

* Jedes ActiveRecord Objekt hat eine `valid?` Methode, mit der
  die Validierung explizit getriggert werden kann.

* Scheitert eine Validierung, so wird die Fehlermeldung dem `errors`-Objekt
  hinzugefügt und kann in der View zur Fehlerausgabe verwendet werden.

* Die Ausgabe der Fehler lässt sich in der View über die Hilfsmethode
  `error_messages_for` realisieren.

### Einige Standardvalidierungen:

    !!!ruby_on_rails
    validates_presence_of :first_name, :last_name # Attribute 'first_name' und 'last_name' dürfen nicht leer sein
    validates_uniqueness_of :username # Attribut 'username' muss einzigartig sein
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i # Attribut 'email' muss dem angegebenen Format entsprechen
    validates_length_of :password, :minimum => 5 # Attribut 'password' muss mindestens 5 Zeichen lang sein
    
    user = User.new
    user.valid? # => false
    user.errors.include? :email # => true
    user.errors # => {:email=>["can't be blank", "is invalid"], :last_name=>["can't be blank"], :first_name=>["can't be blank"]}

### Eigene Validierung:

    !!!ruby_on_rails
    def validate 
      errors.add(birthday, "Who are you? Methusalem?") unless birthday < Time.parse("01-01-1900") 
    end