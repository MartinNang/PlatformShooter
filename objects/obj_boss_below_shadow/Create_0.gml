alarm_set(0, 60);
drop_speed = 10;
shadow_bullet = instance_create_layer(x, y, "Instances", obj_shadow_bullet);
shadow_bullet.direction = 270;
shadow_bullet.image_angle = 0;
shadow_bullet.speed = -drop_speed;