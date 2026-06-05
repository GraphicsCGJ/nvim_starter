-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "flexoki-light",

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

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

return M
