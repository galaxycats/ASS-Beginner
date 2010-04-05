# Message und User

u = User.create(:username => "thyphoon", :first_name => "Andi", :last_name => "Bade", :email => "andi@galaxycats.com")
User.first
User.find(1)

message = Message.find(:first)
message = Message.first

# Eine Nachricht hat einen User vom Typ User
message.user
message.user.class

# Ein Benutzer kann auch viele Nachrichten haben
user = message.user
user.messages

# eine neue Nachricht für einen Benutzer anlegen
new_message = Message.new(:content => "Neue Nachricht ueber die console")
user.messages << new_message
user.messages.first
user.messages.second

# eine Message kann nicht ohne User existieren
new_message = Message.new(:content => "Neue Nachricht ueber die console")
new_message.valid?
new_message.errors.full_messages

# Wie lege ich eine Nachricht am besten an
user.messages.build(:content => "Nachricht die direkt ueber die Assoziation User<->Message erzeugt wurde.")
user.messages.create(:content => "Nachricht die direkt ueber die Assoziation User<->Message erzeugt und gespeichert wurde.")

# where Methoden auf den assoziierten Objekten
user.messages.where(["content LIKE :content", {:content => "%Nachricht%"}])
# Sucht nur in den Nachrichten die dem User gehören

# Ich kann auch Daten löschen
user.messages.delete_all # löscht alles per SQL
user.messages.destroy_all # löscht alles, aber instanziiert alle Objekte vorher

# destroy
user.messages.destroy(1)
user.messages.destroy(user.messages.last)
user.messages.first.destroy

# delete !! GEFÄHRLICH !!
user.messages.delete(user.messages.last)
