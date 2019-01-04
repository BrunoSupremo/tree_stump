local StumpComponent = class()

function StumpComponent:activate()
	for _, maybe_stump in ipairs(radiant.util.split_string(self._entity:get_uri(), ":")) do
		if maybe_stump=="stump" then
			--entity is a stump, so do not run the component on him
			return
		end
	end
	self._stump_data = radiant.entities.get_entity_data(self._entity, 'stonehearth:stump_data')
	if self._stump_data then
		self._on_harvest_listener = radiant.events.listen(self._entity, 'stonehearth:kill_event', function()
			self:add_stump()
			self._on_harvest_listener = nil
			end)
	end
end

function StumpComponent:destroy()
	if self._on_harvest_listener then
		self._on_harvest_listener:destroy()
		self._on_harvest_listener = nil
	end
end

function StumpComponent:add_stump()
	local location = radiant.entities.get_world_grid_location(self._entity)
	if not location then
		return
	end
	
	if not self._stump_data.stump_alias then
		return
	end
	local the_stump = radiant.entities.create_entity(self._stump_data.stump_alias, {})
	if not the_stump then
		return
	end
	radiant.terrain.place_entity_at_exact_location(the_stump, location)

	local rotation = self._entity:get_component('mob'):get_facing()
	radiant.entities.turn_to(the_stump, rotation)

	the_stump:remove_component("tree_stump:add_stump")
end

return StumpComponent