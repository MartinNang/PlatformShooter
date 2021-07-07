image_speed = 0;
hit = 0;
light_hit = 0;
v_light_hit = 0;
hit_below = 0; //TODO: add hits from above
hit_above = 0;
hit_cooldown = 10;
hit_cooldown_timer = hit_cooldown;
eruption_cooldown_timer = -1; // 0 < x <= 2
pushback = 15;
v_pushback = 5;
wave_from_right = 0;
wave_from_left = 0;

image_speed = 1/(hit_cooldown/6);