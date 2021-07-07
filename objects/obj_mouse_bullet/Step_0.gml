/// @description Hier Beschreibung einfügen
// Sie können Ihren Code in diesem Editor schreiben

if (!place_meeting(x, y, obj_barrier)) {
	if (up == 1) {
		y -= speed;
	} else if(left == 1) {
		x -= speed;
	} else if(right == 1) {
		x += speed;
	} else if (down == 1) {
		y += speed;
	}
} else {
	var barrier_inst = instance_place(x, y, obj_barrier);
	if (y > barrier_inst.y) {
		barrier_inst.hit_below = 1;
	}
	instance_destroy(self);
}

death_timer--;
if (death_timer <= 0) {
	instance_destroy(self);
}