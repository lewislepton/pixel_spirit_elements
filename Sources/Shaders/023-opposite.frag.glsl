#version 450

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
out vec4 fragColor;

float rectSDF(vec2 st, vec2 s){
	st = st * 2.0 - 1.0;
	return max(abs(st.x / s.x), abs(st.y / s.y));
}

float fill(float x, float size){
	return 1.0 - step(size, x);
}

float flip(float v, float pct){
	return mix(v, 1.0 - v, pct);
}

vec2 rotate(vec2 st, float a) {
	st = mat2(cos(a),-sin(a), sin(a),cos(a))*(st-.5);
	return st+.5;
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st.x *= u_resolution.x/u_resolution.y;
  st.y *= u_resolution.y/u_resolution.x;
  vec3 color = vec3(0.);

	st = rotate(st, radians(-45.0));
	vec2 s = vec2(1.);
	float o = 0.05;
	color += flip(fill(rectSDF(st - o, s), 0.4), fill(rectSDF(st + o, s), 0.4));
  
  fragColor = vec4(color, 1.0);
}