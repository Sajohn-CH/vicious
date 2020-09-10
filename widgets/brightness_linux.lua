-- template for asynchronous widet types
-- Copyright (C) 2019  Nguyễn Gia Phong <vn.mcsinyx@gmail.com>
--
-- This file is part of Vicious.
--
-- Vicious is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as
-- published by the Free Software Foundation, either version 2 of the
-- License, or (at your option) any later version.
--
-- Vicious is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with Vicious.  If not, see <https://www.gnu.org/licenses/>.

local helpers = require("vicious.helpers")
local spawn = require("vicious.spawn")
local gears = require("gears")

local brightness_linux = {}

function brightness_linux.async(format, warg, callback)
    local cmd = "brightnessctl -m"

    local function parse(response)
    	-- extract percentage which incldues '%' at the end
		response = gears.string.split(response, ',')[4]
		-- remove '%' at the end
		response = response:sub(1, response:len()-1)
		return {response}
    end

    spawn.easy_async(cmd, function(stdout) callback(parse(stdout)) end)
end

return helpers.setasyncall(brightness_linux)
