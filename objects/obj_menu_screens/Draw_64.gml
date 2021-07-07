/// @description Hier Beschreibung einfügen
// Sie können Ihren Code in diesem Editor schreiben
drawControls();

if (global.game_over == true) {
	drawGameOver();
} 
else if (global.paused == true) {
	drawPauseMenu();	
}