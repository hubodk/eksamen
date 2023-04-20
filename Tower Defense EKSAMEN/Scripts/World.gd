extends Node2D

var tower = preload("res://Scenes/Tower.tscn") #tower loader tower scenen
var tower1 = preload("res://Scenes/Tower1.tscn") #tower1 loader tower1 scenen
var mob = preload("res://Scenes/Enemy.tscn") #mob/fjende loader fjende scenen.
var instance #en instance fx et dyr, men indenfor dyr kan det være hund, kat eller løve osv.

var building = false #variabel der fortæller at man ikke kan bygge i det her område

var money = 25 #variabel der fortæller hvor mange penge man har tilbage, man starter på 25 penge.
var wave = 0 #variabel der fortæller hvad runde man er på
var mobs_left = 0 #variabel der fortæller hvor mange fjender der er tilbage
var wave_mobs = [1,1,5,10,100,0] #tabel der viser antal fjender i hver runde, ny runde efter hver komma.
var wave_speed = [1.2,1,1,1,0.1,100] #tabel der viser hastiheden af fjenderne

#funktion er et stykke kode der kan bruges om og om igen istedet skrive det igen.

func _ready():
	$WaveTimer.start() #funktionen er klar, og starter wave timeren

func _process(delta): #_process(delta) er noget der sker hver eneste frame i spillet da spillet kører 60 frames per sekund.
	$GUI/CashLabel.text = "Cash: " + str(money) #hver eneste frame bliver penge labelen opdateret med det antal penge man har.
# GUI = graphical user interface

func add_money(amount): #add_money er en funktion der styrer en paramter som er "amount" som er mængden af penge som bliver tilføjet til den første variabel som er money i starten af koden.
	money += amount #penge bliver plusset med ammount ergo = alle penge samlet
	
func tower_built(): #funktionen hedder byg tårn altså tower_built at tårnet er blevet bygget
	building = false #når funktionen bliver kaldt på så siger den at bygning bliver "false" så den ikke dur mere og den reducere penge variablen med 25, altså at man mister 25 for at bygge bygningen.
	money -= 25



func _on_WaveTimer_timeout(): #funktionen hedder _on_wavetimer_timeout hvilket vil sige  det er en "callback" funktion som bliver kaldt på når en timer node der hedder "wavetimer" bliver timed out altså færdig med at tælle. Det bruger for at implementere et runde system i spillet.
	mobs_left = wave_mobs[wave] #sætter variablen "mobs_left" til det nummer af fjender der spawner i denne runde, og den tager data fra tabellen vi har i starten af koden.
	$MobTimer.wait_time = wave_speed[wave] #Her bliver vente tiden af en tid node som vi kalder "MobTimer" sat til hastigheden af den wave vi er nået til ud fra tabellen der er i starten af koden.
	$MobTimer.start() #Starter timeren af noden "MobTimer" det vil gøre at timeren skyder et signal ud efter den tid der er gået som gør at der kommer flere fjender.


func _on_MobTimer_timeout(): #funktionen hedder _on_mobtimer_timeout som er en funktion der bliver kaldt på når timer noden for "mobtimer" kalder. Den bliver brugt til at spawn fjender hver antal interval
	instance = mob.instance() #laver en ny "instance" som bare er en mob altså en fjende, en instance er et træ at noder fx dyr indenfor dyr har vi (katte, hunde, løver osv.) 
	$Path2D.add_child(instance) #den tilføjer denne nye instans af en fjende som et barn af Path2D node som betyder at barnet altid følger efter Path2D så den følger altså på path.
	mobs_left -= 1 #Den tæller ned hvor mange fjender der skal spawnes i given runde som i tæller ned indtil alle er spawnet så den ved hvor mange den skal spawne
	if mobs_left <= 0: #Tjekker om der er flere fjender at spawne ved at sammenligne "mobs_left" til 0, og hvis der er 0 så spawner der ikke flere.
		$MobTimer.stop() #Hvis der ikke er flere fjender at spawne stopper "mobtimer" noden som gør at der ikke kommer flere fjender og så sætter antallet af wave op så der begynder spawne en ny wave af fjender.
		wave +=1 
		if wave < len(wave_mobs): #len tager bare tallet af hvad wave af fjender man er kommet til
			$WaveTimer.start() #Hvis der er flere runder at spawne starter "wavetimer" noden igen som sender den wave vi er nået til ud så den starter.
		else:
			get_tree().change_scene("res://Scenes/Win.tscn") #Hvis der ikke er flere waves at spawn så kommer skærmen "you win" frem hvilket betyder man har vundet.

func _on_TextureButton_pressed(): #funktionen hedder _on_texturebutton_pressed
	if building == false and money >= 25: #Her bliver det tjekket for om der allerede ved at blive bygget et tårn, det betyder hvis du igang med at bygge et tårn kan du ikke bygge et mere på samme tid. og hvis du har under 25 kan du ikke bygge et tårn.
		instance = tower.instance() #laver instance som holder tårn instance, altså et træ af ting tårnet gør.
		add_child(instance) #der bliver tilføjet et barn til instancen med tårnet
		building = true #så når man trykker på knappen kan man godt bygge tårnet fordi den er "true"

func _on_TextureButton1_pressed(): #her bliver der lavet en ny funktion som så er præcis det samme som længere oppe bare med en ny knap til et nyt slags tårn.
	if building == false and money >= 50: #tårnet her koster 50, og hvis man ikke har mere end 50 kan man ikke bygge det
		instance = tower1.instance() 
		add_child(instance) #der bliver tilføjet en child note til instance af tårnet
		building = true #bygge variablen bliver sat til "true" så nu er det muligt at bygge tårnet efter at trykke på knappen.

