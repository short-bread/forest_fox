function generate_textures() {
	//create surface for making textures
	var tex_surf = surface_create(256,256);
	
	//fox texture
	surface_set_target(tex_surf);
	draw_clear_alpha(c_white,0);
	draw_set_colour(6792959); draw_rectangle(0,0,1,1,false);
	draw_set_colour(12902379); draw_rectangle(1,0,2,1,false);
	draw_set_colour(6001899); draw_rectangle(0,1,1,2,false);
	draw_set_colour(2308183); draw_rectangle(1,1,2,2,false);
	surface_reset_target();
	global.fox_sprite = sprite_create_from_surface(tex_surf,0,0,2,2,false,false,0,0);
	global.fox_texture = sprite_get_texture(global.fox_sprite,0);
    
	//fox shadow texture
	surface_set_target(tex_surf);
	draw_clear_alpha(c_white,0);
	draw_set_colour($28492f); draw_rectangle(0,0,1,1,false);
	surface_reset_target();
	global.fox_shadow_sprite = sprite_create_from_surface(tex_surf,0,0,1,1,false,false,0,0);
	global.fox_shadow_texture = sprite_get_texture(global.fox_shadow_sprite,0);
    
	//tree texture
	surface_set_target(tex_surf);
	draw_clear_alpha(c_white,0);
	var le = 6;
	var am = 256/le;
	for (var tl = -1; tl < le; tl++) {
	    draw_triangle_colour(tl*am,256,tl*am+50,0,tl*am+100,256,$255d00,$44ac00,$255d00,false);
	}
	surface_reset_target();
	global.tree_leaves_sprite = sprite_create_from_surface(tex_surf,0,0,256,256,false,false,0,0);
	global.tree_leaves_texture = sprite_get_texture(global.tree_leaves_sprite,0);
	
	draw_set_colour(c_white);
	draw_set_alpha(1);
	
	//tree shadow texture
	surface_set_target(tex_surf);
	draw_clear_alpha(c_white,0);     
	transform_add_rotation_y(65);
	transform_add_rotation_z(-45);
	transform_add_scaling(4,4,0);
	transform_add_translation(210,210,0);
	draw_set_colour(c_black); draw_cone(-4,-4,0,+4,+4,30+50,-1,1,1,false,5);
	transform_add_translation(-60,-60,0);
	vertex_submit(global.tree_leaves_model, pr_trianglelist, global.tree_leaves_texture);
	transform_set_identity();
	surface_reset_target();
	draw_set_colour(c_white);
	global.tree_shadow_sprite = sprite_create_from_surface(tex_surf,0,0,256,256,false,false,0,0);
	global.tree_shadow_texture = sprite_get_texture(global.tree_shadow_sprite,0);
    
	//trap texture
	surface_set_target(tex_surf);
	draw_clear_alpha(c_white,0);
	draw_set_colour(c_dkgray); draw_rectangle(0,0,256,100,false);
	var le = 6;
	var am = 256/le;
	for (var tl = 1; tl < le-1; tl++) {
	    draw_triangle_colour(tl*am,0,tl*am+50,256,tl*am+100,0,c_dkgray,c_ltgray,c_dkgray,false);
	}
	surface_reset_target();
	global.trap_sprite = sprite_create_from_surface(tex_surf,0,0,256,256,false,false,0,0);
	global.trap_texture = sprite_get_texture(global.trap_sprite,0);

	//fox icon texture
	surface_set_target(tex_surf);
	draw_clear_alpha(c_white,0);
	draw_set_color(c_white);
	transform_add_rotation_y(-90);
	transform_add_rotation_z(90);
	transform_add_scaling(3,3,3);
	transform_add_translation(30,40,0);
	vertex_submit(global.fox_model[0], pr_trianglelist, global.fox_texture);
	transform_set_identity();
	surface_reset_target();
	global.fox_icon_sprite = sprite_create_from_surface(tex_surf,0,0,200,200,false,false,0,0);
	
	surface_free(tex_surf);
}
	
