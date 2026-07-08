var _tex = sprite_get_texture(sprite_index, image_index)

ml_shader_set(outShader, {enable:1, size : [texture_get_texel_width(_tex), texture_get_texel_height(_tex)], outcolor : ml_shader_color(c_red)})
draw_self()
shader_reset()