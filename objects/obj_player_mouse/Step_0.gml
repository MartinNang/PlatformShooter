//* TODO: Implement collision handling
//
if (mouse_y > window_get_height()/2 + 29) {
	if distance_to_point(mouse_x, mouse_y) > spd
	   {
	   move_towards_point(mouse_x, mouse_y, spd);
	   }
	else {
		x = mouse_x;
		y = mouse_y;
		speed = 0;
	}
} else {
	if (y != window_get_height()/2 + 29) {
		if distance_to_point(mouse_x, window_get_height()/2 + 29) > spd
		   {
		   move_towards_point(mouse_x, window_get_height()/2 + 29, spd);
		   }
		else {
			x = mouse_x;
			y = window_get_height()/2 + 29;
			speed = 0;
		}
	}
}

//implement collision checks with enemies (tough one)

x += hspeed; 
y += vspeed;

if (mouse_check_button_pressed(mb_left)) {
	bullet = instance_create_layer(x, y, "Instances", obj_mouse_bullet);
	bullet.right = 1;
	bullet.up = 0;
	bullet.down = 0;
	bullet.left = 0;
	bullet.image_angle = 90;
	bullet.speed = 15;
}

if (mouse_check_button_pressed(mb_right)) {
	bullet = instance_create_layer(x, y-15, "Instances", obj_mouse_bullet);

	bullet.up = 1;
	bullet.right = 0;
	bullet.left = 0;
	bullet.down = 0;
	bullet.image_angle = 0;
	bullet.speed = 15;	
}

//check if alive
if (hp <= 0) {
	global.game_over = true;
	instance_destroy(self);
}

draw_healthbar(100, 100, 500, 200, hp, c_black, c_red, c_lime, 0, true, true)
