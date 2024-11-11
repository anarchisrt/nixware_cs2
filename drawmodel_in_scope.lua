--[[
    @javasense
]]

--region start
local lua = { }
--endregion

--region function
lua.scope_get = engine.get_netvar_offset('client.dll', 'C_CSPlayerPawn', 'm_bIsScoped')
lua.scope_disabler = function ( )
    local me = entitylist.get_local_player_pawn( )
    if not me then return end
    local scoped = ffi.cast('bool*', me[lua.scope_get])[0]

    if scoped then
        engine.execute_client_cmd('r_drawviewmodel false')
    else
        engine.execute_client_cmd('r_drawviewmodel true')
    end
end

lua.scope_showdown = function ( )
    engine.execute_client_cmd('r_drawviewmodel true')
end
--endregion

--region callbacks
register_callback('paint', lua.scope_disabler)
register_callback('unload', lua.scope_showdown)
--endregion