function generate_models() {
	//Fox
	build_fox_models();
	
	//Coin
	global.coin_model = vertex_create_buffer();
	vertex_begin(global.coin_model,global.v_format);
	draw_set_colour($2bddff);
	build_cylinder(-4,-4,0,+4,+4,1,-1,1,1,true,7,global.coin_model);
	vertex_end(global.coin_model);
	vertex_freeze(global.coin_model);
	
	//Trap
	global.trap_model = vertex_create_buffer();
	vertex_begin(global.trap_model,global.v_format);
	draw_set_colour(c_white);
	build_cylinder(-4,-4,0,4,4,4,-1,2,1,false,7,global.trap_model);     
	build_cylinder(-3.6,-3.6,0,3.6,3.6,4,-1,2,1,false,7,global.trap_model);
	vertex_end(global.trap_model);
	vertex_freeze(global.trap_model);

	//Tree leaves
	global.tree_leaves_model = vertex_create_buffer();
	vertex_begin(global.tree_leaves_model,global.v_format);
	draw_set_colour($c8c8c8);
	build_cone(-18, -18, 0, 18, 18, 20, -1, 2, 1, false, 30, global.tree_leaves_model);
	draw_set_colour($dcdcdc);
	build_cone(-15, -15, 10, 15, 15, 28, -1, 1.5, 1, true, 30, global.tree_leaves_model);
	draw_set_colour($f0f0f0);
	build_cone(-12, -12, 20, 12, 12, 40, -1, 1.25, 1, true, 30, global.tree_leaves_model);
	draw_set_colour(c_white);
	build_cone(-8, -8, 30, 8, 8, 50, -1, 1, 1, true, 20, global.tree_leaves_model);
	vertex_end(global.tree_leaves_model);
	vertex_freeze(global.tree_leaves_model);
	
	//tree trunks
	var _colors = [];
	_colors[0] = $346c8e;
	_colors[1] = $2d546c;
	_colors[2] = $1e3654;
	
	global.tree_trunk_model = [];
	
	for (var _c = 0; _c<3; _c++) {
		global.tree_trunk_model[_c] = vertex_create_buffer();
		draw_set_color(_colors[_c]);
		vertex_begin(global.tree_trunk_model[_c],global.v_format);
		build_cone(-4,-4,0,4,4,1,-1,1,1,false,5, global.tree_trunk_model[_c]);
		vertex_end(global.tree_trunk_model[_c]);
		vertex_freeze(global.tree_trunk_model[_c]);
	}
}
	
function entity(_x, _y, _type) constructor {
	x = _x;
	y = _y;
	type = _type;
}

function create_tree(_x,_y) {
	var _tree = new entity(_x,_y,entity_type.tree);
	_tree.height = 20+irandom(20);
	_tree.color = irandom(2);
	ds_list_add(global.entity_list,_tree);
}

function create_coin(_x,_y) {
	var _coin = new entity(_x,_y,entity_type.coin);
	ds_list_add(global.entity_list,_coin);
}

function create_trap(_x,_y) {
	var _trap = new entity(_x,_y,entity_type.trap);
	ds_list_add(global.entity_list,_trap);
}

function game_init() {
	
	enum entity_type {
		tree,
		coin,
		trap
	}
	
	enum game_mode {
		title,
		playing,
		gameover
	}

	//vertex format
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_colour();
	vertex_format_add_texcoord();
	global.v_format = vertex_format_end();
	
	//draw settings
	gpu_set_tex_repeat(true);
	gpu_set_tex_filter(false);
	layer_force_draw_depth(true,0);
    	
	//generate assets
	generate_models();
	generate_textures();

	//render settings
	gpu_set_ztestenable(true);
	gpu_set_zwriteenable(true);
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(0);
	draw_light_define_ambient($1c6b9b);
	draw_light_define_direction(0,-0.2,1,-1,c_white);
	draw_light_enable(0,true);
	
	//window settings
	view_wport[0]   = 360;
	view_hport[0]   = 640;
	view_visible[0] = true;
	view_enabled    = true;
	view_camera[0] = camera_create_view(0, 0, 360, 640);
	surface_resize(application_surface,360,640);
	window_set_size(360, 640);
	
	//setup variables
	global.cam_x = 0; //cam x
	global.cam_y = -21; //cam y
	global.cam_z = 25; //cam z
	global.fox_x = 0; //fox x
	global.fox_z = 0; //fox z
	global.fox_target_x = 0; //fox target x
	global.fox_frame = 0; //fox model frame
	global.fox_vz = 0; //fox z speed
	global.fox_lives = 3; //fox lives
	global.fox_temp_inv = 0; //temp invincibility after hit
	global.time = current_time; //time between generating objects
	global.points = 1; //points
	global.speed_change_time = current_time; //speed change timer (to trigger speed up)
	global.entity_list = ds_list_create(); //entity list
	global.obj_speed = 1.5; //object speed
	global.game_mode = game_mode.title; //game mode

	//attach game loop to draw event
	layer_script_begin("Instances",game_loop);
}

