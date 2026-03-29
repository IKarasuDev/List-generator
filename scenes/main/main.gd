extends Control

@onready var screen_container = $screen_container

var current_screen: Node = null

func _ready():
	go_to_articles()


func clear_screen():
	if current_screen:
		current_screen.queue_free()
		current_screen = null


func go_to_articles():
	clear_screen()

	var scene = preload("res://scenes/articles/articles_screen.tscn")
	current_screen = scene.instantiate()

	screen_container.add_child(current_screen)

	# conectar navegación
	current_screen.connect("go_to_list_generator", go_to_list_generator)


func go_to_list_generator():
	clear_screen()

	var scene = preload("res://scenes/list_generator/list_generator_screen.tscn")
	current_screen = scene.instantiate()

	screen_container.add_child(current_screen)

	# conectar navegación
	current_screen.connect("go_back", go_to_articles)

func change_screen(new_scene_path: String, direction := 1):
	var new_scene = load(new_scene_path).instantiate()
	screen_container.add_child(new_scene)

	var width = get_viewport_rect().size.x

	# Posición inicial fuera de pantalla
	new_scene.position.x = width * direction

	var tween = create_tween()

	# Animar entrada
	tween.tween_property(new_scene, "position:x", 0, 0.3)

	# Animar salida del anterior
	if current_screen:
		tween.tween_property(current_screen, "position:x", -width * direction, 0.3)

	# Cuando termina, eliminar anterior
	tween.finished.connect(func():
		if current_screen:
			current_screen.queue_free()
		current_screen = new_scene
	)
