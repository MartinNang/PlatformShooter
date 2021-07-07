/// @description Hier Beschreibung einfügen
// Sie können Ihren Code in diesem Editor schreiben
if (!global.game_over) {
	if (global.paused == false) {
		instance_deactivate_all(true);
		global.paused = true;
	} else if (global.paused == true) {
		instance_activate_all();	
		global.paused = false;
	}
}
