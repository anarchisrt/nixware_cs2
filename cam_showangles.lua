--[[
    @javasense
]]

--region start
local lua = { }
--endregion

--region function
lua.debug_cam_yaw = function ( )
    local me = entitylist.get_local_player_pawn( )
    if not me then return end

    engine.execute_client_cmd('cam_showangles true')
end

lua.debug_yaw_showdown = function ( )
    engine.execute_client_cmd('cam_showangles false')
end
--endregion

--region callbacks
register_callback('paint', lua.debug_cam_yaw)
register_callback('unload', lua.debug_yaw_showdown)
--endregion