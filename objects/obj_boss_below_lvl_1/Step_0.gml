/// @description ToDo - Implement Decision-AI
// Sie können Ihren Code in diesem Editor schreiben
//movement (jumping)

if (distance_to_object(obj_player_mouse) < range) {
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
	
	if (movement_counter == 0) {
		movement_counter = movement_vertical_dist / movement_spd;
		movement_direction *= -1;
	} 
	y += movement_direction * movement_spd;
	movement_counter--;
	
	//TODO: implement boss vulnerability (get hit by own barrier-based attack like reflected acid sent through barrier from above)
	//spawn shadow objects
	if (shadow_spawn_cnt <= 0) {
		shadow_spawn_cnt = shadow_spawn_max;
		mouse = instance_nearest(x, y, obj_player_mouse);
		shadow = instance_create_layer(mouse.x, window_get_height()/2 - 1, "Instances", obj_boss_below_shadow);
	}
	shadow_spawn_cnt--;

}