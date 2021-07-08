/// @description Hier Beschreibung einfügen
// Sie können Ihren Code in diesem Editor schreiben
if (closest_barrier.hit_above == 1) {
	boss_below.hp -= 50;
	instance_destroy(self);
}

if (alarm_get(0) == 50) {
	shadow_bullet = instance_create_layer(x, y, "Instances", obj_shadow_bullet);
	shadow_bullet.direction = 270;
	shadow_bullet.image_angle = 0;
	shadow_bullet.speed = -drop_speed;	
}