function game_step() {
	
	//Playing
	if (global.game_mode == game_mode.playing) {
	    //input
	    global.fox_target_x += (keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left))*15;
		global.fox_target_x = clamp(global.fox_target_x,-15,15);
		
	    if (keyboard_check_pressed(vk_space) && (global.fox_z == 0)) {
	        global.fox_vz = 2; 
	    }

	    //move towards target x
	    global.fox_x += sign(global.fox_target_x-global.fox_x)*3;
	    global.fox_z += global.fox_vz;
        
	    //gravity
	    if (global.fox_z > 0) {
	        global.fox_vz-=0.2;
	    }
	    if (global.fox_z < 0) {
	        global.fox_z = 0;
	    }
        
	    //end invincibility
	    if ((current_time-global.fox_temp_inv) > 1000) {
	        global.fox_temp_inv = 0;       
	    }
        
	    //fox animation
	    global.fox_frame = (current_time/(100/(max(global.obj_speed/2,1)))) mod 3;
        
	    //increase speed
	    if (global.obj_speed < 4) && ((current_time-global.speed_change_time) > 10000) {
	        global.obj_speed+=0.1;
	        global.speed_change_time = current_time;
	    }
    
	    //generate objects
	    if ((current_time-global.time) > (1000/global.obj_speed)) {
        
	        //generate trees
	        create_tree((-1 + irandom(2))*15,400);
            
	        if (irandom(2) > 0) {
				create_tree(-irandom(1)*20-45,400);
	        }
	        if (irandom(2) > 0) {
				create_tree(irandom(1)*20+45,400);
	        }
            
	        //generate coins
	        if (irandom(1) > 0) {
				create_coin((-1 + irandom(2))*15,300);
	        }
	        //generate traps
	        else if (irandom(2) > 0) {
				create_trap((-1 + irandom(2))*15,300);
	        }
            
	        //add points
	        global.points+=5;
			
			//reset timer
			global.time = current_time;
	    }
		
		//update entities
		for (var _ei = ds_list_size(global.entity_list)-1; _ei >= 0; _ei--) {
			var _entity = global.entity_list[| _ei];
			
			//move entity towards fox
			if (global.game_mode == game_mode.playing) { _entity.y -= global.obj_speed; }
			
			//entity logic
			switch (_entity.type) {
				case entity_type.coin:
					//collision with fox
				    if (rectangle_in_rectangle(global.fox_x-4,-4,global.fox_x+4,8,_entity.x-4,_entity.y-4,_entity.x+4,_entity.y+4)) {
				        global.points+=80+irandom(20);
				        ds_list_delete(global.entity_list,_ei);
				    }
				break;
				
				case entity_type.trap:
					//collision with fox
				    if (global.fox_temp_inv == 0) && (global.fox_z < 1) && rectangle_in_rectangle(global.fox_x-4,-4,global.fox_x+4,8,_entity.x-4,_entity.y-4,_entity.x+4,_entity.y+4) {
				        global.fox_lives--;
				        global.fox_temp_inv = current_time;
				    }
				break;
				
				case entity_type.tree:
					//collision with fox
				    if (global.fox_temp_inv == 0) && rectangle_in_rectangle(global.fox_x-4,4,global.fox_x+4,8,_entity.x-4,_entity.y-4,_entity.x+4,_entity.y+4) {
				        global.fox_lives--;
				        global.fox_temp_inv = current_time;
				    }
				break;
			}
			
			//entity is past view, delete it
		    if (_entity.y < -100) { 
		        ds_list_delete(global.entity_list,_ei);
		    }
		}		
	}
	//Game Over
	else if (global.game_mode == game_mode.gameover) {
	    if keyboard_check_pressed(vk_space) {
	        //reset everything
	        ds_list_clear(global.entity_list);
	        global.fox_temp_inv = 0;
	        global.game_mode = game_mode.title;
	        global.points = 0;
	        global.fox_x = 0;
	        global.fox_z = 0;
	        global.fox_frame = 0;
	        global.fox_target_x = 0;
	        global.obj_speed = 1.5;
	        global.speed_change_time = current_time;
	    }
	}
	//Title Screen
	else {
	    if keyboard_check_pressed(vk_space) {
	        global.game_mode = game_mode.playing;
	    }
	}
	
	//Death
    if (global.fox_lives == 0) {
        global.game_mode = game_mode.gameover;
        global.fox_lives = 3;
    }
}

