/// @description Hier Beschreibung einfügen
// TODO: Fix movement, make regular movements between stalagtites (Swarm of bats?)
var dirToKey;

if (hsp < walkspd * -1) {
	hsp += frict;	
}
if (hsp > walkspd) {
	hsp -= frict;	
}

if (hsp > 0) {
	image_xscale = -1.85;
} else if (hsp < 0) {
	image_xscale = 1.85;
} else {
	if (prevHsp > 0) {
		image_xscale = -1.85;	
	} else {
		image_xscale = 1.85;	
	}
}

//Horizontal Collision
	//with barrier
if (place_meeting(x + hsp, y, obj_barrier)) {
	while(!place_meeting(x + sign(hsp), y, obj_barrier)) {
		x += sign(hsp);
	}
	hsp *= -1;
}

	//with other enemy
if (place_meeting(x + hsp, y, obj_enemy)) {
	while(!place_meeting(x + sign(hsp), y, obj_enemy)) {
		x += sign(hsp);
	}
	hsp *= -1;
}

if (place_meeting(x + hsp, y, obj_enemy_stalactite)) {
	while(!place_meeting(x + sign(hsp), y, obj_enemy_stalactite)) {
		x += sign(hsp);
	}
	hsp *= -1;
}

//Vertical Collision
	//with barrier
if (place_meeting(x, y - 1, obj_barrier)) {
	while(!place_meeting(x, y - 1, obj_barrier)) {
		y -= 1;
	}
}

//Damage Collision
if (place_meeting(x, y, obj_player_mouse)) {
	player_mouse_inst = instance_place(x, y, obj_player_mouse);
	player_mouse_inst.hp -= dmg;
	hp -= 5;
}

if (place_meeting(x, y, obj_mouse_bullet)) {
		var bullet_inst = instance_place(x, y, obj_mouse_bullet);
		hp -= bullet_inst.dmg;
		instance_destroy(bullet_inst);
}

//Check if alive
if (hp <= 0) {
	instance_destroy(self);
}

x += hsp;