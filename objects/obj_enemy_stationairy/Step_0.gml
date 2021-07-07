/// @description Hier Beschreibung einfügen
// Sie können Ihren Code in diesem Editor schreiben
var dirToKey;
/*key_player_inst = instance_nearest(x, y, obj_player_key);
	if (key_player_inst != noone)
	dirToKey = x < key_player_inst.x ? 1 : -1;
	else dirToKey = -1;
	
hsp = walkspd * dirToKey;*/

if (!stuck_to_platform && vsp < maxFallSpeed) {
	vsp += grav;	
}

if (hsp < walkspd * -1 || hsp > walkspd) {
	hsp *= 1-fric;
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
				//push enemy in other direction
				if (colliding_barrier_inst.wave_from_left == 0 && colliding_barrier_inst.wave_from_right == 1) {
					hsp -= 15;
					vsp -= jumpspeed * 0.5;
				} 
		
				else if (colliding_barrier_inst.wave_from_left == 1 && colliding_barrier_inst.wave_from_right == 0) {
					hsp += 15;
					vsp -= jumpspeed * 0.5;
				}
	
				//TODO: add cooldown for pushback
			}
	    }
	}
	ds_list_destroy(colliding_barrier_list);
}

if (stuck_to_platform && place_meeting(x, y, obj_plat)) {
	//check if I am above, below or besides the platform (to move circular around platform)
	//below
	if (!place_meeting(x, y + 1, obj_plat)) {
		vsp = 0;
		if (!place_meeting(x - walkspd, y, obj_plat)) {
			while(place_meeting(x - 1, y, obj_plat)) {
				x--;
			}
			y--;
			hsp = 0;
		} else {
			hsp = -walkspd; //move left
		}
	}
	
	//above
	else if (!place_meeting(x, y - 1, obj_plat)) {
		vsp = 0;
		if (!place_meeting(x + walkspd, y, obj_plat)) {
			while(place_meeting(x + 1, y, obj_plat)) {
				x++;
			}
			y++;
			hsp = 0;
		} else {
			hsp = walkspd; //move right
		}
	}
	
	//left
	else if (!place_meeting(x - 1, y, obj_plat)) {
		hsp = 0;
		if (!place_meeting(x, y - walkspd, obj_plat)) {
			while(place_meeting(x, y - 1, obj_plat)) {
				y--;
			}
			x++;
			vsp = 0;
		} else {
			vsp = -walkspd; //move up
		}	
		/*if (!place_meeting(x, y, obj_plat)) {
			while(place_meeting(x, y + 1, obj_plat)) {
				y++;
			}
			x++;
			vsp=0;
		}*/
	}
	
	//right
	else if (!place_meeting(x + 1, y, obj_plat)) {
		hsp = 0;
		if (!place_meeting(x, y + walkspd, obj_plat)) {
			while(place_meeting(x, y + 1, obj_plat)) {
				y++;
			}
			x--;
			vsp = 0;
		} else {
			vsp = walkspd; //move down
		}		
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

//Vertical Collision
	//with barrier
if (place_meeting(x, y + vsp, obj_barrier)) {
	while(!place_meeting(x, y + sign(vsp), obj_barrier)) {
		y += sign(vsp);
	}
	vsp = 0;
}

	//with platform
/*if (place_meeting(x, y + vsp - sprite_height/2, obj_plat)) {
	while(!place_meeting(x, y + sign(vsp), obj_plat)) {
		y += sign(vsp);
	}
	vsp = 0;
}*/ 

if (!stuck_to_platform) {
	if (place_meeting(x, y + vsp, obj_plat)) {
		while(!place_meeting(x, y, obj_plat)) {
			y += sign(vsp);
		}
		stuck_to_platform = true;
		vsp = 0;
		walkspd = platspd;	
		sprite_index = spr_enemy_stationairy_active;
	}
	/*else {
		stuck_to_platform = false;
		walkspd = 0;
	}*/
}

x += hsp;
y += vsp;

/*function directionToKeyPlayer() {
	key_player_inst = instance_nearest(x, y, obj_player_key);
	if (key_player_inst != noone)
	return x < key_player_inst.x ? -1 : 1;
	else return -1;
}*/