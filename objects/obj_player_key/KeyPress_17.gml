/// @description Hier Beschreibung einfügen
// Sie können Ihren Code in diesem Editor schreiben
if (ground_pound != 1 && !place_meeting(x, y+1, obj_barrier)) {
	ground_pound = 1;
	vsp += ground_pound_spd;
}