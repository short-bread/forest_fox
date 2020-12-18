function vertex_normal_texture_colour(_vbuff, _x, _y, _z, _nx, _ny, _nz, _xtex, _ytex, _col, _alpha) {
	vertex_position_3d(_vbuff, _x, _y, _z);
	vertex_normal(_vbuff, _nx, _ny, _nz);
	vertex_colour(_vbuff, _col, _alpha);
	vertex_texcoord(_vbuff, _xtex, _ytex);
}

function transform_set_identity() {
	matrix_set(matrix_world, matrix_build_identity());
}

function transform_add_rotation_x(_angle) {
	var c = dcos(_angle);
	var s = dsin(_angle);

	var mT = matrix_build_identity();
	mT[5] = c;
	mT[6] = -s;
	mT[9] = s;
	mT[10] = c;

	matrix_set( matrix_world, matrix_multiply(matrix_get(matrix_world), mT));
}

function transform_add_rotation_y(_angle) {
	var c = dcos(_angle);
	var s = dsin(_angle);

	var mT = matrix_build_identity();
	mT[0] = c;
	mT[2] = s;
	mT[8] = -s;
	mT[10] = c;

	matrix_set( matrix_world, matrix_multiply(matrix_get(matrix_world), mT));
}

function transform_add_rotation_z(_angle) {
	var c = dcos(_angle);
	var s = dsin(_angle);

	var mT = matrix_build_identity();
	mT[0] = c;
	mT[1] = -s;
	mT[4] = s;
	mT[5] = c;

	matrix_set( matrix_world, matrix_multiply(matrix_get(matrix_world), mT));
}

function transform_add_scaling(_xscale, _yscale, _zscale) {
	var mT = matrix_build_identity();
	mT[0] = _xscale;
	mT[5] = _yscale;
	mT[10] = _zscale;
	
	matrix_set( matrix_world, matrix_multiply(matrix_get(matrix_world), mT));
}

function transform_add_translation(_x, _y, _z) {
	var mT = matrix_build_identity();
	mT[12] = _x;
	mT[13] = _y;
	mT[14] = _z;

	matrix_set( matrix_world, matrix_multiply(matrix_get(matrix_world), mT));
}