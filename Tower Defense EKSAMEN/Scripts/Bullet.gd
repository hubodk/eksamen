extends Area2D

#overall er vector der viser hvor en specifik ting befinder sig på x og y aksen.

var move = Vector2.ZERO #her bliver der lavet en ny variabel der bliver kaldt "move" som fører videre til en vector som har både x og y sat til 0 altså ZERO
var speed = 3 #her bliver der lavet en variabel som er hastigheded som er sat til 3
var look_vec = Vector2.ZERO #"look_vec" bliver brugt til at vise hvor tårnet kigget - her bliver der defineret en variabel kaldt "look_vec" som bliver ført videre til en vector hvor både x og y aksen er sat til 0 altså ZERO#
var target # skaber en variabel som hedder "target" uden nogen værdi men bliver blot brugt til at target fjenderne der kommer løbende

func _ready(): #func _ready() bliver brugt når når en node er klar til at blive brugt i en scene.
	if target != null: #her bliver der tjekket om "target" variablen er sat til "null" og hvis target ikke er "null" betyder det at noden har en "target" som den kigger på.
		$Sprite.look_at(target.global_position)#target.global_position er vector hvor fjenden er #Derefter opdatere koden hvilken vej spriten kigger og den skal kigge efter "target" ved at bruge "look_at" og "look_at" bruger en vector som input som viser hvor "target" er, og target er jo fjenden
		look_vec = target.global_position - global_position #look_vec er en 2D vector som kigger på en "target" 
#her bliver der udregnet fra den node vi er på som er "global_position" og "target noden som er "target.global_position" som fører videre at vores vector pejer mod "target" så tårnet faktisk pejer på fjenden.

func _physics_process(delta): #_physics_process(delta) er en indbygget funktion i godot som bliver brugt for at få nogen physics i spillet #delta er tiden i spillet altså frames og hvor langt skudet har flyttet sig
	move = Vector2.ZERO #sætter vector y og x værdien til 0
	
	move = move.move_toward(look_vec, delta) #Her bliver move vektor opdateret til at anvende "move_toward" som tager den anden vector ("look_vec") som bevæger "move" vektroen til mål med den hastighed svarednde til delta
	move = move.normalized() * speed #i denne linje bliver "move" normaliseret hvilket sætter den til 1, hvorefter den ganger move hastigheden med speed variablen fra vores tabel med forskellige speed hastighedder
	global_position += move #Så bliver positionen af objektet opdateret ved at tilføje move vektroen til den globale position hvilket for skudet til at flytte sig
