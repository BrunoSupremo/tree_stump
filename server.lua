tree_stump = {}

function tree_stump:_on_required_loaded()
	local ace_add_stump = radiant.mods.require('stonehearth_ace.components.tree_stump.add_stump')
	ace_add_stump.add_stump = function() return end
end

radiant.events.listen_once(radiant, 'radiant:required_loaded', tree_stump, tree_stump._on_required_loaded)

return tree_stump