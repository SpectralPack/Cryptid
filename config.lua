return {
	["Cryptid"] = {
		["jimball_music"] = true, -- plays funkytown when jimball
		["code_music"] = true, -- plays code music when code pack
		["exotic_music"] = true, -- plays exotic music when exotic joker
		["big_music"] = true, -- plays music when sufficiently high score
		["alt_bg_music"] = true, -- plays alternate title screen music based on gameset
	},
	["family_mode"] = false, -- removes f*ck
	["experimental"] = false, -- experimental stuff
	["force_tooltips"] = true, -- acivates lovely patch to always show the desc
	["HTTPS"] = true, -- your internet connection
	["menu"] = true, -- Restart game and the menu is now blue
}
-- force tooltips:
--[[
# Make description UI always appear if card is highlighted
[[patches]]
--[[
[patches.pattern]
target = "engine/node.lua"
pattern = "if self.children.h_popup then"
position = 'at'
match_indent = true
payload = '''
if self.children.h_popup and not (self.force_popup and self:force_popup() and Cryptid["force_tooltips"]) then
'''
]]
