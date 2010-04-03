# Tag 2, Hands-On 7: Partials

## Ziel des Hands-on

Liste der Kommentare als Partials implementieren.

## Aufgabe

1. Die Liste der Kommentare eines Artikels soll als Partial eingebunden werden. Dabei ist es wichtig das "Partial"-Konzept zu verstehen. Um Wiederholungen bei der Ausgabe der Kommentare zu vermeiden, sollte das Partial mittels einer Collection eingebunden werden.
2. Gemäß dem DRY-Prinzip sind Partials unerlässlich. Es sollen weitere Möglichkeitewn zur Erstellung von Partials gefunden und implemenitert werden.

## Ressourcen

* http://api.rubyonrails.com/classes/ActionView/Partials.html

## Shortcuts

### Partial mit Übergabe einer lokalen Variable

<code><%= render :partial => "comment" %></code><br />
(Partial _comment.rhtml, lokale Variable person)

<code><%= render :partial => "account", :locals => { :account => @customer.account } %></code><br />
(Partial _account.rhtml, lokale Variable account)  

Partial mit Übergabe einer Collection  (Iteration z.B. über ein Array, Ausgabe für jedes Objekt im Array)

<code><%= render :partial => "comment", :collection => @articles.comments %></code><br />
(Partial _comment.rhtml, lokale Variable comment)  

Partials mit anderen Controllern teilen

<code><%= render :partial => "user/login", :locals => { :user => @user.id } %></code><br />
(Partial /user/_login.rhtml, lokale Variable user)