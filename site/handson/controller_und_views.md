# Tag 2, Hands-On 4: Controller und Views

## Ziel

Realisierung einer Weboberfläche zur Interaktion zwischen Nutzer und Server.

## Aufgabe

Bisher konnten wir nur Statusmitteilungen über die Rails-Console erzeugen. Da
wir eine Web-Anwendung bauen, wollen wir das natürlich über einen Browser
realisieren. Sobald wir eine Statusmitteilung eingegeben haben, soll diese
natürlich auch in einer Liste mit allen anderen Mitteilungen angezeigt werden.
Die Liste soll dabei so sortiert sein, dass jeweils die neueste Mitteilungen
ganz oben in der Liste steht.

Zusammengefasst soll am Ende dieses Hands-On folgendes umgesetzt sein:

  * Eingabeformular für neue Statusmitteilung (*Fehlerbehandlung nicht vergessen*)
  * Sortierte Liste aller Statusmitteilungen

## Ressourcen

* [Action Controller Overview](http://guides.rails.info/action_controller_overview.html "Action Controller Overview")
* [Layouts and Rendering in Rails](http://guides.rails.info/layouts_and_rendering.html "Layouts and Rendering in Rails")

## Shortcuts

Die Aufgabe soll natürlich RESTful realisiert werden. Wir brauchen daher auf
jeden Fall drei Actions in unserem Controller. Hier noch einmal beispielhaft
die Implementierung der Action zu Anzeige aller Statusmitteilungen:

    class MessagesController < ApplicationController
    
      def index
        @messages = Messages.all # Sind die Statusmitteilungen hier schon richtig sortiert?
      end
    
    end

Zu dieser Action wird Rails automatisch das Template `index.html.erb` im
Ordner `app/views/messages` verwenden. Im Template muss nicht mehr das HTML
Gerüst definiert werden, dass ist bereits über das Layout geschehen. Wir müssen also 
nur noch alle Statusmitteilungen ausgeben. Dazu kann man sich folgenden Code vorstellen:

    <% @messages.each do |message| %>
      <% div_for message do %>
        <p><%= message.content %></p>
      <% end %>
    <% end %>


In diesem Beispiel iterieren wir über alle Statusmitteilungen, die sich in der
Variablen `@messages` befinden. Jede einzelne stellen wir dabei in einem
dedizierten `DIV`-Block dar, den wir in diesem Fall mit dem Rails-Helper
`div_for <object>` erzeugen. Wichtig ist noch, die beiden unterschiedlichen
Methoden zur Einbindung von Ruby-Code in unsere Templates zu erwähnen: Die
Notation `<% ruby_code %>` evaluiert den enthaltenden Ruby-Code und gibt das
Ergebnis der Evaluierung nicht direkt wieder aus. Hier kann man jetzt
einwerfen, dass der Helper `div_for <object>` ja nun etwas ausgeben muss,
nämlich das entsprechenden HTML-Markup. Das ist absolut korrekt, jedoch
geschieht hier die Ausgabe über einen anderen Weg, der an dieser Stelle nicht
weiter betrachtet werden soll. Wenn wir das Ergebnis unseres Ruby-Codes in das
Template integrieren wollen, verwenden wir die Notation `<%= ruby_code %>`.
Wie eben für die Ausgabe des Inhalts (`content`) des `message`-Objekts.