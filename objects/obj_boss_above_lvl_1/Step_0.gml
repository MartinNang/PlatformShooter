/// @description ToDo - Implement Decision-AI
// Sie können Ihren Code in diesem Editor schreiben

//movement
if (vsp < maxFallSpeed) {
	vsp += grav;	
}

if (hsp < maxHsp * -1 || hsp > maxHsp) {
	hsp *= (1-frict);	
}

if (place_meeting(x, y+1, obj_barrier)) {
	jumps = 1;
}

if (distance_to_object(obj_player_key) < range) {
	//jumping
	player_key_inst = instance_nearest(x, y, obj_player_key);
	if (jump_timer > 0) {
		jump_timer--;
	}
	
	if (jump_timer <= 0 && jumps == 1) {
		if (player_key_inst.y - y < -range*0.1) {
			vsp -= jumpSpd;
			/*if (abs(player_key_inst.x - x) < range*0.2) {
				hsp = sign(player_key_inst.x - x) * hspJmpSpd;
			}*/
		} 
		jumps = 0;
		jump_timer = jump_timer_max;
	} 
	
	//shoot
	if (shoot_timer > 0) {
		shoot_timer--;
	}
	if (shoot_timer <= 0) {
		//shoot
		bullet = instance_create_layer(x, y, "Instances", obj_odd_bullet);
		bullet.left = 1;
		bullet.up = 0;
		bullet.down = 0;
		bullet.right = 0;
		bullet.image_angle = 270;
		bullet.speed = 15;
		shoot_timer = shoot_timer_max;
	}
	
	//spawn low-lvl enemies
	enemy_timer--;
	if (enemy_timer <= 0) {
		enemy = instance_create_layer(x+220, 400, "Instances", obj_enemy_wheel);
		enemy_timer = enemy_timer_max;
	}
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
	while(!place_meeting(x, y + sign(vsp), obj_plat)) {
		y += sign(vsp);
	}
	vsp = 0;
}

//TODO: implementing boss vulnerability (get hit during a barrier-based attack)

if (place_meeting(x, y + vsp, obj_barrier)) { // TODO: f me
	barr = instance_nearest(x, y + vsp, obj_barrier);
	if (barr.hit_below == 1 && hit_lockdown == 0) {
			hp -= 100;
			hit_lockdown = hit_lockdown_max;
			sprite_index = 1;
	}
	if (hit_lockdown > 0) hit_lockdown--;
	if (barr.hit_below == 0 && hit_lockdown == 0) {
		sprite_index = 0;
	}
}

x += hsp;
y += vsp;