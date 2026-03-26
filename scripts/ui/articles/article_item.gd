extends HBoxContainer

var article_id: int
var parent_screen: Node

@onready var name_label = $Panel/VBoxContainer/name
@onready var category_label = $Panel/VBoxContainer/category

func setup(article: Dictionary, parent: Node):
	article_id = article["id"]
	parent_screen = parent
	
	name_label.text = article["nombre"]
	category_label.text = article["categoria"]


func _on_delete_btn_pressed():
	DataManager.delete_article(article_id)
	parent_screen.refresh_list()
