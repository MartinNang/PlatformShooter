/// @description Hier Beschreibung einfügen
// Sie können Ihren Code in diesem Editor schreiben
var dirToKey;
/*key_player_inst = instance_nearest(x, y, obj_player_key);
	if (key_player_inst != noone)
	dirToKey = x < key_player_inst.x ? 1 : -1;
	else dirToKey = -1;
	
hsp = walkspd * dirToKey;*/

if (vsp < maxFallSpeed) {
	vsp += grav;	
}

if (hsp < walkspd * -1) {
	hsp += frict;	
}
if (hsp > walkspd) {
	hsp -= frict;	
}

if (hsp > 0) {
	image_xscale = -1.2;
} else if (hsp < 0) {
	image_xscale = 1.2;
} else {
	if (prevHsp > 0) {
		image_xscale = -1.2;	
	} else {
		image_xscale = 1.2;	
	}
}

if (place_meeting(x, y+1, obj_barrier)) {
	vsp = 0;
	var colliding_barrier_list = ds_list_create();
	var colliding_barrier_num = instance_place_list(x, y+1, obj_barrier, colliding_barrier_list, false);
	if colliding_barrier_num > 0 {
		var playerWalksOnHitTile = false;
	    for (var i = 0; i < colliding_barrier_num; ++i;) {
			var colliding_barrier_inst = colliding_barrier_list[| i];
	        if (colliding_barrier_inst.hit == 1) {
				if (!playerWalksOnHitTile) {
					vsp -= jumpspeed;
					playerWalksOnHitTile = true;
				}
			} else if (colliding_barrier_inst.image_index > 0) {
				//push player in other direction
				if (colliding_barrier_inst.wave_from_left == 0 && colliding_barrier_inst.wave_from_right == 1) {
					hsp -= 15;
				} 
		
				else if (colliding_barrier_inst.wave_from_left == 1 && colliding_barrier_inst.wave_from_right == 0) {
					hsp += 15;
				}
	
				//TODO: add cooldown for pushback
			}
	    }
	}
	ds_list_destroy(colliding_barrier_list);
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

//Vertical Collision
	//with barrier
if (place_meeting(x, y + vsp, obj_barrier)) {
	while(!place_meeting(x, y + sign(vsp), obj_barrier)) {
		y += sign(vsp);
	}
	vsp = 0;
}

	//with platform (from above)
if (place_meeting(x, y + vsp + sprite_height/2, obj_plat) && vsp >= 0) {
	while(!place_meeting(x, y + sign(vsp) - sprite_height, obj_plat)) {
		y += sign(vsp);
	}
	vsp = 0;
}

x += hsp;
y += vsp;

/*function directionToKeyPlayer() {
	key_player_inst = instance_nearest(x, y, obj_player_key);
	if (key_player_inst != noone)
	return x < key_player_inst.x ? -1 : 1;
	else return -1;
}*/