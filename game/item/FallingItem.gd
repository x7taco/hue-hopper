extends Area2D
class_name FallingItem

signal on_flask_contact

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var glass_hit_sound: AudioStreamPlayer = get_node("GlassHitSound")

var item_id: int # Used to apply debuffs 
var fall_speed: float = 0
var rotation_speed: int
var type: int
var does_rotate: bool 

func setup(id: int) -> void:
	self.item_id = id

	match(self.item_id):
		Global.ITEMS.PAINT_BUCKET:
			self.fall_speed = 190
			self.rotation_speed = 9
		Global.ITEMS.FLASK_ORANGE:
			self.fall_speed = 50
			self.rotation_speed = 3

func _ready() -> void:
	_set_sprite(self.item_id)

func _process(delta) -> void:
	position.y += fall_speed * delta
	if self.does_rotate:
		self.rotation_degrees += rotation_speed

func _set_sprite(item_type: int) -> void:
	match item_type:
		Global.ITEMS.FLASK_ORANGE:
			animated_sprite.play("flask_orange")
		Global.ITEMS.PAINT_BUCKET:
			animated_sprite.play("paint_whole")

# func do_item_effect() -> void:
# 	match self.type:
# 		Global.ITEMS.FLASK_ORANGE:
# 			Signals.emit_signal("apply_effect", self.debuff_id)
# 		Global.ITEMS.PAINT_BUCKET:
# 			glass_hit_sound.play()
# 			yield(glass_hit_sound, "finished")
# 			Signals.emit_signal("apply_effect", Global.EFFECTS.WHITE_OUT)
# 			self.fall_speed = 0
# 			self.animated_sprite.play("paint_break")

func _on_Item_body_entered(body: Node) -> void:
	if body.get_class() == "Player":
		print('contact with player')
		body.apply_debuff(self.item_id)
		call_deferred("disable_item_collision") 
		queue_free()

func disable_item_collision() -> void:
	# To prevent body enetered from triggering twice if coin is lower to ground
	$CollisionShape2D.set_disabled(true)

func _get_random_item_id() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(0, 3)

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

