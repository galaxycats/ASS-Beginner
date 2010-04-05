# Tag 3, Hands-On 8: Testing

## Ziel

Die Grundlagen von automatisierten Tests verstanden haben und grundlegend anwenden können.

## Aufgabe

Bis hierher haben wir unsere Anwendung allein durch Ausprobieren in der
Console oder im Browser "getestet". Das ist jedoch keine wirkliche Alternative
zu automatisierten Tests. Dabei werden Test-Abläufe programmiert, die sich
immer und immer wieder auf die gleiche Art und Weise ausführen lassen. In
diesem Rahmen ist es sicher nicht möglich die gesamte bisherige Anwendung mit
solchen Tests abzudecken, aber zumindest wollen wir einmal eine kleine
Teilfunktionalität mit einem echten Test abdecken:

1. Es sollen eine Reihe Tests geschrieben werden, die die
Follower-Funktionalität überprüfen. Dazu gehört, ob ein Nutzer einem anderen
folgen kann und dann seine Mitteilungen erhält und das er die Mitteilungen
nicht mehr erhält, sobald er aufhört jemandem zu folgen.

### Eine kleine Anmerkung

Die Methodik der testgetriebenen Entwicklung (TDD) entstammt der agilen
Softwareentwicklung und dort Vorgehensmodellen wie Extreme Programming (XP).
In der agilen Softwareentwicklung wird oft auf eine formale Spezifikation des
Systems verzichtet, um schnell auf Änderungen reagieren zu können. Dies
bedeutet jedoch nicht, dass überhaupt keine Spezifikation existiert! Die
automatischen Tests bilden hier die Spezifikation. Daher ist es auch notwendig
die Tests vor der eigentlichen Entwicklung zu schreiben. Sie definieren, wie
eine Spezifikation, den Funktionsumfang der zu implementierenden Teile des
Systems. Daher kommt die Aussage, dass Code der nicht getestet ist, auch nicht
existiert.

## Ressourcen

