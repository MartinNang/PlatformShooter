// @description Initialize Variables
// Sie können Ihren Code in diesem Editor schreiben
walkspd = 2.5;
hsp = -walkspd;
vsp = 0;
grav = 0.2; 
jumpspeed = 7;
movespeed = 4;
maxFallSpeed = 10;
frict = 10;
prevHsp = hsp;
boss_above = instance_nearest(x, y, obj_boss_above_lvl_1);