function game_draw() {
		
	//set camera
	global.cam_x = global.fox_x/3;
	camera_set_view_mat(view_camera[0], matrix_build_lookat(global.cam_x,global.cam_y,global.cam_z,global.cam_x,0,20,0,0,-1) );
	camera_set_proj_mat(view_camera[0], matrix_build_projection_perspective_fov(120,9/16,0.1,6000) );
	draw_set_color(c_white);
	gpu_set_cullmode(cull_clockwise);
    
	//draw ground
	transform_add_translation(0,0,-0.1);
	draw_rectangle_colour(1000,-40,-1000,100,$33613d,$33613d,$17b96f,$17b96f,false);
	draw_rectangle_colour(-1000,100,1000,1500,$17b96f,$17b96f,$68fdb8,$68fdb8,false);
	transform_set_identity();

	transform_add_translation(0,0,-0.05);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	draw_rectangle_colour(-200,-40,-20,1500,$6ab45b,c_white,c_white,$6ab45b,false);
	draw_rectangle_colour(-1000,-40,-201,1500,$6ab45b,$6ab45b,$6ab45b,$6ab45b,false);
	draw_rectangle_colour(200,-40,20,1500,c_white,$6ab45b,$6ab45b,c_white,false);
	draw_rectangle_colour(1000,-40,199,1500,$6ab45b,$6ab45b,$6ab45b,$6ab45b,false);
	transform_set_identity();
	gpu_set_blendmode(bm_normal);    

	//draw sky
	transform_add_rotation_x(-90);
	transform_add_translation(0,400,0);
	draw_rectangle_colour(-1000,-32,1000,1800,$eecb81,$eecb81,$a76023,$a76023,false);
	transform_set_identity();

	//draw fox
	transform_add_translation(global.fox_x,0,global.fox_z);
	if (global.fox_temp_inv != 0) { 
	    if (floor(current_time/100) mod 2 == 0) {
			vertex_submit(global.fox_model[global.fox_frame], pr_trianglelist, -1);
	    }
	    else { vertex_submit(global.fox_model[global.fox_frame], pr_trianglelist, global.fox_texture); }
	}
	else { vertex_submit(global.fox_model[global.fox_frame], pr_trianglelist, global.fox_texture); }
	transform_add_scaling(1,1,0);
	vertex_submit(global.fox_model[global.fox_frame], pr_trianglelist, global.fox_shadow_texture);
	transform_set_identity();
	draw_set_alpha(1);
		
	//draw entities
	gpu_set_fog(true,$eecb81,300,400);
	gpu_set_cullmode(cull_noculling);
	for (var _ei = ds_list_size(global.entity_list)-1; _ei >= 0; _ei--) {
		var _entity = global.entity_list[| _ei];
		
		switch (_entity.type) {
			case entity_type.coin:
				draw_set_lighting(true);
			    transform_add_rotation_y(90);
			    transform_add_rotation_z(current_time/10);
			    transform_add_translation(_entity.x,_entity.y,5);
			    vertex_submit(global.coin_model,pr_trianglelist,-1);
			    transform_set_identity();
				draw_set_lighting(false);
			break;
				
			case entity_type.trap:
				transform_add_translation(_entity.x,_entity.y,0);
			    vertex_submit(global.trap_model,pr_trianglelist,global.trap_texture);
				transform_set_identity();
			break;
				
			case entity_type.tree:
				draw_sprite_ext(global.tree_shadow_sprite,0,_entity.x-45,_entity.y-45,0.21,0.21,0,c_black,0.2);

			    //model
			    draw_set_colour(c_white);
				transform_add_translation(_entity.x,_entity.y, _entity.height);
				vertex_submit(global.tree_leaves_model, pr_trianglelist, global.tree_leaves_texture);
				transform_add_translation(0,0,-_entity.height);
				transform_add_scaling(1,1,_entity.height+30);
				vertex_submit(global.tree_trunk_model[_entity.color], pr_trianglelist, -1);
				transform_set_identity();
			break;
		}
	}
	gpu_set_fog(false,$eecb81,200,400);
}

function game_draw_gui() {
	draw_set_alpha(1);
	draw_set_colour(c_white);
		
	switch (global.game_mode) {
		case game_mode.playing: //playing
			for (var l = 0; l < 3; l++) {
		        if (global.fox_lives < (l+1)) { draw_sprite_ext( global.fox_icon_sprite,0,160+l*65,5,1,1,0,c_black,0.4); }
		        else { draw_sprite( global.fox_icon_sprite,0,160+l*65,5); }  
		    }
		    draw_set_halign(fa_left);
		    draw_text_transformed(10,10,string_replace_all(string_format(global.points,6,0)," ","0"),2,2,0);  
		break;
			
		case game_mode.gameover: //gameover
			draw_set_halign(fa_center);
			draw_text_transformed(180,200,"GAMEOVER!",2,2,0); 
			draw_text_transformed(180,300,"You got " + string(global.points) + " points!\nPRESS SPACE\nTO CONTINUE",2,2,0);  
		break;
			
		case game_mode.title: //title screen
			draw_set_halign(fa_center);
			draw_set_colour(c_white);
			draw_text_transformed(180,180,"FOREST FOX",3,3,0); 
			draw_text_transformed(180,280,"PRESS SPACE\nTO START",2,2,0);
		break;
	}
}

function game_loop() {
	
	//logic and main draw event
	if (event_number == ev_draw_end) {
		game_step();
		game_draw();
	}
    
    //GUI draw event
	if (event_number == ev_gui_begin) {
		game_draw_gui();
	}
}