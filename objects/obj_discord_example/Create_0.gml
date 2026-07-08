var _hook = ">insert<"
var _disc = discord_webhook(_hook);
_disc.init_message()
_disc.set_content("hello")
_disc.set_username(game_project_name)
_disc.set_avatar("https://i.pinimg.com/originals/01/3d/4b/013d4b92f2743f7cb24ca63568dcd5fc.png")
_disc.add_embed()
_disc.embed_set_description("sucess")
_disc.embed_set_image("https://i.pinimg.com/originals/01/3d/4b/013d4b92f2743f7cb24ca63568dcd5fc.png")
_disc.send_message()