// UGH, SHADERS ARE SHIT

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float amount; // From 0.0 to 1.0 (all white)

void main()
{
	vec4 base_col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor = vec4(base_col.rgb + amount, base_col.a);
}

// SHADERS ARE KEY