* [A Guide to Testing Rails Applications](http://guides.rails.info/testing.html "A Guide to Testing Rails Applications")

## Shortcuts

### Testarten

* **Unit-Tests:** Testen Funktionalitäten auf Modell-Ebene. Hier wird immer
  nur eine Modellklasse selbst getestet. Dazu zählt aber auch ob Relationen
  zwischen Modellen wie erwartet funktionieren.

* **Functional-Tests:** Testen ob die Controllerebene wie erwartet
  funktioniert. Ob Parameter richtig verarbeitet und die richtigen Objekte
  instanziiert werden, sind Fragen die hier beantwortet werden müssen. Ein
  Viewtesting ist hier nur sehr rudimentär möglich. In einem Functional-Test
  wird immer nur ein Controller getestet.

* **Integration-Tests:** Testen Abläufe innerhalb der Applikation. Hier werden
  verschiedene Controller im Zusammenspiel getestet. Es lässt sich simulieren
  wie sich ein Benutzer in der Applikation bewegt. Aber auch hier ist
  View-Testing nur rudimentär möglich.

### Testcases

* Die Klassen der Testcases befinden sich im Ordner `test` und dort in den
  entsprechenden Unterordnern.

* Die Datei `test_helper.rb` wird von allen Tests geladen. Hier werden
  allgemeine Einstellungen vorgenommen (wie alle Fixtures zu laden und wie
  Fixtures geladen werden) und das Environment auf `test` gesetzt.

* Die Tests vererben von `ActiveSupport::TestCase` (Unittests) oder
  `ActionController::TestCase`(Functionaltests, vererbt selbst aber auch von
  `ActiveSupport::TestCase`). Dadurch sind zwei Methoden verfügbar,
  die überschrieben werden können: `setup` und `teardown`. Diese Methoden
  beinhalten Anweisungen, die vor bzw. nach jedem Test (also jeder
  Testmethode) auszuführen sind.

* Testmethoden werden mit `test "<test_name>" do; # your test code; end`,
  ansonsten werden sie nicht beim Testlauf ausgeführt.

### Assertions

Im folgenden eine Auswahl von relevanten Assertions (Überprüfungen) die zur
Verfügung stehen:

    assert_equal # Überprüft ob zwei Objekte gleich sind
    assert_not_equal # Negierung von 'assert_equal'
    assert_instance_of # Überprüft ob ein Objekt eine Instanz einer bestimmten Klasse ist
    assert_kind_of # Überprüft ob ein Objekt eine Instanz einer Klasse aus einem Klassen-/Modulbaum ist
    assert_match # Überprüft ob ein String gegen einen regulären Ausdruck erfolgreich geprüft werden kann
    assert_no_match # Negierung von 'assert_match'
    assert_nil # Überprüft ob ein Objekt 'nil' ist
    assert_not_nil # Negierung von 'assert_nil'
    assert_raise # Überprüft ob eine Exception innerhalb des angegeben Code-Blocks geworfen wird
    assert_nothing_raised # Negierung von 'assert_raise'
    assert_respond_to # Überprüft ob ein Objekt eine bestimmte Methode besitzt
    assert_same # Überprüft ob zwei Objekte die gleiche Instanz sind
    assert_not_same # Negierung von 'assert_same'

Rails definiert zusätzlich noch eine Reihe weiterer Assertions, die sich,
zusammen mit der hier beschriebenen Auswahl vollständig
[hier](http://guides.rails.info/testing.html#assertions-available "Available
Assertions") und
[hier](http://guides.rails.info/testing.html#rails-specific-assertions "Rails
specific Assertions") finden lassen.

### Fixtures

* In den Fixturesdateien zu jeder Modellklasse sind die Testdaten in YAML
  Notation spezifiziert. Sie entsprechen einer Art Objektserialisierung und
  daher können die selben Methodennamen verwendet werden, wie beim Erzeugen
  eines Objekts im Programm. Zu beachten ist, dass die Einrückungen in einer
  YAML Datei Leerzeichen sein müssen und keine Tabs (TextMate verwendet immer
  *SoftTabs*, setzt also Leerzeichen wenn man die Tabulatortaste drückt).

* Innerhalb der Tests kann auf die Testdaten über eine Methode die wie die
  Fixturedatei heisst zugegriffen werden, mit dem Namen des Datensatzes als
  Parameter (Bsp.: `articles(:article_for_test)`)

Beispiel:

    # Dieser Datensatz muss in der test/fixtures/articles.yml Datei stehen
    # Auch gelten ganz normale Kommentare
    article_for_test: # Name des Datensatzes
      title: Article for Pagination test
      author: dirk # Referenz auf einen Datensatz in der authors.yml Datei
      content: Lorem ipsum dolor sit amet, consectetur 
      created_at: <%= 5.days.ago.to_formatted_s(:db) %> # Fixtures durchlaufen auch den ERB Parser!

**Anmerkung:** Der Einsatz von Fixtures sollte unserer Meinung nach nur
punktuell erfolgen. Da hier tatsächlich auf der Datenbank gearbeitet wird,
wird die Ausführung der Tests mit steigender Komplexität und vielen Fixtures
signifikant verlangsamt. Als Alternative zu Fixtures lässt sich *Mocking*
einsetzen, zusammen mit dem Mock-Framework [mocha](http://mocha.rubyforge.org/
"Mocha 0.9.8") für Ruby. Mocking kann aber nicht mehr Teil dieses Kurses sein,
sondern wird im Advanced-Kurs behandelt. Es soll aber hier als Motivation
erwähnt sein, sich mit der Thematik näher zu beschäftigen.

### Ausführen der Tests

* `rake test:units` - Führt alle Unit Tests aus
* `rake test:functionals` - Führt alle Functional Tests aus
* `rake test:integration` - Führt alle Functional Tests aus
* `rake test` - Führt alle Tests aus

Beispiel:
    
    class ArticleTest < ActiveSupport::TestCase
      test "should have a valid title" do
        article = Article.new(:title => '', :author => users(:jessie))
        assert !article.valid?
        assert article.errors.invalid?(:title)
        article.title = "Test Title"
        assert article.save
      end
    end