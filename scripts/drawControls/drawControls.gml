// Skriptelemente wurden für v2.3.0 geändert, weitere Informationen sind unter
// https://help.yoyogames.com/hc/en-us/articles/360005277377 verfügbar
function drawControls(){
	var vx = camera_get_view_x(view_camera[1]);
	var vy = camera_get_view_y(view_camera[1]);
	draw_set_font(fn_0);
	draw_text(window_get_width() - 265, vy + 20, "Controls:");
	draw_text(window_get_width() - 265, vy + 55, "Reset Level - R");
	draw_text(window_get_width() - 265, vy + 80, "Move - WASD, Mouse");
	draw_text(window_get_width() - 265, vy + 105, "Ground Pound - CTRL");
	draw_text(window_get_width() - 265, vy + 130, "Shoot - LMB, RMB");
}