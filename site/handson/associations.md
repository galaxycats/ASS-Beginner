# Tag 2, Hands-On 6: Relationen zwischen Objekten

## Ziel des Hands-on

Datenbank-Relationen auf Objekt-Ebene umsetzen können und die Session nutzen,
um Nutzer wieder erkennen zu können.

## Aufgabe

1. Bisher haben wir nur Mitteilungen modelliert und implementiert. Allerdings
  ist ja einen Kernkomponente des Systems der Benutzer der die Mitteilungen
  schreibt. Daher soll bei dieser Aufgabe ein Benutzer erzeugt und mit den
  Mitteilungen in Relation gesetzt werden. Ein Benutzer sollte dabei in jedem
  Fall folgende Eigenschaften besitzen:

    * Email-Adresse
    * Benutzernamen
    * Vor- und Nachnamen

  Hier sollte man sich auch überlegen, welche dieser Eigenschaften man
  validieren sollte, bevor man sie speichert.

2. Im zweiten Schritt soll dann natürlich auch auf der Weboberfläche die
  Beziehung zwischen Nutzer und Statusmitteilungen hergestellt werden. Im
  Einzelnen bedeutet das also, dass wir uns an der Anwendung als Benutzer
  anmelden müssen. Und natürlich können nur angemeldete Nutzer überhaupt erst
  Mitteilungen verfassen. Die Anwendung muss dann immer den aktuell angemeldeten
  Nutzer der eingegebenen Nachricht zuweisen.

## Ressourcen

