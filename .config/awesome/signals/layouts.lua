local awful = require("awful")

-- Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts({
		awful.layout.suit.floating,
		awful.layout.suit.tile,
		awful.layout.suit.max,
	})
end)
