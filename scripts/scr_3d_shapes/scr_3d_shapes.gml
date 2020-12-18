function build_cylinder(__x1, __y1, __z1, __x2, __y2, __z2, __tex, __hrepeat, __vrepeat, __closed, __steps, __vbuff) {

	__steps = clamp(__steps,3,128);

	// Create sin and cos tables
	var __cc = [];
	var __ss = [];

	__cc[__steps] = 0;
	__ss[__steps] = 0;

	var __i;
	for(__i = 0; __i <= __steps; __i++)	{
		var __rad = (__i * 2.0 * pi) / __steps;
		__cc[__i] = cos(__rad);
		__ss[__i] = sin(__rad);
	}

	var __mx = (__x2 + __x1) / 2;
	var __my = (__y2 + __y1) / 2;
	var __rx = (__x2 - __x1) / 2;
	var __ry = (__y2 - __y1) / 2;

	var __oldrep = gpu_get_texrepeat();
	gpu_set_texrepeat(true);
	
	var _col = draw_get_color();
	var _alpha = draw_get_alpha();

	if (__closed == true) {			
		
		for(__i = 0; __i < __steps; __i++)	{
			vertex_normal_texture_colour(__vbuff, __mx, __my, __z2, 0, 0, 1, 0, __vrepeat, _col, _alpha);
			vertex_normal_texture_colour(__vbuff, __mx+__cc[__i]*__rx, __my+__ss[__i]*__ry, __z2, 0, 0, 1, 0, __vrepeat, _col, _alpha);		
			vertex_normal_texture_colour(__vbuff, __mx+__cc[__i+1]*__rx, __my+__ss[__i+1]*__ry, __z2, 0, 0, 1, 0, __vrepeat, _col, _alpha);		
		}
	}

	for(__i = 0; __i < __steps; __i++)	{
		vertex_normal_texture_colour(__vbuff, __mx + __cc[__i]*__rx, __my + __ss[__i]*__ry, __z2, __cc[__i] , __ss[__i] ,0 , __hrepeat * __i / __steps, __vrepeat, _col, _alpha);
		vertex_normal_texture_colour(__vbuff, __mx + __cc[__i]*__rx, __my + __ss[__i]*__ry, __z1, __cc[__i] , __ss[__i] ,0 , __hrepeat * __i / __steps, 0, _col, _alpha);
		vertex_normal_texture_colour(__vbuff, __mx + __cc[__i+1]*__rx, __my + __ss[__i+1]*__ry, __z2, __cc[__i+1] , __ss[__i+1] ,0 , __hrepeat * (__i+1) / __steps, __vrepeat, _col, _alpha);
		
		vertex_normal_texture_colour(__vbuff, __mx + __cc[__i]*__rx, __my + __ss[__i]*__ry, __z1, __cc[__i] , __ss[__i] ,0 , __hrepeat * __i / __steps, 0, _col, _alpha);
		vertex_normal_texture_colour(__vbuff, __mx + __cc[__i+1]*__rx, __my + __ss[__i+1]*__ry, __z2, __cc[__i+1] , __ss[__i+1] ,0 , __hrepeat * (__i+1) / __steps, __vrepeat, _col, _alpha);
		vertex_normal_texture_colour(__vbuff, __mx + __cc[__i+1]*__rx, __my + __ss[__i+1]*__ry, __z1, __cc[__i+1] , __ss[__i+1] ,0 , __hrepeat * (__i+1) / __steps, 0, _col, _alpha);
	}

	if (__closed == true) {
		
		for(__i = __steps-1; __i >= 0; __i--)	{
			vertex_normal_texture_colour(__vbuff, __mx, __my, __z1, 0, 0, -1, 0, 0, _col, _alpha);
			vertex_normal_texture_colour(__vbuff, __mx+__cc[__i]*__rx, __my+__ss[__i]*__ry, __z1, 0, 0, -1, 0, 0, _col, _alpha);	
			vertex_normal_texture_colour(__vbuff, __mx+__cc[__i+1]*__rx, __my+__ss[__i+1]*__ry, __z1, 0, 0, -1, 0, 0, _col, _alpha);
		}
	}

	gpu_set_texrepeat(__oldrep);
}


function draw_cone(__x1, __y1, __z1, __x2, __y2, __z2, __tex, __hrepeat, __vrepeat, __closed, __steps) {
	var __vbuff = vertex_create_buffer();
	
	vertex_begin(__vbuff, global.v_format);
	
	build_cone(__x1, __y1, __z1, __x2, __y2, __z2, __tex, __hrepeat, __vrepeat, __closed, __steps, __vbuff);
	
	vertex_end(__vbuff);
	vertex_submit(__vbuff, pr_trianglelist, __tex);
	vertex_delete_buffer(__vbuff);
}

function build_cone(__x1, __y1, __z1, __x2, __y2, __z2, __tex, __hrepeat, __vrepeat, __closed, __steps, __vbuff) {

	__steps = clamp(__steps,3,128);

	// Create sin and cos tables
	var __cc = [];
	var __ss = [];

	__cc[__steps] = 0;
	__ss[__steps] = 0;

	var __i;
	for(__i = 0; __i <= __steps; __i++)	{
		var __rad = (__i * 2.0 * pi) / __steps;
		__cc[__i] = cos(__rad);
		__ss[__i] = sin(__rad);
	}

	var __mx = (__x2 + __x1) / 2;
	var __my = (__y2 + __y1) / 2;
	var __rx = (__x2 - __x1) / 2;
	var __ry = (__y2 - __y1) / 2;
	
	var _col = draw_get_color();
	var _alpha = draw_get_alpha();


	for(__i = 0; __i < __steps; __i++)	{
		//top point
		vertex_normal_texture_colour(__vbuff, __mx, __my, __z2, 0, 0, 1, __hrepeat * __i / __steps, __vrepeat, _col, _alpha);
		
		//bottom points
		vertex_normal_texture_colour(__vbuff, __mx + __cc[__i]*__rx, __my + __ss[__i]*__ry, __z1, __cc[__i] , __ss[__i] ,0 , __hrepeat * __i / __steps, 0, _col, _alpha);
		vertex_normal_texture_colour(__vbuff, __mx + __cc[__i+1]*__rx, __my + __ss[__i+1]*__ry, __z1, __cc[__i+1] , __ss[__i+1] ,0 , __hrepeat * (__i+1) / __steps, 0, _col, _alpha);
	}
	
	/*d3d_model_primitive_end(__ind);

	if (__closed == true)
	{
		d3d_model_primitive_begin(__ind, pr_trianglefan);
		d3d_model_vertex_normal_texture(__ind, __mx, __my, __z1, 0, 0, -1, 0, 0);
		for(__i = __steps; __i >= 0; __i--)
		{
			d3d_model_vertex_normal_texture(__ind, __mx+__cc[__i]*__rx, __my+__ss[__i]*__ry, __z1, 0, 0, -1, 0, 0);		
		}
		d3d_model_primitive_end(__ind);
	}*/
}