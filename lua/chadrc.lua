-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "everforest_light",

	hl_override = {
		-- flex-light: 기본 TelescopeSelection 음영(#f2efe4)이 배경(#FFFCF0)과
		-- 거의 같아서 find 선택줄이 안 보임 → 대비 있는 색으로 덮어씀
		TelescopeSelection = { bg = "#d6d4ca" },
	},

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- <A-i> 로 뜨는 floating terminal 크기.
-- width/height 는 에디터 전체 대비 비율. row/col 은 좌상단 시작 위치라
-- 가운데 정렬하려면 col = (1-width)/2, row = (1-height)/2 로 맞춰야 한다.
-- 기본값: width=0.5, height=0.4, col=0.25, row=0.3
M.term = {
	float = {
		relative = "editor",
		width = 0.8,
		height = 0.75,
		col = 0.1, -- (1 - 0.8) / 2
		row = 0.125, -- (1 - 0.75) / 2
		border = "single",
	},
}

-- 가로/세로 split terminal (<leader>h, <leader>v) 크기 비율
-- M.term.sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 }

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

return M