* [A Guide to Active Record Associations](http://guides.rails.info/association_basics.html "A Guide to Active Record Associations")
* [Rails Sessions](http://guides.rails.info/action_controller_overview.html#session "Action Controller Overview – Sessions")

## Shortcuts

Zunächst brauchen wir erst einmal ein Benutzer-Objekt mit dazugehöriger
Datenbank-Migration und Controller. Dazu verwenden wir einfach wieder den
Rails-Generator, um eine Resource zu erzeugen. Hier können direkt wieder die
Attribute mit ihren Typ-Definitionen angegeben werden.

Dadurch haben wir ein Benutzermodell erzeugt, nun müssen wir (neben möglichen
Validierungen) noch die Assoziationen zwischen Benutzer und Mitteilung
definieren. Dabei ist zu beachten, dass für diese Assoziation wahrscheinlich
ein *Foreign-Key* in der Tabelle für die Mitteilungen definiert werden muss
(**Tipp:** Migration zum Anlegen dieser Spalte).

Im Anschluss sind noch einmal alle Assoziationsmethoden kurz als Code-Beispiele
dargestellt. Die Lösung dieser Aufgabe lässt sich daraus dann recht leicht
ableiten.

1:1-Beziehung (`has_one`) zwischen zwei Objekten: Ein `Picture` hat genau ein
`Thumbnail`.

    !!!ruby_on_rails
    class Picture < ActiveRecord::Base
      has_one :thumbnail
    end

    class Thumbnail < ActiveRecord::Base
      belongs_to :picture
    end

    picture = Picture.first
    picture.thumbnail # => Das assoziierte Thumbnail-Objekt

    thumbnail = Thumbnail.first
    thumbnail.picture # => Das Picture-Objekt zu dem dieses Thumbnail gehört

1:m-Beziehung (`has_many`) zwischen zwei Objekten: Eine `Company` hat viele
`Client`s.

    !!!ruby_on_rails
    class Company < ActiveRecord::Base
      has_many :clients
    end

    class Client < ActiveRecord::Base
      belongs_to :company # Hier muss ein Spalte 'company_id' existieren
    end

    company = Company.first
    company.clients # => Alle Client-Objekte die mit dieser Company assoziiert sind

    client = Client.first
    client.company # => Das Company-Objekte zu dem dieser Client gehört

n:m-Beziehungen (`has_many_and_belongs_to` und `has_many :through`) zwischen
Objekten: Ein `Developer` arbeitet auf vielen `Project`s und ein `Project`
wird von vielen `Developer`n umgesetzt. Diese Art der Beziehung kann auf zwei
Arten umgesetzt werden: Die erste (`has_many_and_belongs_to`) ist dabei die
einfachere und sieht kein dediziertes Objekt vor, welches die Assoziation
abbildet. Die zweite Variante (`has_many :through`) modelliert explizit ein eigenes
Objekt, welches die Assoziation repräsentiert. In beiden Fällen muss aber eine
Datenbank-Tabelle erzeugt werden. Für `has_many :through` muss darüber hinaus
noch eine Klasse definiert werden.

Beispiel für `has_many_and_belongs_to`:

    !!!ruby_on_rails
    class Developer < ActiveRecord::Base
      has_and_belongs_to_many :projects
    end

    class Project < ActiveRecord::Base
      has_and_belongs_to_many :developers
    end

    # Die Datenbank-Tabelle, um beide Objekte miteinander in Relation zu bringen
    # muss per Konvention 'developers_projects' heißen!

    developer = Developer.first
    developer.projects # => Alle Project-Objekte für die der Developer arbeitet

    project = Project.first
    project.developers # => Alle Developer-Objekte, die an diesem Project arbeiten

Beispiel für `has_many :through`:

    !!!ruby_on_rails
    class Developer < ActiveRecord::Base
      has_many :assignments
      has_many :projects, :through => :assignments
    end

    # Hier muss eine vollständiges Model erzeugt werden (rails generate model)
    class Assignment < ActiveRecord::Base
      belongs_to :developer
      belongs_to :project

      # Hier lassen sich weitere Attribute definieren, die für diese Relation von
      # Bedeutung sein könnten, wie zum Beispiel wie viel Zeit ein Developer für
      # ein Projekt zur Verfügung steht.
    end

    class Project < ActiveRecord::Base
      has_many :assignments
      has_many :developers, :through => :assignments
    end

    developer = Developer.first
    developer.projects # => Alle Project-Objekte für die der Developer arbeitet
    developer.assignments # => Alle Assignment-Objekte für diesen Developer

    project = Project.first
    project.developers # => Alle Developer-Objekte, die an diesem Project arbeiten
    project.assignments # => Alle Assignment-Objekte, die mit diesem Project assoziiert sind

**Tipp:** Nachdem die Assoziationen implementiert wurden, empfiehlt es sich
diese zunächst über die Rails-Console (`$> rails console`) auszuprobieren,
bevor man sich an die Umsetzung in den Templates widmet.

### Session-Handling

Um den Benutzer wieder erkennen zu können, muss in seiner Session etwas
abgelegt werden, mit dem man ihn auch wieder finden kann. Hier eignet sich die
ID des Benutzer. Auf die Session lässt dann sowohl in den Templates als auch
in den Controllern über die Methode `session` zugreifen. Das `session`-Objekt
ist dabei als Hash realisiert. Die Speicherung der ID eines Benutzers könnte
dementsprechend wie folgt aussehen:

    !!!ruby_on_rails
    user = User.find_by_username(params[:username])
    if user
      session[:user_id] = user.id
    end

Eine Implementierung dieser Art sollte sich in einem `SessionController`
wieder finden lassen, über den der Login eines Benutzer stattfinden kann. In
diesem Zuge sollte man auch über einen Logout nachdenken.

**Bonus:** Um zu verhindern, dass bestimmte Actions in einem Controller
ausgeführt werden, ohne das entsprechende Vorbedingungen erfüllt sind, gibt es
[Filter](http://guides.rails.info/action_controller_overview.html#filters
"Action Controller Overview – Filter"). Um sicher zu stellen, dass nur dann
eine Mitteilungen geschrieben werden kann, wenn ein Benutzer eingeloggt ist,
definiert man in der Regel eine `before_filter` in der Controller-Ebene.

### Echte Benutzerauthentifizierung

Wir hoffen natürlich, dass man sich auch über die Laufzeit des Kurses hinaus
mit Rails beschäftigen wird. Wer dann gerne einen "echten" Benutzerlogin
realisieren will, also mit verschlüsseltem Passwort in der Datenbank und
Opt-In Email, sollte sich dazu einige Plugins anschauen. Zum einen gibt es da
[`restful_authentication`](http://github.com/technoweenie/restful-authentication
"technoweenie's restful-authentication at master - GitHub") oder auch
[`authlogic`](http://github.com/binarylogic/authlogic "binarylogic's authlogic
at master - GitHub"). Beide lassen sich jeweils gut erweitern und auf die
eigenen Bedürfnisse anpassen. Wir bevorzugen zur Zeit `authlogic`, da es kein
Generator ist, das MVC-Paradigma stärker unterstützt und sich leichter in die
eigene Applikation einfügt. Aber probiert es einfach selbst aus und es gibt
auch noch zahlreiche andere Plugins. Auch selber bauen ist eine Alternative,
wenn es darum geht ein Verständnis für die Thematik zu entwickeln.