extends Control

var database : SQLite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	database = SQLite.new()
	database.path = "res://data.db"
	database.foreign_keys = true
	database.open_db()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# create table for players
func _on_create_player_button_down() -> void:
	var player = {
		"playerId":{"data_type":"int", "primary_key":true, "not_null":true,"auto_increment":true},
		"name":{"data_type":"text"},
		"money":{"data_type":"int"}
	}
	database.create_table("player",player)
	pass # Replace with function body.

# create table for etablissements
# insert datas into etablissements
# create table for decks which contains cards of etablissements
# insert cards of etablissements into deck
func _on_create_deck_button_down() -> void:
	var etablissement = {
		"etablissementId":{"data_type":"int", "primary_key":true, "not_null":true,"auto_increment":true},
		"number":{"data_type":"text"},
		"name":{"data_type":"text"},
		"type":{"data_type":"text"},
		"effect":{"data_type":"text"},
		"price":{"data_type":"int"},
		"color":{"data_type":"text"}
	}
	database.create_table("etablissement",etablissement)
	var datas = [{
		"number": "1",
		"name":"Champs de blé",
		"type":"champ",
		"effect":"Pendant le tour de n’importe quel joueur\n Recevez 1 pièce de la banque.",
		"price":1,
		"color":"blue"
	},
	{
		"number": "2",
		"name":"Ferme",
		"type":"ferme",
		"effect":"Pendant le tour de n’importe quel joueur\n Recevez 2 pièces de la banque.",
		"price":2,
		"color":"blue"
	},
	{
		"number": "2-3",
		"name":"Boulangerie",
		"type":"marche",
		"effect":"Pendant votre tour uniquement\n Recevez 1 pièce de la banque.",
		"price":1,
		"color":"green"
	},
	{
		"number": "3",
		"name":"Café",
		"type":"café",
		"effect":"Recevez 1 pièce du joueur qui a lancé les dès.",
		"price":2,
		"color":"red"
	},
	{
		"number": "4",
		"name":"Supérelle",
		"type":"marché",
		"effect":"Pendant votre tour uniquement\n Recevez 3 pièces de la banque.",
		"price":2,
		"color":"green"
	},
	{
		"number": "5",
		"name":"Forêt",
		"type":"location",
		"effect":"Pendant le tour de n’importe quel joueur\n Recevez 1 pièce de la banque.",
		"price":3,
		"color":"blue"
	},
	{
		"number": "6",
		"name":"Stade",
		"type":"stade",
		"effect":"Pendant votre tour uniquement\n Recevez 2 pièces de la part de chaque autre joueur.",
		"price":6,
		"color": "purple"
	},
	{
		"number": "6",
		"name":"Centre d'affaires",
		"type":"stade",
		"effect":"Pendant votre tour uniquement \n Vous pouvez échanger avec le joueur de votre choix un établissement qui ne soit pas de type.",
		"price":8,
		"color": "purple"
	},
	{
		"number": "6",
		"name":"Chaîne de télévision",
		"type":"stade",
		"effect":"Pendant votre tour uniquement\n Recevez 5 pièces du joueur de votre choix.",
		"price":7,
		"color": "purple"
	},
	{
		"number": "7",
		"name":"Fromagerie",
		"type":"fabrique",
		"effect":"Pendant votre tour uniquement\n Recevez 3 pièces de la banque pour chaque établissement de type ferme que vous possédez.",
		"price":5,
		"color": "green"
	},
	{
		"number": "8",
		"name":"Fabrique de meubles",
		"type":"fabrique",
		"effect":"Pendant votre tour uniquement\n Recevez 3 pièces de la banque pour chaque établissement de type location que vous possédez.",
		"price":3,
		"color": "green"
	},
	{
		"number": "9",
		"name":"Mine",
		"type":"location",
		"effect":"Pendant le tour de n’importe quel joueur\n Recevez 5 pièces de la banque.",
		"price":6,
		"color": "blue"
	},
	{
		"number": "9-10",
		"name":"Restaurant",
		"type":"café",
		"effect":"Recevez 2 pièces du joueur qui a lancé les dès.",
		"price":3,
		"color": "red"
	},
	{
		"number": "10",
		"name":"Verger",
		"type":"ferme",
		"effect":"Pendant le tour de n’importe quel joueur\n Recevez 3 pièces de la banque.",
		"price":3,
		"color": "blue"
	},
	{
		"number": "11-12",
		"name":"Marché de fruits et légumes",
		"type":"fruit",
		"effect":"Pendant votre tour uniquement\n Recevez 2 pièces de la banque pour chaque établissement de type champ que vous possédez.",
		"price":2,
		"color": "green"
	}
	]
	for i in datas.size():
		database.insert_row("etablissement",datas[i])
	var deck = {
		"etablissementId" : {"data_type":"int","foreign_key":"etablissement.etablissementId"},
		"numberOfCards": {"data_type":"int"}
	}
	database.create_table("deckEtablissement",deck)
	
	# default base in website http://jeuxstrategieter.free.fr/Minivilles_complet.php
	for i in datas.size() :
		if(datas[i].color == "purple"):
			var data = {"etablissementId" : i+1,"numberOfCards": 4}
			database.insert_row("deckEtablissement",data)
		else:
			var data = {"etablissementId" : i+1,"numberOfCards": 6}
			database.insert_row("deckEtablissement",data)
			
	pass # Replace with function body.


