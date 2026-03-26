extends Node

const FILE_PATH := "user://articles.json"

var articles: Array = []


# =========================
# INIT
# =========================
func _ready():
	load_data()


# =========================
# LOAD / SAVE
# =========================
func load_data():
	if not FileAccess.file_exists(FILE_PATH):
		save_data() # crea archivo vacío
		return

	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	var content = file.get_as_text()
	file.close()

	if content.is_empty():
		articles = []
		return

	var json = JSON.parse_string(content)

	if json == null:
		articles = []
	else:
		articles = json


func save_data():
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(articles, "\t"))
	file.close()


# =========================
# CRUD
# =========================

func add_article(nombre: String, categoria: String):
	var new_article = {
		"id": _generate_id(),
		"nombre": nombre.strip_edges(),
		"categoria": categoria.strip_edges()
	}

	articles.append(new_article)
	save_data()


func get_articles() -> Array:
	return articles


func delete_article(id: int):
	for i in articles.size():
		if articles[i]["id"] == id:
			articles.remove_at(i)
			save_data()
			return


func update_article(id: int, nombre: String, categoria: String):
	for article in articles:
		if article["id"] == id:
			article["nombre"] = nombre.strip_edges()
			article["categoria"] = categoria.strip_edges()
			save_data()
			return


# =========================
# HELPERS
# =========================

func _generate_id() -> int:
	var max_id = 0
	for article in articles:
		if article["id"] > max_id:
			max_id = article["id"]

	return max_id + 1
