/// @description Hier Beschreibung einfügen
// Sie können Ihren Code in diesem Editor schreiben
if (!place_meeting(x, y, obj_player_mouse)) {
	y += speed;
	speed += grav;
} else {
	player_mouse_inst = instance_place(x, y, obj_player_mouse);
	player_mouse_inst.hp -= dmg;
	instance_destroy(self);	
}