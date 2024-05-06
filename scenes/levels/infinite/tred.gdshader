shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}
uniform sampler2D text : filter_nearest;
void fragment() {
	vec4 textur = texture(text, vec2(UV.x + (TIME / 8.0), UV.y / 2.5) * 2.0);
	ALBEDO = textur.rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
