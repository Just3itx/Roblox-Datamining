-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local throttleUserId = require(script.Parent.throttleUserId)

return function(func1: (...any) -> (...any))
    return function()
        local localPlayer = dependencies.Players.LocalPlayer
        if not (localPlayer and localPlayer.UserId) then
            return false
        end
        return throttleUserId({ throttle = func1(), userId = localPlayer.UserId })
    end
end
