/// @description TODO: Fix positions after being hit with new sprites; crash on enemy horizontal and vertical collision
// Sie können Ihren Code in diesem Editor schreiben
if (hit == 1) {
	//hit_cooldown_timer -= 1;
	hit = 0;
}

/*if (hit_cooldown_timer == 0) {
	hit = 0;
	hit_cooldown_timer = hit_cooldown;
}*/

//reset after wave/eruption
if (image_index > image_number - 1) {
	image_index = 0;
	image_speed = 0;
	wave_from_right = 0;
	wave_from_left = 0;
	hit = 0;
	light_hit = 0;
	v_light_hit = 0;
}


if (place_meeting(x, y, obj_mouse_bullet)) {
	sprite_index = spr_barrier_hit_below;
	image_index = 0;
	image_speed = 1/(hit_cooldown/6);
	if (hit == 0) {
		hit = 1;
		hit_below = 1;
	}
	eruption_cooldown_timer = 2;
	//erupt_surrounding_ground();
}

if (place_meeting(x, y-1, obj_player_key)) {
	colliding_player_key_inst = instance_place(x, y-1, obj_player_key);
	if (colliding_player_key_inst.ground_pound == 1) {
		hit = 1;
		hit_above = 1;
		eruption_cooldown_timer = 2;
		if (colliding_player_key_inst.ground_pound_hit_stun_timer == 0) {
			colliding_player_key_inst.ground_pound_hit_stun_timer = colliding_player_key_inst.ground_pound_hit_stun; //ground pound occured
		}
		sprite_index = spr_barrier_hit_above;
		image_speed = 1/(hit_cooldown/6);
		
	}
}

//function erupt_surrounding_ground() {
	//Handle immediate neighbouring ground	
	if (eruption_cooldown_timer == 1) {
		var left_barrier_inst = instance_nearest(x - sprite_width , y, obj_barrier);
		var right_barrier_inst = instance_nearest(x + sprite_width, y, obj_barrier);
		
		startLightHit(left_barrier_inst);
		startLightHit(right_barrier_inst);
		
		left_barrier_inst.wave_from_right = 1;
		left_barrier_inst.light_hit = 1;
		right_barrier_inst.wave_from_left = 1;
		right_barrier_inst.light_hit = 1;
	}
	
	//Handle neighbours of neighbours
	else if (eruption_cooldown_timer == 0) {
		var left_left_barrier_inst = instance_nearest(x - 2*sprite_width , y, obj_barrier);
		var right_right_barrier_inst = instance_nearest(x + 2*sprite_width, y, obj_barrier);
		
		startVLightHit(left_left_barrier_inst);
		startVLightHit(right_right_barrier_inst);
		
		left_left_barrier_inst.wave_from_right = 1;
		left_left_barrier_inst.v_light_hit = 1;
		right_right_barrier_inst.wave_from_left = 1;
		right_right_barrier_inst.v_light_hit = 1;
		
		hit_below = 0;
		hit_above = 0;
	}
	
	if (eruption_cooldown_timer >= 0) {
		eruption_cooldown_timer--;
	}
//}

function startLightHit(inst) {
	if (hit_below == 1 && hit_above == 0) {
		inst.sprite_index = spr_barrier_light_hit_below;
		inst.image_index = 0;
		inst.image_speed = 1/(hit_cooldown/6);
	} else if (hit_above == 1 && hit_below == 0) {
		inst.sprite_index = spr_barrier_light_hit_above;
		inst.image_index = 0;
		inst.image_speed = 1/(hit_cooldown/6);	
	} else {
		inst.sprite_index = spr_barrier_default;
	}
}

function startVLightHit(inst) {
	if (hit_below == 1 && hit_above == 0) {
		inst.sprite_index = spr_barrier_very_light_hit_below;
		inst.image_index = 0;
		inst.image_speed = 1/(hit_cooldown/6);
	} else if (hit_above == 1 && hit_below == 0) {
		inst.sprite_index = spr_barrier_very_light_hit_above;
		inst.image_index = 0;
		inst.image_speed = 1/(hit_cooldown/6);
	} else {
		inst.sprite_index = spr_barrier_default;
	}
}