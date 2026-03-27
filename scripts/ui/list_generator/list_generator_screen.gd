extends Control

const SelectableItem = preload("res://scenes/list_generator/selectable_item.tscn")

@onready var items_container = $VBoxContainer/ScrollContainer/items_container

#Estado en memoria (sin duplicados)
var selected_articles: Dictionary = {}  # key = id

func _ready():
	load_items()


# =========================
# CARGAR ARTÍCULOS
# =========================
func load_items():
	for child in items_container.get_children():
		child.queue_free()

	var articles = DataManager.get_articles()

	for article in articles:
		var item = SelectableItem.instantiate()
		items_container.add_child(item)
		item.setup(article, self)  # pasamos referencia


# =========================
# SELECCIÓN
# =========================
func add_to_list(article: Dictionary):
	var id = article["id"]

	if selected_articles.has(id):
		return  # evita duplicados

	selected_articles[id] = article
	print("Agregado:", article["nombre"])


# =========================
# GENERAR (SIN UI AÚN)
# =========================
func _on_generate_btn_pressed():
	var grouped = _group_articles(selected_articles)
	print(grouped)  # por ahora solo debug


func _group_articles(data: Dictionary) -> Dictionary:
	var grouped = {}

	for article in data.values():
		var cat = article["categoria"]

		if not grouped.has(cat):
			grouped[cat] = []

		grouped[cat].append(article["nombre"])

	return grouped
