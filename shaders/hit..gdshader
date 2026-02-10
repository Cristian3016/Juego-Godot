shader_type canvas_item;

uniform float time_scale = 20; // Qué tan rápido se anima el parpadeo
uniform float gb_ceil = 0.75; // Máximo valor que pueden alcanzar los colores verde y azul

void vertex() {
	// Se llama para cada vértice donde el material es visible
}
void fragment() {
	// Se llama para cada píxel donde el material es visible
	float time_cycle = sin(TIME * time_scale);
	vec4 tex_color = texture(TEXTURE, UV);

	COLOR = vec4(
		tex_color.r,
		tex_color.g * time_cycle * gb_ceil,
		tex_color.b * time_cycle * gb_ceil,
		tex_color.a
	);
}

//void light() {
//	// Se llama para cada píxel por cada luz que afecta al CanvasItem.
//	// Descomentar para reemplazar la función de iluminación por defecto con esta.
//}

