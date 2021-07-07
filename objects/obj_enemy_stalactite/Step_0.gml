/// @description Hier Beschreibung einfügen
// Sie können Ihren Code in diesem Editor schreiben
if (random_start_lock > 0) {
	random_start_lock--;
} 
else if (random_start_lock == 0) {
	if (acid_drop_timer > 0) {
		acid_drop_timer--;
	} else {
		//spawn acid droplet
		acid_drop = instance_create_layer(x, y, "Instances", obj_stalactite_droplet);
		acid_drop.direction = 270;
		acid_drop.image_angle = 0;
		acid_drop.speed = -drop_speed;
	
		//reset timer
		acid_drop_timer = acid_drop_interval;
	}

	if (hp <= 0) {
		instance_destroy(self);
	}

	if (place_meeting(x, y, obj_mouse_bullet)) {
		var bullet_inst = instance_place(x, y, obj_mouse_bullet);
		hp -= bullet_inst.dmg;
		instance_destroy(bullet_inst);
	}
}

//check if ground pound occured nearby
var colliding_barrier_list = ds_list_create();
var colliding_barrier_num = instance_place_list(x, y-1, obj_barrier, colliding_barrier_list, false);
if colliding_barrier_num > 0 {
	var playerWalksOnHitTile = false;
	for (var i = 0; i < colliding_barrier_num; ++i;) {
		var colliding_barrier_inst = colliding_barrier_list[| i];
		if (colliding_barrier_inst.hit_above == 1) {
			acid_drop_timer = 0;
		}
	}
}

function dropAcid() {
	acid_drop = instance_create_layer(x, y, "Instances", obj_stalactite_droplet);
		acid_drop.direction = 270;
		acid_drop.image_angle = 0;
		acid_drop.speed = -drop_speed;
}