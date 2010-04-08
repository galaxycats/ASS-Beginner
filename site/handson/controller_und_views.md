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

Zusätzlich soll über die Haupt-URL (`http://localhost:3000/`) die öffentliche
Timeline angezeigt werden (also alle Nachrichten). Dazu muss die `index.html`
aus dem `public`-Verzeichnis der Rails-Anwendung gelöscht und eine
`root`-Route angelegt werden.

## Ressourcen

* [Action Controller Overview](http://guides.rails.info/action_controller_overview.html "Action Controller Overview")
* [Layouts and Rendering in Rails](http://guides.rails.info/layouts_and_rendering.html "Layouts and Rendering in Rails")
* [Rails Form helpers](http://guides.rails.info/form_helpers.html "Rails Form helpers")

## Shortcuts

Die Aufgabe soll natürlich RESTful realisiert werden. Wir brauchen daher auf
jeden Fall drei Actions in unserem Controller. Hier noch einmal beispielhaft
die Implementierung der Action zur Anzeige aller Statusmitteilungen:

    !!!ruby_on_rails
    class MessagesController < ApplicationController
    
      def index
        @messages = Message.all # Sind die Statusmitteilungen hier schon richtig sortiert?
      end
    
    end

Zu dieser Action wird Rails automatisch das Template `index.html.erb` im
Ordner `app/views/messages` verwenden. Im Template muss nicht mehr das HTML
Gerüst definiert werden, dass ist bereits über das Layout geschehen. Wir müssen also 
nur noch alle Statusmitteilungen ausgeben. Dazu kann man sich folgenden Code vorstellen:

    !!!html_rails
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
geschieht hier die Ausgabe aufgrund des Blocks über einen anderen Weg, der an
dieser Stelle nicht weiter betrachtet werden soll. Wenn wir das Ergebnis
unseres Ruby-Codes in das Template integrieren wollen, verwenden wir die
Notation `<%= ruby_code %>`. Wie eben für die Ausgabe des Inhalts (`content`)
des `message`-Objekts.

Zur Eingabe von Daten auf einer Webseite werden bekanntermaßen Formulare
verwendet. Für deren Realisierung zur Eingabe von Daten für ein
`ActiveRecord`-Objekt bietet Rails eine ganze Reihe von Helper-Methoden an. An
folgendem Beispiel seien einige dieser Methoden kurz beschrieben:

    !!!html_rails
    <%= error_messages_for :message %>
    <% form_for :message do |f| %>
      <%= f.text_area :content %>
      <%= f.submit "Post Status" %>
    <% end %>

Durch die Helper-Methode `form_for` erhalten wir ein Formular-Objekt auf das
wir im folgenden über die Variable `f` Zugriff erhalten. Auf diesem Objekt
lassen sich dann die üblichen Formularfelder definieren, wie hier zum Beispiel
eine `text_area` oder ein `submit`-Button. Am Ende erhalten wir ein
HTML-Formular, dass die einzelnen Felder korrekt bezeichnet hat, um ein
`Message`-Objekt damit zu erzeugen. Die Helper-Methode erzeugt ebenfalls die
korrekte URL an die die Formulardaten gesandt werden sollen für uns.

Die Methode `error_messages_for :message` gibt etwaige Fehler aus, die bei der
Validierung des Message-Objekts vor der Speicherung aufgetreten sind.

Der vollständige Controller-Code sieht damit am Ende wie folgt aus:

    !!!ruby_on_rails
    class MessagesController < ApplicationController

      def index
        @messages = Message.latest
      end

      def create
        @message = Message.new(params[:message])
        if @message.save
          redirect_to messages_url
        else
          @messages = Message.latest
          render :index
        end
      end

    end

### Routing

In der Routing-Datei (`config/routes.rb`) muss zu diesem Zeitpunkt nichts weiter getan werden, als eine
`root`-Route anzulegen. Diese beschreibt welche Action mit dazugehörigem Controller beim Aufruf der Haupt-URL (`http://localhost:3000`)
aufgerufen werden soll. Dazu fügt man folgenden Code am Ende der Routing-Definition ein:

    !!!ruby_on_rails
    route :to => "<controller>#<action>"
    
### Layouts

Die einzelnen Templates besitzen keinerlei HTML-Gerüst. Daher kann dort auch
keinerlei Stylesheet oder Javascript hinzugefügt werden. Diese geschieht über
sogenannte *Layouts*. Per Default wird versucht das Layout
`application.html.erb` zu verwenden, sofern es vorhanden ist. Die Layouts
müssen dabei in dem Order `app/views/layouts` liegen. Hier ist ein einfaches
Beispiel für ein Layout:

    !!!html_rails
    <!DOCTYPE html>
    <html lang="de">
    <head>
      <meta charset="utf-8" />
      <title>Twitter-Clone</title>
      <%= stylesheet_link_tag "scaffold", :cache => true %>
    </head>
    <body>
      <div id="container">
        <%= yield # An diser Stelle wird später das Template eingebunden %>
      </div>
    </body>
    </html>
    
In diesem Template wird auch schon eine CSS Datei eingebunden, die man sich
von Rails generieren lassen kann. Dazu muss folgender Befehl auf der Kommandozeile
im Projektordner eingegeben werden:

    rails generate stylesheets

Das dadurch erzeugte Stylesheet findet sich unter
`public/stylesheets/scaffold.css` und kann als Ausgangspunkt für ein eigenes
Styling genommen werden.