ml_start()

hl_view("ML - OPTIONS", 0.4, 0.15, 0.5, 0.5);
hl_section("Bug",0);
hl_checkbox("window", hl_ref_create(global.ml_ds.handleC, "enable"));
hl_section("Hud",0);
hl_checkbox("surface", hl_ref_create(global.ml_ds.hud, "surface"));
hl_section("object", 0);
hl_text_input("x",hl_ref_create(self, "x"), "r");
//hl_text("FUNÇÕES : SHOW_DEBUG_MESSAGE('OI')\nEAI MEU NEGO")


outShader = ml_shader_create(ml_file_read("shaders/outline.esc"))