shader_type canvas_item;

uniform float R;
uniform float G;
uniform float B;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	vec4 new_colour;
	if(COLOR.r < 0.05){
	}
	else {
		COLOR = vec4(COLOR.r + R, COLOR.g, COLOR.b, COLOR.a);
	}
	
	
	if(COLOR.g < 0.05){
	}
	else {
		COLOR = vec4(COLOR.r, COLOR.g + G, COLOR.b, COLOR.a);
	}
	
	if(COLOR.b < 0.05){
	}
	else {
		COLOR = vec4(COLOR.r, COLOR.g, COLOR.b + B, COLOR.a);
	}
}