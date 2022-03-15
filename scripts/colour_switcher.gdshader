shader_type canvas_item;

uniform float R;
uniform float G;
uniform float B;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	vec4 new_colour;
	COLOR = vec4(COLOR.r + R, COLOR.g + G, COLOR.b + B, COLOR.a);
}