# Tag 2, Hands-On 5: Relationen zwischen Modellen

## Ziel des Hands-on

Relationen zwischen Modellen abbilden können

## Aufgabe

1. Neben dem Modell <code>Article</code> ist das Modell <code>Comment</code> für die Applikation wichtig, da hierüber die Kommentare zu einem Artikel abgebildet werden. Die beiden Modelle gehen eine Relation ein, die in Rails mittels <code>ActiveRecord::Associations</code> abgebildet werden sollen. Dabei sollen gegebenenfalls die Datenbank überarbeitet werden, um Relationen abbilden zu können.
2. Relationen sollten validiert werden, um Relationsvorschriften gerecht zu werden. Ein Kommentar zum Beispiel nicht alleine existieren und muss immer zu einem Artikel gehören.

## Ressourcen

* http://api.rubyonrails.com/classes/ActiveRecord/Associations/ClassMethods.html
* http://api.rubyonrails.com/classes/ActiveRecord/Validations.html

## Shortcuts

Diese Aufgabe kann ganz ohne starten des Webservers gelöst werden und sollte auch so gelöst werden. Stattdessen soll rein über <code>script/console</code> gearbeitet werden. Hierdurch soll ein besseres Verständnis der internen Abläufe entstehen.

* <code>has_one</code> 
  * 1:1 Beziehung auf Objektebene 
  * Erweitert <code>Picture</code> um die Methode <code>thumbnail</code> 
* <code>belongs_to</code> 
  * Beschreibt die Tabelle, die den Foreign-Key in einer 1:n / 1:1 Beziehung hält 
  * Erweitert <code>Address</code> um die Methode <code>person</code> 
* <code>has_many</code> 
  * 1:n Beziehung auf Objektebene 
  * Erweitert <code>Person</code> um die Methode <code>addresses</code> 
* <code>has_many_and_belongs_to</code> 
  * n:m Beziehung auf Objektebene 
  * Zwischentabelle, die lediglich in der Datenbank abgebildet wird (keine <code>ActiveRecord::Base</code> Klasse). 
* <code>has_many :through</code> 
  * n:m Beziehung 
  * Zwischentabelle wird durch <code>ActiveRecord::Base</code> Klasse definiert 
* Foreign-Keys müssen manuell angelegt werden 
  * Konvention Klassenname (Singular) + <code>_id</code> 
* Neben den Validierungen, die bereits im Handout 4 vorgestellt wurden, ist bei Assoziationen noch folgendes zu beachten:
  * Der Standard Validator <code>validates_associated :attribute</code> speichert das Objekt selbst nur dann, wenn auch alle seine assoziierten Objekte valide sind.
  * Entgegen der Rails Dokumentation sollte bei einer Assoziation sowohl geprüft werden, dass das assoziierte Objekt vorhanden, als auch, dass das assoziierte Objekt tatsächlich in der Datenbank vorhanden ist. Der Validator <code>validates_presence_of</code> muss demnach sowohl auf das Objekt, als auch auf seine ID angewandt werden. Beispiel:
  
<pre><code>
class Thumbnail &lt; ActiveRecord::Base
  belongs_to :picture
  
  validates_presence_of :picture
  validates_presence_of :picture_id
end</code></pre>
