-- https://github.com/MarwinKreuzig/nixos-config/blob/17864a2c8995f2cb84a2454a27e23f158023ce32/modules/gaming/mcsr/home.nix
-- https://github.com/Esensats/waywork
local waywall = require('waywall')
local helpers = require('waywall.helpers')

-- https://whvn.cc/o5ky29
local background = '@background@'
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

waywall.listen('load', function()
	waywall.image(background, {
		dst = { x = 0, y = 0, w = 1920, h = 1080 },
		depth = -1,
	})
end)

-- -- ################################################################################################
-- -- PROJECTOR SETUP
-- -- ################################################################################################

local function setup_entity_counter(width, height)
	local e_count_src = {
		x = 14,
		y = 38,
		w = 35,
		h = 7,
	}
	local e_count_scale = 5.5
	local e_counter_dst = {
		w = e_count_src.w * e_count_scale,
		h = e_count_src.h * e_count_scale,
	}
	return helpers.res_mirror({
		src = e_count_src,
		dst = {
			x = (1920 - e_counter_dst.w) / 2,
			y = 1080 / 6,
			w = e_counter_dst.w,
			h = e_counter_dst.h,
		},
	}, width, height)
end

local function setup_preemptive_count(width, height)
	local preemptive_height = 24 -- 3 items
	local preemptive_width = 26
	local preemptive_right_padding = 92 - preemptive_width

	local preemptive_scale = 5.5
	local preemptive_dst_height = preemptive_height * preemptive_scale
	local preemptive_dst_width = preemptive_width * preemptive_scale
	helpers.res_mirror({
		src = {
			x = width - (preemptive_width + preemptive_right_padding),
			y = height - 220,
			w = preemptive_width,
			h = preemptive_height,
		},
		dst = {
			x = (1920 - preemptive_dst_width) / 2,
			y = 1080 * 4 / 5,
			w = preemptive_dst_width,
			h = preemptive_dst_height,
		},
	}, width, height)
end

-- -- ##############################################################################################
-- -- REGULAR RESOLUTION PIE MIRROR
-- -- ##############################################################################################

local pie_height = 40 -- 5 items
local pie_scale = 2.5
local pie_width = 26

local pie_right_padding = 92 - pie_width
local pie_dst_height = pie_height * pie_scale
local pie_dst_width = pie_width * pie_scale

local num_width = 80

local num_right_padding = 330 - num_width
local num_dst_width = num_width * pie_scale

-- TODO: Find a way to figure out if its ingame and then apply res_mirror
helpers.res_mirror({
	src = {
		x = 1920 - (pie_width + pie_right_padding),
		y = 1080 - 220,
		w = pie_width,
		h = pie_height,
	},
	dst = {
		x = 1920 - pie_dst_width,
		y = 1080 - pie_dst_height,
		w = pie_dst_width,
		h = pie_dst_height,
	},
}, 0, 0)

helpers.res_mirror({
	src = {
		x = 1920 - (num_width + num_right_padding),
		y = 1080 - 220,
		w = num_width,
		h = pie_height,
	},
	dst = {
		x = 1920 - (num_dst_width + pie_dst_width),
		y = 1080 - pie_dst_height,
		w = num_dst_width,
		h = pie_dst_height,
	},
}, 0, 0)

-- -- ##############################################################################################
-- -- THIN
-- -- ##############################################################################################
local thin_res = {
	w = 320,
	h = 1080,
}
setup_entity_counter(thin_res.w, thin_res.h)
setup_preemptive_count(thin_res.w, thin_res.h)

-- -- ##############################################################################################
-- -- EYE ZOOM
-- -- ##############################################################################################
local eye = {
	sens = 0.20778952,
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
setup_entity_counter(eye.res.w, eye.res.h)
setup_preemptive_count(eye.res.w, eye.res.h)

-- -- ##############################################################################################
-- -- REMAPS
-- -- ##############################################################################################
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
	-- ['u'] = 'leftbrace',
	-- ['i'] = 'rightbrace',
	-- ['o'] = 'apostrophe',

	['insert'] = 'c',
	['a'] = 'i',
	['s'] = 'e',
	['d'] = 's',
	['f'] = 'f',
	['g'] = 'b',
	-- ['j'] = 'comma',
	-- ['k'] = 'dot',

	['z'] = '8',
	['x'] = 'f3',
	['c'] = 'n',
	['v'] = 'w',

	['LEFTMETA'] = 'LEFTALT',
}

-- -- ##############################################################################################
-- -- CHAT MODE
-- -- ##############################################################################################
local chat_state = {
	enabled = false,
	text = nil,
}

local toggle_chat = function()
	chat_state.enabled = not chat_state.enabled
	if chat_state.enabled then
		waywall.set_remaps({})
		chat_state.text = waywall.text('CHAT MODE ENABLED', { x = 0, y = 0, color = '#ff0000', size = 6 })
	else
		waywall.set_remaps(game_remaps)
		chat_state.text:close()
		chat_state.text = nil
	end
end

-- -- ##############################################################################################
-- -- CONFIG OBJECT
-- -- ##############################################################################################

local oneshot_overlay_state = nil
local oneshot_toggle = function()
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
end

local config = {
	input = {
		-- KEYBOARD CONFIG
		layout = 'us',
		repeat_rate = 150,
		repeat_delay = 200,

		-- https://arjuncgore.github.io/waywall-boat-eye-calc/
		sensitivity = 3.0802158,
		confine_pointer = false,

		remaps = game_remaps,
	},
	theme = {
		background = '#241f31',
		ninb_anchor = 'right',
		ninb_opacity = 0.8,
	},
	actions = {
		-- NBB
		['alt-insert'] = function()
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

		-- Chat Mode Toggle
		['shift-return'] = function()
			toggle_chat()
		end,

		-- One Shot Overlay Toggle
		['control-h'] = function()
			oneshot_toggle()
		end,

		-- RESOLUTION MACROS
		['*-b'] = function()
			if chat_state.enabled then
				return false
			end
			helpers.toggle_res(thin_res.w, thin_res.h)()
		end,
		['*-n'] = function()
			if chat_state.enabled then
				return false
			end
			helpers.toggle_res(1920, 300)()
		end,
		['*-h'] = function()
			if chat_state.enabled then
				return false
			end
			helpers.toggle_res(eye.res.w, eye.res.h, eye.sens)()
		end,
	},
	experimental = { tearing = true },
}

return config
