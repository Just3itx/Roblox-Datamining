-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.new(playing: boolean, reversing: boolean, loading: boolean)
    return { Playing = playing, Reversing = reversing, Loading = loading }
end

return module
