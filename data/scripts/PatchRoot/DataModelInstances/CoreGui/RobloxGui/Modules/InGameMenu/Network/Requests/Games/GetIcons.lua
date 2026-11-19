-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:41:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Url = require(scriptParentParentParentParent.Network.Url)

return function(arg1, arg2)
    return arg1(string.format("%sv1/games/%d/icon", Url.GAME_URL, arg2), "GET")
end
