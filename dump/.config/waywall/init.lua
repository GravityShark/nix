-- https://github.com/MarwinKreuzig/nixos-config/blob/17864a2c8995f2cb84a2454a27e23f158023ce32/modules/gaming/mcsr/home.nix
local waywall = require('waywall')
local helpers = require('waywall.helpers')

local is_process_running = function(name)
	local handle = io.popen("pgrep -f '" .. name .. "'")
	local result = handle:read('*l')
	handle:close()
	return result ~= nil
end
--
-- -- ################################################################################################
-- -- WAYWALL STARTUP
-- -- ################################################################################################
-- local deco_objects = {
-- 	thin1 = nil,
-- 	thin2 = nil,
-- }

waywall.listen('load', function()
	if not is_process_running('ninjabrainbot') then
		waywall.exec('ninjabrainbot')
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
local counter_src = {
	x = 0,
	y = 37,
	w = 300,
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
			y = (1080 - counter_dst_size.h) / 2,
			w = counter_dst_size.w,
			h = counter_dst_size.h,
		},
		color_key = {
			input = '#dddddd',
			output = '#ffffff',
		},
	}, width, height)
end
--
-- -- ##############################################################################################
-- -- EYE ZOOM
--
local eye = {
	-- sens = 0.74,
	res = {
		w = 300,
		h = 16384,
	},
	proj = {
		x = 0,
		y = 312,
		w = 810,
		h = 456,
	},
	src = {
		w = 60,
		h = 580,
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

helpers.res_image(os.getenv('HOME') .. '/.config/waywall/overlay.png', { dst = eye.proj }, eye.res.w, eye.res.h)

setup_entity_counter(eye.res.w, eye.res.h)

local pie_height = 320
local dst_height = (1080 - counter_dst_size.h) / 2
helpers.res_mirror({
	src = {
		x = 0,
		y = eye.res.h - 420,
		w = eye.res.w,
		h = pie_height,
	},
	dst = {
		x = (1920 + eye.res.w) / 2,
		y = (1080 + counter_dst_size.h) / 2,
		w = (dst_height / pie_height) * eye.res.w,
		h = dst_height,
	},
}, eye.res.w, eye.res.h)
--
-- -- ##############################################################################################
-- -- THIN
--
local thin_res = {
	w = 300,
	h = 1080,
}
setup_entity_counter(thin_res.w, thin_res.h)
--
-- -- ################################################################################################
-- -- CONFIG
-- -- ################################################################################################
--
-- -- ##############################################################################################
-- -- REMAPS
-- -- Remaps are done using the qwerty layout - on both sides!
-- -- If you want to remap the "o" key to the "g" key you need to map "S" to "U"!
-- --
-- -- when in doubt, do this:
-- -- execute sudo showkey
-- -- find keycode in https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h
-- -- (might be in decimal or in hex)
local game_remaps = {
	-- DO NOT REMAP: number row (messes up piechart), any F3 shortcut
	-- use right shift to access pie chart without crouching
	-- ['102ND'] = 'RIGHTSHIFT',
	-- easier F3
	-- ['X'] = 'F3', --  Q -> F3
	-- search crafting
	-- ['MB4'] = 'BackSpace', --  MB4 -> Backspace
	-- ['W'] = 'N', --  , -> B
	-- ['E'] = 'D', --  . -> E
	-- ['D'] = 'K', --  E -> T
	-- ['V'] = 'COMMA', --  K -> W
	-- ['T'] = 'O', --  Y -> R
	-- ['Q'] = 'B', --  ; -> X
	-- ['R'] = 'KP4', --  P -> 4

	--[[

	f
	b
	c
	f4

+4 - stone sword
+5 - iron sword
8 - gold pick
+8 - iron axe
8 - iron pick (pick and iron axe junk)
+8 - stone axe
_a – fns no junk
aw – anchors
ba – iron bars
be – bed no junk
bow – bow (bowl)
br – bread
de – blaze powder + ender eyes
ic – sticks + nether brick
ke – bucket no junk
ne – bricks + glowstone
ngo – gold-iron ingots (boots junk)
oat - boat
pp - golden apple
r_ - nether bricks no junk
ro - any iron
rr – golden carrots no junk
tn - tnt
wo - wool
ws - glowstone


### Alternatives
4 – all swords
ie - shield (no junk)
it – wool no junk
ka - pickaxes
ok - tripwire hook
ow – bed + bow
_r - fishing rod
rs – iron bars
rt – coarse dirt no junk
w_ / be / ow (can be overlapped with backspace) - blaze bed
wn – bed + anchor (less junk)
w – wool + glowstone
x – all axes/pickaxes


	space = open chat
	]]

	--   eye  1    2    3    k    +    4    5
	--   _    8    o    d    r    t    f    _    _    _    _   _
	--   s    e    i    g    n    b    _    _    _    _    _   _
	--   _    a    f3   c    w    _    0    _    _    _   _   _
	--   _    _    spc   @base    _

	['4'] = 'k',
	['5'] = 'KPPLUS',
	['6'] = '4',
	['7'] = '5',

	['q'] = '8',
	['w'] = 'o',
	['e'] = 'd',
	['y'] = 'f',

	['insert'] = 's',
	['a'] = 'e',
	['s'] = 'i',
	['d'] = 'g',
	['f'] = 'n',
	['g'] = 'b',
	['z'] = 'a',
	['x'] = 'f3',
	['v'] = 'w',
	['n'] = '0',
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

-- -- ##############################################################################################
-- -- CONFIG OBJECT
local config = {
	input = {
		-- KEYBOARD CONFIG
		layout = 'us',
		repeat_rate = 20,
		repeat_delay = 167,

		-- https://arjuncgore.github.io/waywall-boat-eye-calc/
		sensitivity = 0.81920004,
		confine_pointer = false,

		remaps = game_remaps,
	},
	theme = {
		-- background = '#1b0e1fff',
		background = '#303030ff',
		ninb_anchor = 'topright',
		ninb_opacity = 0.9,
	},
	actions = {
		['ctrl-shift-n'] = function()
			if chat_state.enabled then
				return false
			end
			if not is_process_running('ninjabrainbot') then
				waywall.exec('ninjabrainbot')
				waywall.show_floating(true)
			else
				helpers.toggle_floating()
			end
			waywall.exec('ninjabrainbot')
			waywall.exec('yo')
		end,
		['return'] = function()
			if chat_state.enabled then
				waywall.press_key('enter')
			else
				waywall.press_key('slash')
				waywall.sleep(50)
				waywall.press_key('backspace')
			end
			toggle_chat()
		end,

		['shift-return'] = function()
			toggle_chat()
		end,

		-- RESOLUTION MACROS
		['b'] = function()
			if chat_state.enabled then
				return false
			end
			(helpers.toggle_res(thin_res.w, thin_res.h))()
		end,
		['h'] = function()
			if chat_state.enabled then
				return false
			end
			(helpers.toggle_res(1920, 300))()
		end,
		['grave'] = function()
			if chat_state.enabled then
				return false
			end
			(helpers.toggle_res(eye.res.w, eye.res.h, eye.sens))()
		end,
	},
}

return config
