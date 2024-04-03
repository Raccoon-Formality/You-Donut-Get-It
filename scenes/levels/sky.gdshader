shader_type sky;

uniform sampler2D sky_samp;

void sky() {
	
	COLOR = vec3(texture(sky_samp, EYEDIR.xx).rgb);
	
}
