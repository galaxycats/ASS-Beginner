# Tag 3, Hands-On 7: Mentions und Follower

## Ziel

Auch komplexere Assoziationen zwischen Objekten mit Hilfe von Rails
modellieren und abbilden zu können.

## Aufgabe

Mittlerweile können unterschiedliche Benutzer Statusmitteilungen über unsere
App veröffentlichen, allerdings fehlt uns noch der wichtigste Punkt: Die
Vernetzung der einzelnen Nutzer. Die Vernetzung geschieht über zwei Wege, zum
einen durch das "verfolgen" anderer Nutzer und zum anderen, dass ich als
Nutzer andere Nutzer in meinen Mitteilungen explizit erwähnen kann.

1. Zunächst wollen wir uns daher dem "verfolgen" anderer Nutzer widmen. Es
soll möglich sein, dass jeder Nutzer von jedem anderen Nutzer dessen
Mitteilungen verfolgen kann. Wenn also Alice eine Mitteilung schreibt, und Bob
Alice folgt, dann soll Bob in der Liste seiner Nachrichten auch die
Nachrichten von Alice sehen. Um jemandem folgen zu können soll ein
entsprechender Link auf der Profilseite eine Nutzers angezeigt werden. Es
sollte auch möglich sein, dass man aufhört jemandem zu folgen.

2. Sobald man einander folgen kann, sollen sich die Nutzer gegenseitig in
ihren Mitteilungen erwähnen können. Dies wird einfach darüber realisiert, dass
man in einer Mitteilung einen oder mehrere Benutzername mit einem @-Zeichen
als Prefix schreibt. Wenn also Alice Bob in ihrer Mitteilung erwähnen möchte,
dann muss sie in ihrer Nachricht `@bob` schreiben. Wenn ich von einem anderen
Nutzer in einer Mitteilung erwähnt wurde, so soll diese Mitteilung natürlich
auch in meiner Mitteilungsliste auftauchen. Sie soll dabei entsprechend
gekennzeichnet werden.

3. Als kleine Bonusaufgabe sollen die erwähnten Benutzernamen in einer
Nachricht mit einem Link versehen werden, der auf die Profilseite des
erwähnten Benutzers führt. Hierbei ist zu beachten, dass es passieren kann,
dass man sich verschrieben hat und es den Benutzer nicht gibt. In diesem Fall
sollte natürlich eine passende Meldung ausgegeben werden.

## Ressourcen

* [A Guide to Active Record Associations](http://guides.rails.info/association_basics.html "A Guide to Active Record Associations")
* [Active Record Callbacks](http://guides.rails.info/activerecord_validations_callbacks.html#callbacks-overview "Active Record Validations and Callbacks")

## Shortcuts

Für die Implementierung der Mention-Funktionalität ist es notwendig, dass
**nach** dem Speichern einer Mitteilung noch etwas ausgeführt wird. Hierfür
stellt Active Record sogenannte *Callback*-Funktionen bereit. Diese werden
aufgerufen, nachdem eine bestimmte Methode ausgeführt wurde, wie z.B. die
`save`-Methode eines Active Record Objekts. Hier ein kleines Beispiel, um das
zu verdeutlichen:

    !!!ruby_on_rails
    class User < ActiveRecord::Base
      after_save :send_welcome_email

      private

        # We don't want to make this publictly callable
        def send_welcome_email
          Mailer.deliver_welcome_mail(:user => self)
        end
    end

    user = User.new
    user.save # => Will save the record AND will send the email