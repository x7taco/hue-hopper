extends Control

var HeartIcon = preload("res://hud/HeartIcon.tscn")

onready var heart_container: HBoxContainer = $LifeContainer


func _ready() -> void:
	clear_hearts()
	Signals.connect("player_stat_changed", self, "update_hud")
	Signals.connect("color_changed", self, "_update_color_label")

func clear_hearts():
	for heart in heart_container.get_children():
		heart.queue_free()

func _update_color_label(new_color: String) -> void:
	$Order.set_text(new_color)

func update_player_coins(amount: int): # Combinded with update_hud. Might seperate later
	pass
	###PlayerData.coins += amount
	###$CoinLabel.set_text(str(PlayerData.coins))

func update_hud() -> void:
	$ScoreLabel.set_text(str(PlayerData.get_player_score()))
	$CoinLabel.set_text(str(PlayerData.coins))
	clear_hearts()
	for _i in range(PlayerData.hearts):
		heart_container.add_child(HeartIcon.instance())
