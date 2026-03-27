extends HBoxContainer

var article: Dictionary
var parent_screen: Node

@onready var name_label = $Panel/VBoxContainer/name
@onready var category_label = $Panel/VBoxContainer/category

func setup(data: Dictionary, parent: Node):
	article = data
	parent_screen = parent

	name_label.text = article["nombre"]
	category_label.text = article["categoria"]


func _on_add_btn_pressed():
	parent_screen.add_to_list(article)
