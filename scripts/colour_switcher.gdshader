shader_type canvas_item;

uniform float R;
uniform float G;
uniform float B;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	vec4 new_colour;
	if(COLOR.r < 0.15){
		COLOR = vec4(COLOR.r + R/4.0, COLOR.g, COLOR.b, COLOR.a);
	}
	else if(COLOR.r < 0.22){
		COLOR = vec4(COLOR.r + R/3.2, COLOR.g, COLOR.b, COLOR.a);
	}
	else if(COLOR.r < 0.30){
		COLOR = vec4(COLOR.r + R/2.5, COLOR.g, COLOR.b, COLOR.a);
	}
	else if(COLOR.r < 0.37){
		COLOR = vec4(COLOR.r + R/2.2, COLOR.g, COLOR.b, COLOR.a);
	}
	else if(COLOR.r < 0.45){
		COLOR = vec4(COLOR.r + R/2.0, COLOR.g, COLOR.b, COLOR.a);
	}
	else if(COLOR.r < 0.6){
		COLOR = vec4(COLOR.r + R/1.5, COLOR.g, COLOR.b, COLOR.a);
	}
	else {
		COLOR = vec4(COLOR.r + R, COLOR.g, COLOR.b, COLOR.a);
	}
	
	
	if(COLOR.g < 0.15){
		COLOR = vec4(COLOR.r, COLOR.g + G / 4.0, COLOR.b, COLOR.a);
	}
	else if(COLOR.g < 0.22){
		COLOR = vec4(COLOR.r, COLOR.g + G / 3.2, COLOR.b, COLOR.a);
	}
	else if(COLOR.g < 0.30){
		COLOR = vec4(COLOR.r, COLOR.g + G / 2.5, COLOR.b, COLOR.a);
	}
	else if(COLOR.b < 0.37){
		COLOR = vec4(COLOR.r, COLOR.g + G / 2.2, COLOR.b, COLOR.a);
	}
	else if(COLOR.g < 0.45){
		COLOR = vec4(COLOR.r, COLOR.g + G / 2.0, COLOR.b, COLOR.a);
	}
	else if(COLOR.g < 0.6){
		COLOR = vec4(COLOR.r, COLOR.g + G / 1.5, COLOR.b, COLOR.a);
	}
	else {
		COLOR = vec4(COLOR.r, COLOR.g + G, COLOR.b, COLOR.a);
	}
	
	if(COLOR.b < 0.15){
		COLOR = vec4(COLOR.r, COLOR.g, COLOR.b + B / 4.0, COLOR.a);
	}
	else if(COLOR.b < 0.22){
		COLOR = vec4(COLOR.r, COLOR.g, COLOR.b + B / 3.2, COLOR.a);
	}
	else if(COLOR.b < 0.30){
		COLOR = vec4(COLOR.r, COLOR.g, COLOR.b + B / 2.5, COLOR.a);
	}
	else if(COLOR.b < 0.37){
		COLOR = vec4(COLOR.r, COLOR.g, COLOR.b + B / 2.2, COLOR.a);
	}
	else if(COLOR.b < 0.45){
		COLOR = vec4(COLOR.r, COLOR.g, COLOR.b + B / 2.0, COLOR.a);
	}
	else if(COLOR.b < 0.6){
		COLOR = vec4(COLOR.r, COLOR.g, COLOR.b + B / 1.5, COLOR.a);
	}
	else {
		COLOR = vec4(COLOR.r, COLOR.g, COLOR.b + B, COLOR.a);
	}
}