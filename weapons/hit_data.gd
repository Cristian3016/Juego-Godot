class_name HitData
extends Object
## Data properties concerning when a hurtbox is hit by a hibox move, attack, or action 

## The hitbox which hit the hurtbox with a move or attack
var hitbox             : Hitbox2D

## The receiving hurtbox of the move or attack
var hurtbox            : Hurtbox2D

## The amount of health change expected on the target
var amount             : int

## The actual amount of health change that resulted on the target
var actual_change      : int 

## The expected movement direction and magnitude of the knockback 
var knockback_force    : Vector2

## The length of knockback duration
var knockback_duration : float
 
func _init(p_hitbox : Hitbox2D, p_hurtbox : Hurtbox2D, p_amount : int, 
p_knockback_force : Vector2 = Vector2.ZERO, p_knockback_duration : float= 0.0 ) -> void:
  hitbox = p_hitbox
  hurtbox = p_hurtbox
  amount = p_amount
  knockback_force = p_knockback_force
  knockback_duration = p_knockback_duration

   
