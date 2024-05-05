extends Button
export(bool) var sell = true
export(String, "PICK", "Pizza", "Pickle", "Cheese Stick", "Cheese Square", "Waffle", "Shot", "Bone", "Bone Marrow", "Narwhale", "Poncho", "Dave") var object
export(bool) var apply_exponent = true
onready var buy = get_node("buy")
onready var bad = get_node("bad")
onready var place = get_node("grid")
const label: String = "res://assets/objects/label.tscn"
var price: int
var food1: String
var amt1: int
var food2: String
var amt2: int
var data: Dictionary

func _init():
	text = ""

func _ready():
	data = Global.load_data("Food")["Store"][object]

func _process(delta):
	update_all()

func _on_buy_sell_pressed():
	if sell:
		if price > 0:
			Global.score["Tardigrade"] += price
			Global.score[object] = 0
			price = 0
			buy.play()
			return
	else:
		if food1.length() != 0 && Global.score[food1] >= amt1:
			if food2.length() != 0 && Global.score[food2] >= amt2:
				Global.score[food2] -= amt2
				Global.score[food1] -= amt1
				Global.score[object] += 1
				buy.play()
				return
			elif food2.length() == 0:
				Global.score[food1] -= amt1
				Global.score[object] += 1
				buy.play()
				return
	bad.play()

func update_all():
	for child in place.get_children():
		place.remove_child(child)
	
	if sell:
		update_price()
		add_text("...")
	
	add_item(Global.graphics_folder + "items/" + object + ".png")
	
	if !sell:
		add_text("...")
		update_buy1()
		update_buy2()
	
	add_text("... Amt:")
	add_variable()
func update_price():
	if data.has("FoodSell"):
		price = data["FoodSell"] * Global.score[object]
		if apply_exponent:
			price += (pow(data["FoodSell"] * 0.1, 2) * Global.score[object])
		add_text(str(price))
func update_buy1():
	if data.has("FoodItem1"):
		food1 = data["FoodItem1"]
		amt1 = data["FoodAmount1"]
		add_text(str(amt1))
		add_item(Global.graphics_folder + "items/" + food1 + ".png")
func update_buy2():
	if data.has("FoodItem2"):
		food2 = data["FoodItem2"]
		amt2 = data["FoodAmount2"]
		add_text(str(amt2))
		add_item(Global.graphics_folder + "items/" + food2 + ".png")

func add_item(file : String):
	var new = TextureRect.new()
	new.texture = load(file)
	new.mouse_filter = new.MOUSE_FILTER_IGNORE
	place.add_child(new)
	new.size_flags_vertical = new.SIZE_SHRINK_CENTER
	new.size_flags_horizontal = new.SIZE_FILL
func add_text(new_text : String):
	var new = preload(label).instance()
	new.prefix = new_text
	new.variable = false
	place.add_child(new)
func add_variable():
	var new = preload(label).instance()
	new.global_variable = "score"
	new.place_in_data = object
	new.suffix = ""
	new.repeat = true
	place.add_child(new)

