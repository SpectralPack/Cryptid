if not SMODS.Attribute then
	return
end

local attributes = {
	"asc_power", --objects related to ascension power mechanics
	"code", --objects related to code cards
	"value_manip", --objects that edit the values of other cards (e.g. oil lamp)
	"forcetrigger", --objects that cause another object to be forcetriggered
	"emult",
	"echips", --self explanatory
	"ccd", --creates ccds in some way
	"banish", --self explanatory
	"sticker",
	"play_limit",
	"discard_limit", --these are because smods doesnt add them for some reason
}
--cba to move everything related to M and meme jokers to use attributes
for _, v in ipairs(attributes) do
	SMODS.Attribute({ key = v })
end

SMODS.Attribute({ --this too is because smods doesnt add it for some reason
	key = "voucher",
	keys = {
		"tag_voucher",
	},
})
