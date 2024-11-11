--[[
    @javasense
]]

--region start
local lua = { }
--endregion

--region lua.math
lua.math = { }

lua.math.lerp = function(start, _end, time)
    return (_end - start) * time + start
end

lua.math.alphabet = {
    a = 0,
    b = 0,
    c = 0,
    d = 0,
    e = 0,
    f = 0,
    g = 0,
    h = 0,
    i = 0,
    j = 0,
    k = 0,
    l = 0,
    m = 0,
    n = 0,
    o = 0,
    p = 0,
    q = 0,
    r = 0,
    s = 0,
    t = 0,
    u = 0,
    v = 0,
    w = 0,
    x = 0,
    y = 0,
    z = 0
}
--endregion

--region custom scope
lua.main = { }
lua.main.get = engine.get_netvar_offset('client.dll', 'C_CSPlayerPawn', 'm_bIsScoped')
lua.main.scope = function ( )
    local me = entitylist.get_local_player_pawn( )
    if not me then return end
    local screen = render.screen_size()
    local scoped = ffi.cast('bool*', me[lua.main.get])[0]

    local r, g, b, a = 255, 255, 255, 255
    local position = 60 * screen.y / 1080

    lua.math.alphabet.a = lua.math.lerp(lua.math.alphabet.a, scoped and 1 or 0, render.frame_time() * 6)
    local alpha = lua.math.alphabet.a

    local x = screen.x / 2
    local y = screen.y / 2

    render.rect_filled_fade(vec2_t(x + alpha * position, y), vec2_t(x + alpha * position * 4, y + 1), color_t(r, g, b, alpha * a), color_t(r, g, b, 0),color_t(r, g, b, 0), color_t(r, g, b, alpha * a))
    render.rect_filled_fade(vec2_t(x + alpha * position * 0.5, y), vec2_t(x + alpha * position, y + 1), color_t(r, g, b, 0), color_t(r, g, b, alpha * a),color_t(r, g, b, alpha * a), color_t(r, g, b, 0))
    render.rect_filled_fade(vec2_t(x - alpha * position, y), vec2_t(x - alpha * position * 4, y + 1), color_t(r, g, b, alpha * a), color_t(r, g, b, 0),color_t(r, g, b, 0), color_t(r, g, b, alpha * a))
    render.rect_filled_fade(vec2_t(x - alpha * position * 0.5, y), vec2_t(x - alpha * position, y + 1), color_t(r, g, b, 0), color_t(r, g, b, alpha * a),color_t(r, g, b, alpha * a), color_t(r, g, b, 0))

    render.rect_filled_fade(vec2_t(x, y - alpha * position), vec2_t(x + 1, y - alpha * position * 4), color_t(r, g, b, alpha * a), color_t(r, g, b, 0),color_t(r, g, b, 0), color_t(r, g, b, 0))
    render.rect_filled_fade(vec2_t(x, y - alpha * position * 0.5), vec2_t(x + 1, y - alpha * position), color_t(r, g, b, 0), color_t(r, g, b, 0),color_t(r, g, b, 0), color_t(r, g, b, alpha * a))
    render.rect_filled_fade(vec2_t(x, y + alpha * position), vec2_t(x + 1, y + alpha * position * 4), color_t(r, g, b, alpha * a), color_t(r, g, b, 0),color_t(r, g, b, 0), color_t(r, g, b, 0))
    render.rect_filled_fade(vec2_t(x, y + alpha * position * 0.5), vec2_t(x + 1, y + alpha * position), color_t(r, g, b, 0), color_t(r, g, b, 0),color_t(r, g, b, 0), color_t(r, g, b, alpha * a))
end
--endregion

--region callbacks
register_callback('paint', lua.main.scope)
--endregion