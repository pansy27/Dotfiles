local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local common = {}

common.rrect = function(r)
    return function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, r)
    end
end

common.testNotif = function(msg)
    local message
    if msg then
        message = tostring(msg)
    else
        message = "kill yourself :3"
    end
    naughty.notification({
        title = "ahem",
        message = message
    })
end

-- Convert seconds to minutes
-- common.convSec = function(sec)
--     local minutes = math.floor(sec / 60)
--     local seconds = math.floor(sec - minutes * 60)

--     -- TODO: find better fix for this
--     -- ugly fix for single seconds
--     if (seconds <= 9) then
--         seconds = "0" .. seconds
--     end
-- end

common.circle = function()
    return function(cr, w, h)
        gears.shape.circle(cr, w, h)
    end
end

return common
