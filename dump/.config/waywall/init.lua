-- https://github.com/MarwinKreuzig/nixos-config/blob/17864a2c8995f2cb84a2454a27e23f158023ce32/modules/gaming/mcsr/home.nix
-- https://github.com/Esensats/waywork
local waywall = require('waywall')
local helpers = require('waywall.helpers')

local ninb_path = '@ninb_path@'
local eye_overlay = '@eye_overlay@'
local oneshot_overlay = '@oneshot_overlay@'
local ninb_pid = 'ninjabrain.*\\.jar'

local is_running = function(name)
	local handle = io.popen("pgrep -f '" .. name .. "'")
	local result = handle:read('*l')
	handle:close()
	return result ~= nil
end

-- -- ################################################################################################
-- -- WAYWALL STARTUP
-- -- ################################################################################################
-- local deco_objects = {
-- 	thin1 = nil,
-- 	thin2 = nil,
-- }

waywall.listen('load', function()
	if not is_running(ninb_pid) then
		waywall.exec(ninb_path)
	end
	-- deco_objects.thin0 = waywall.image('${../../../assets/mcsr/bg.png}', {
	-- 	dst = { x = 0, y = 0, w = 823, h = 1080 },
	-- 	depth = -1,
	-- })
	-- deco_objects.thin1 = waywall.image('${../../../assets/mcsr/bg.png}', {
	-- 	dst = { x = 1920 - 823, y = 0, w = 823, h = 1080 },
	-- 	depth = -1,
	-- })
	waywall.show_floating(true)
end)
--
-- -- ################################################################################################
-- -- PROJECTOR SETUP
-- -- ################################################################################################
-- -- entity counter location and projection size

local upward_offset = 85 -- 3 items
-- local upward_offset = 92 -- 5 Items

local counter_src = {
	x = 0,
	y = 37,
	w = 50,
	h = 9,
}
local counter_dst_size = {
	w = counter_src.w * (40 / counter_src.h),
	h = 40,
}
local function setup_entity_counter(width, height)
	return helpers.res_mirror({
		src = counter_src,
		dst = {
			x = (1920 + width) / 2,
			y = ((1080 - counter_dst_size.h) / 2) - upward_offset,
			w = counter_dst_size.w,
			h = counter_dst_size.h,
		},
		color_key = {
			input = '#dddddd',
			output = '#ffffff',
		},
	}, width, height)
end

local pie_height = 320
local pie_dst_height = (1080 - counter_dst_size.h) / 2

local function setup_pie_chart(width, height)
	helpers.res_mirror({
		src = {
			x = 0,
			y = height - 420,
			w = width,
			h = pie_height,
		},
		dst = {
			x = (1920 + width) / 2,
			y = ((1080 + counter_dst_size.h) / 2) - upward_offset,
			w = (pie_dst_height / pie_height) * width,
			h = pie_dst_height,
		},
	}, width, height)
end

local pie_count_height = 24 -- 3 items
-- local pie_count_height = 40 -- 5 items
local pie_count_dst_height = (1080 - counter_dst_size.h) / 2
local pie_count_width = 93
-- local pie_count_scale = 0.33 -- 5 items
local pie_count_scale = 0.25 -- 3 items
local pie_count_right_padding = 10
local function setup_pie_chart_count(width, height)
	helpers.res_mirror({
		src = {
			x = width - pie_count_width,
			y = height - 220,
			w = pie_count_width - pie_count_right_padding,
			h = pie_count_height,
		},
		dst = {
			x = (1920 + width) / 2,
			y = ((1080 + counter_dst_size.h) / 2) - upward_offset,
			w = ((pie_count_dst_height / pie_count_height) * (pie_count_width - pie_count_right_padding) * pie_count_scale),
			h = pie_count_dst_height * pie_count_scale,
		},
	}, width, height)
end
--
-- -- ##############################################################################################
-- -- EYE ZOOM
--
local eye = {
	sens = 0.29617377,
	-- Size of the instance
	res = {
		w = 320,
		h = 16384,
	},

	-- The size and location of the projector
	proj = {
		x = 0,
		y = 312,
		w = 800,
		h = 456,
	},

	-- Crop of the projection
	src = {
		w = 60,
		h = 1080,
	},
}
--
helpers.res_mirror({
	dst = eye.proj,
	src = {
		x = (eye.res.w - eye.src.w) / 2,
		y = (eye.res.h - eye.src.h) / 2,
		w = eye.src.w,
		h = eye.src.h,
	},
}, eye.res.w, eye.res.h)

