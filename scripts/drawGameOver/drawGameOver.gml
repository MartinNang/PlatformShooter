// Skriptelemente wurden für v2.3.0 geändert, weitere Informationen sind unter
// https://help.yoyogames.com/hc/en-us/articles/360005277377 verfügbar
function drawGameOver(){
	draw_set_alpha(0.5);
	draw_set_colour(c_black);
	draw_rectangle(0, 0, window_get_width(), window_get_height(), false);
	draw_set_alpha(1);
	draw_set_colour(c_white);
	draw_set_font(fn_1);
	draw_text(window_get_width()/2 - 165, window_get_height()/2 - 50, "Game Over.");
}