func _on_create_monument_button_down() -> void:
	var monument = {
		"monumentId":{"data_type":"int", "primary_key":true, "not_null":true,"auto_increment":true},
		"name":{"data_type":"text"},
		"type":{"data_type":"text"},
		"effect":{"data_type":"text"},
		"price":{"data_type":"int"},
	}
	database.create_table("monument",monument)
	var datas = [
		{
		"name": "Parc d’attractions",
		"type": "tour",
		"effect": "Si votre jet de dés est un double, rejouez un tour après celui-ci",
		"price": 16
		},
		{
		"name": "Tour radio",
		"type": "tour",
		"effect": "Une fois par jour, vous pouvez choisir de relancer vos dès",
		"price": 22
		},
		{
		"name": "Gare ",
		"type": "tour",
		"effect": "Vous pouvez lancer deux dès",
		"price": 4
		},
		{
		"name": "Centre commercial",
		"type": "tour",
		"effect": "Vos établissements de type ferme et marche rapportent une pièce de plus",
		"price": 16
		}
	]
	for i in datas.size():
		database.insert_row("monument",datas[i])
	var deck = {
		"monumentId" : {"data_type":"int","foreign_key":"monument.monumentId"},
		"numberOfCards": {"data_type":"int"}
	}
	database.create_table("deckMonument",deck)
	for i in datas.size():
		var data = {"monumentId" : i+1,"numberOfCards": 4}
		database.insert_row("deckMonument",data)
	pass # Replace with function body.


func _on_create_bank_button_down() -> void:
	var coin = {
		"coinid":{"data_type":"int","primary_key":true,"not_null":true,"auto_increment":true},
		"type":{"data_type":"text"}
	}
	database.create_table("coin",coin)
	var datas = [{"type": "1"},{"type":"5"},{"type":"10"}]
	for i in datas.size():
		database.insert_row("coin",datas[i])
	var bank = {
		"coinid" : {"data_type":"int","foreign_key":"coin.coinid"},
		"numberOfCoins": {"data_type":"int","auto_increment":true}
	}
	database.create_table("bank",bank)
	var data1 = {"coinid":1, "numberOfCoins": 36}
	var data5 = {"coinid":2,"numberOfCoins": 9}
	var data10 = {"coinid":3,"numberOfCoins": 9}
	database.insert_row("bank",data1)
	database.insert_row("bank",data5)
	database.insert_row("bank",data10)
	pass # Replace with function body.


func _on_divide_button_down() -> void:
	var players = [
		{"name": "Tom", "money": 3},
		{"name": "Bob", "money": 3},
		{"name": "Hank", "money": 3},
		{"name": "Alice", "money": 3}
	]
	for i in players.size():
		database.insert_row("player",players[i])
	var playerCoin = {
		"playerId": {"data_type":"int","foreign_key":"player.playerId"},
		"coinid" : {"data_type":"int"}
	}
	var playerEtablissement = {
		"playerId": {"data_type":"int","foreign_key":"player.playerId"},
		"etablissementId" : {"data_type":"int"}
	}
	var playerMonument = {
		"playerId": {"data_type":"int","foreign_key":"player.playerId"},
		"monumentId" : {"data_type":"int"}
	}
	database.create_table("playerCoin",playerCoin)
	database.create_table("playerEtablissement",playerEtablissement)
	database.create_table("playerMonument",playerMonument)
	for i in range(4):
		var dataCoin = {"playerId": i+1, "coinId": 1}
		var dataEtablissement1 = {"playerId": i+1, "etablissementId": 1}
		var dataEtablissement2 = {"playerId": i+1, "etablissementId": 3}
		var dataMonument1 = {"playerId": i+1, "monumentId": 1}
		var dataMonument2 = {"playerId": i+1, "monumentId": 2}
		var dataMonument3 = {"playerId": i+1, "monumentId": 3}
		var dataMonument4 = {"playerId": i+1, "monumentId": 4}
		database.insert_row("playerCoin",dataCoin)
		database.insert_row("playerCoin",dataCoin)
		database.insert_row("playerCoin",dataCoin)
		database.insert_row("playerEtablissement",dataEtablissement1)
		database.insert_row("playerEtablissement",dataEtablissement2)
		database.insert_row("playerMonument",dataMonument1)
		database.insert_row("playerMonument",dataMonument2)
		database.insert_row("playerMonument",dataMonument3)
		database.insert_row("playerMonument",dataMonument4)
	pass # Replace with function body.


func _on_show_hands_button_down() -> void:
	database.query("select * from player, playerCoin,coin
where player.playerId = playerCoin.playerId and playerCoin.coinid = coin.coinid
GROUP BY player.playerId")
	for i in database.query_result:
		$Hands.text = "The number of coins owned by player "+i.name+" is : "+str(i.money) 
	pass # Replace with function body.