helpers.res_image(eye_overlay, { dst = eye.proj }, eye.res.w, eye.res.h)

-- E counter
setup_entity_counter(eye.res.w, eye.res.h)
-- setup_pie_chart(eye.res.w, eye.res.h)
setup_pie_chart_count(eye.res.w, eye.res.h)

--
-- -- ##############################################################################################
-- -- THIN
--
local thin_res = {
	w = 320,
	h = 1080,
}
setup_entity_counter(thin_res.w, thin_res.h)
setup_pie_chart_count(thin_res.w, thin_res.h)

-- -- when in doubt, do this:
-- -- execute sudo showkey
-- -- find keycode in https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h
-- -- (might be in decimal or in hex)
local game_remaps = {
	--[[
	0    1    2    3    k    +    4    5
	tab  a    o    g    r    t    d    _    _    _    _   _
	c    i    e    s    f    b    eye  _    _    _    _   _
	_    8    f3   n    w    thn  wde  _    _    _   _   _
	_    _    spc   @base     _

	-- fns is a kinda bad search craft with this tbh

	8 = sprint
	tab = crouch
	o = forwrad
	d = left
	i = back
	g = right
	spc = open inv
	]]

	['grave'] = '0',
	['4'] = 'k',
	['5'] = 'KPPLUS',
	['6'] = '4',
	['7'] = '5',

	['q'] = 'a',
	['w'] = 'o',
	['e'] = 'g',
	['y'] = 'd',
	['u'] = 'leftbrace',
	['i'] = 'rightbrace',
	['o'] = 'apostrophe',

	['insert'] = 'c',
	['a'] = 'i',
	['s'] = 'e',
	['d'] = 's',
	['f'] = 'f',
	['g'] = 'b',
	['j'] = 'comma',
	['k'] = 'dot',

	['z'] = '8',
	['x'] = 'f3',
	['c'] = 'n',
	['v'] = 'w',
}
--
-- -- ##############################################################################################
-- -- CHAT MODE
local chat_state = {
	enabled = false,
	text = nil,
}

local toggle_chat = function()
	chat_state.enabled = not chat_state.enabled
	if chat_state.enabled then
		waywall.set_remaps({})
		chat_state.text = waywall.text('CHAT MODE ENABLED', { x = 0, y = 0, color = '#ff0000', size = 10 })
	else
		waywall.set_remaps(game_remaps)
		chat_state.text:close()
		chat_state.text = nil
	end
end

local oneshot_overlay_state = nil
-- -- ##############################################################################################
-- -- CONFIG OBJECT

local config = {
	input = {
		-- KEYBOARD CONFIG
		layout = 'us',
		repeat_rate = 50,
		repeat_delay = 200,

		-- https://arjuncgore.github.io/waywall-boat-eye-calc/
		sensitivity = 4.39040021,
		confine_pointer = false,

		remaps = game_remaps,
	},
	theme = {
		-- background = '#1b0e1fff',
		-- background = '#303030ff',
		background = '#00000000',
		ninb_anchor = 'right',
		ninb_opacity = 0.8,
	},
	actions = {
		['control-space'] = function()
			if chat_state.enabled then
				return false
			end

			if not is_running(ninb_pid) then
				waywall.exec(ninb_path)
				waywall.show_floating(true)
			else
				helpers.toggle_floating()
			end
		end,

		['shift-return'] = function()
			toggle_chat()
		end,

		-- RESOLUTION MACROS
		['*-b'] = function()
			if chat_state.enabled then
				return false
			end
			(helpers.toggle_res(thin_res.w, thin_res.h))()
		end,
		['*-n'] = function()
			if chat_state.enabled then
				return false
			end
			(helpers.toggle_res(1920, 300))()
		end,
		['*-h'] = function()
			if chat_state.enabled then
				return false
			end
			(helpers.toggle_res(eye.res.w, eye.res.h, eye.sens))()
		end,
		['control-h'] = function()
			if not oneshot_overlay_state then
				oneshot_overlay_state = waywall.image(oneshot_overlay, {
					dst = {
						x = 0,
						y = 0,
						w = 1920,
						h = 1080,
					},
				})
			else
				oneshot_overlay_state:close()
				oneshot_overlay_state = nil
			end
		end,
	},
}

return config
