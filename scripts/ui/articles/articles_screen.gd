extends Control

signal go_to_list_generator

const ArticleItem = preload("res://scenes/articles/article_item.tscn")

@onready var name_input = $VBoxContainer/name_input
@onready var list_container = $VBoxContainer/VScrollContainer/list_container
@onready var category_select = $VBoxContainer/category_select

func _ready():
	category_select.add_item("Carnes")
	category_select.add_item("Carnes frias")
	category_select.add_item("Congelados")
	category_select.add_item("Verduras")
	category_select.add_item("Desechables")
	category_select.add_item("Tortillas")
	category_select.add_item("Otros")

	
	refresh_list()


func _on_add_btn_pressed():
	var name = name_input.text.strip_edges()
	var category = category_select.get_item_text(category_select.selected)

	if name.is_empty():
		print("Nombre vacío")
		return

	DataManager.add_article(name, category)

	name_input.text = ""

	refresh_list()

	name_input.grab_focus()  # 👈 UX fluido


func refresh_list():
	for child in list_container.get_children():
		child.queue_free()

	var articles = DataManager.get_articles()

	for article in articles:
		var item = ArticleItem.instantiate()
		list_container.add_child(item)   # ✅ PRIMERO agregar
		item.setup(article, self)        # ✅ DESPUÉS setup

func _on_to_list_generator_pressed() -> void:
	emit_signal("go_to_list_generator")


func _on_name_input_text_submitted(new_text: String) -> void:
	_on_add_btn_pressed()
