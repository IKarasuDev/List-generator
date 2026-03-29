extends Control

@onready var result_container = $CenterContainer/Panel/VBoxContainer/ScrollContainer/result_container

func setup(data: Dictionary):
	var grouped = {}

	for article in data.values():
		var cat = article["categoria"]

		if not grouped.has(cat):
			grouped[cat] = []

		grouped[cat].append(article["nombre"])

	show_result(grouped)


func show_result(grouped: Dictionary):
	for child in result_container.get_children():
		child.queue_free()

	for category in grouped.keys():
		var title = Label.new()
		title.text = category + ":"
		title.add_theme_color_override("font_color", Color.BLACK)  # 👈 negro
		result_container.add_child(title)

		for name in grouped[category]:
			var item = Label.new()
			item.text = " - " + name
			item.add_theme_color_override("font_color", Color.BLACK)  # 👈 negro
			result_container.add_child(item)


func _on_copy_btn_pressed() -> void:
	var text = ""

	for child in result_container.get_children():
		if child is Label:
			text += child.text + "\n"

	DisplayServer.clipboard_set(text)


func _on_close_btn_pressed() -> void:
	queue_free()
