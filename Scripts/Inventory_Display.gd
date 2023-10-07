extends Container

# list of TextureRects representing items in inventory in the GUI
var item_texturerects = []

# clears item_texturerects and refills with textures taken from items
func refresh_display(items: Dictionary):
	for i in range(item_texturerects.size() - 1, -1, -1):
		remove_child(item_texturerects[i])
		item_texturerects[i].queue_free()
		item_texturerects.remove_at(i)
	for i in items:
		# if multiple of the same children, just make multiple TextureRects
		# should probably change this later
		for n in items[i]:
			var i_texture = TextureRect.new()
			item_texturerects.append(i_texture)
			i_texture.texture = i.texture
			i_texture.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
			add_child(i_texture)
