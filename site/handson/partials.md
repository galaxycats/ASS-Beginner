# Tag 2, Hands-On 5: Partials

## Ziel

Bestimmte Teile des HTML-Markups so extrahieren, dass sie sich leicht
wiederverwenden lassen. Diese Extraktionen werden dabei als *Partials*
bezeichnet.

## Aufgabe

1. Zunächst soll die Darstellung einer einzelnen Statusmitteilung innerhalb
der Liste aller Mitteilungen in ein Partial extrahiert werden. Diese
Darstellung werden wir später noch an andere Stelle verwenden müssen bzw.
können.

2. Auch das Formular für die Eingabe neuer Statusmitteilungen soll in einem
Partial realisiert werden.

## Ressourcen

* [Layouts and Rendering in Rails – Using Partials](http://guides.rails.info/layouts_and_rendering.html#using-partials "Layouts and Rendering in Rails – Using Partials")

## Shortcuts

Partials werden in Rails immer durch einen Underscore als Prefix im Dateinamen
identifiziert und werden in der gleichen Verzeichnisstruktur abgelegt wie die eigentlichen
Templates zu einem Controller:

    !!!plain_text
    app/
    +-views/
      +-messages/
        +-index.html.erb
        +-_message.html.erb
        +-_form.html.erb
        
Anhand des folgenden Beispiels wollen wir kurz erklären, wie Partials in Templates
integriert werden können:

    !!!html_rails
    <h1>Statusmitteilungen</h1>
    <div>
      <%= render "messages/form" %>
    </div>
    <div id="timeline">
      <%= render @messages %>
    </div>

Hier lässt sich schon sehr gut sehen, dass es unterschiedliche Arten gibt ein
Partial einzubinden. Die erste Variante `<%= render "messages/form" %>` bindet
das Partial `_form.html.erb` aus dem Verzeichnis für die Message-Templates
ein. Rails erkennt hier automatisch, dass es das Partial `_form.html.erb`
nehmen muss. Die zweite, nicht ganz offensichtliche Variante, stellt für jedes
`message`-Objekt in der Collection `@messages` das Partial `_message.html.erb`
dar. Dabei wird das jeweilige `message`-Objekt an das Partial übergeben und
ist über die Variable `message` verfügbar.