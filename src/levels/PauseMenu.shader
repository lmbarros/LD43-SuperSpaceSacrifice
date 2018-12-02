shader_type canvas_item;
render_mode unshaded;

// Blured and grayed
// This one-line blurring shader idea was stolen from
// https://steincodes.tumblr.com/post/171202672519/the-simplest-blur-shader-godot-30
void fragment()
{
	COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV, 2);
	float c = (COLOR.r + COLOR.g + COLOR.b);
	COLOR.rgb = vec3(c, c, c);
}
