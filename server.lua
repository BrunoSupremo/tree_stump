tree_stump = {}
print("Tree Stump Mod version 19.3.17")

function tree_stump:_on_required_loaded()
	local ace_add_stump = radiant.mods.require('stonehearth_ace.components.stump.stump_component')
	if ace_add_stump then
		ace_add_stump.add_stump = function() return end
	end
end

radiant.events.listen_once(radiant, 'radiant:required_loaded', tree_stump, tree_stump._on_required_loaded)

return tree_stump