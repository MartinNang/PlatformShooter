/// @description Get the player's input
// Sie können Ihren Code in diesem Editor schreiben
//TODO: remove jump cancelling ground pound

key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_left = -(keyboard_check(vk_left) || keyboard_check(ord("A")));
key_jump = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
prevHsp = hsp;
//React to inputs
move = key_left + key_right;

//apply friction if hsp too high
if (move * movespeed == 0 || hsp > movespeed) {
	hsp *= 1-fric;
} else {
	hsp = move * movespeed;
}

if (vsp < maxFallSpeed) {
	vsp += grav;	
}


if (place_meeting(x, y+1, obj_barrier)) {
	jumps = 1;
	vsp = 0;
	
	var colliding_barrier_list = ds_list_create();
	var colliding_barrier_num = instance_place_list(x, y+1, obj_barrier, colliding_barrier_list, false);
	if colliding_barrier_num > 0 {
		var playerWalksOnHitTile = false;
		for (var i = 0; i < colliding_barrier_num; ++i;) {
			var colliding_barrier_inst = colliding_barrier_list[| i];
			if (colliding_barrier_inst.hit_below == 1 && colliding_barrier_inst.hit_above == 0) {
				if (colliding_barrier_inst.hit == 1)  {
					if (!playerWalksOnHitTile) {
						vsp -= bouncespeed;
						playerWalksOnHitTile = true;
					}
				} 
				else if (colliding_barrier_inst.light_hit > 0) {
					//make player bounce away
					//vsp -= bouncespeed/3*2;
					if (colliding_barrier_inst.wave_from_left == 0 && colliding_barrier_inst.wave_from_right == 1) {
						//hsp -= bouncespeed;
						hsp -= 2;
					} else if (colliding_barrier_inst.wave_from_left == 1 && colliding_barrier_inst.wave_from_right == 0) {
						//hsp += bouncespeed;
						hsp += 2;
					}				
				} else if (colliding_barrier_inst.v_light_hit > 0) {
					//push player in other direction
					if (colliding_barrier_inst.wave_from_left == 0 && colliding_barrier_inst.wave_from_right == 1) {
						hsp -= 1;
					} else if (colliding_barrier_inst.wave_from_left == 1 && colliding_barrier_inst.wave_from_right == 0) {
						hsp += 1;
					}
				}
				//TODO: add cooldown for pushback
			}
		}
	}
	ds_list_destroy(colliding_barrier_list);	
	ground_pound = 0;
}
 
 if (ground_pound_hit_stun_timer > 0) {
	ground_pound_hit_stun_timer--;
	ground_pound = 0;
}

if (jumps > 0) {
	if (key_jump = 1) {
		vsp = -jumpspeed;
		//vsp = vsp + key_jump * -jumpspeed;
		jumps -= key_jump;
	}
}

//Horizontal Collision
if (place_meeting(x + hsp, y, obj_barrier)) {
	while(!place_meeting(x + sign(hsp), y, obj_barrier)) {
		x += sign(hsp);
	}
	hsp = 0;
}

//Vertical Collision
	//with barrier
if (place_meeting(x, y + vsp, obj_barrier)) {
	while(!place_meeting(x, y + sign(vsp), obj_barrier)) {
		y += sign(vsp);
	}
	vsp = 0;
}

	//with platform (from above)
if (place_meeting(x, y + vsp, obj_plat) && vsp >= 0) {	
	var colliding_plat_inst = instance_place(x, y+vsp, obj_plat);
	if (y + sprite_height/2 < colliding_plat_inst.y - 3 ) {
		while(!place_meeting(x, y + sign(vsp), obj_plat)) {
			y += sign(vsp);
		}
		vsp = 0;
		jumps = 1;
		ground_pound = 0;
	}
}
//Jump on enemy
if (vsp > 0 && place_meeting(x, y + vsp, obj_enemy)) {
	var colliding_enemy_inst = instance_place(x, y+vsp, obj_enemy);
	while(!place_meeting(x, y + sign(vsp), obj_enemy)) {
		y += sign(vsp);
	}
	
	vsp = -1*jumpspeed;
	instance_destroy(colliding_enemy_inst);
	ground_pound = 0;
}

//check damage
if (place_meeting(x, y, obj_enemy) && dmg_invulnerability_timer == 0) {
	dmg_invulnerability_timer = dmg_invulnerability;
	key_lives--;
}

if (dmg_invulnerability_timer > 0) {
	dmg_invulnerability_timer--;
}

//check if alive
if (key_lives <= 0) {
	global.game_over = true;
	instance_destroy(self);
}

x += hsp;
y += vsp;