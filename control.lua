local players = {}

function SetAltModeOn(event)
    game.players[event.player_index].game_view_settings.show_entity_info = true
    players[event.player_index] = true
end

function ForceSetAltModeOn()
    for key in pairs(players) do
        if not game.players[key].game_view_settings.show_entity_info then
            SetAltModeOn {player_index = key}
        end
    end
    script.on_event(defines.events.on_tick, nil)
end

if settings.startup.ixuMatchMapPreset_SetAltModeOn.value then
    script.on_event(defines.events.on_player_joined_game, SetAltModeOn)

    script.on_event(
        defines.events.on_cutscene_waypoint_reached, function(event)
            script.on_event(defines.events.on_tick, ForceSetAltModeOn)
        end
    )
end
