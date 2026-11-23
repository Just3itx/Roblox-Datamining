-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local playtestTeleportRemote = require(script.Parent.playtestTeleportRemote)

local var1 = nil

local function getRemote() -- Luacid: Inlined by compiler; 1 call site recovered
    if var1 ~= nil then
        return var1
    end

    local var2 = RobloxReplicatedStorage:WaitForChild(playtestTeleportRemote.REMOTE_NAME, math.huge)
    var1 = var2
    return var2
end

local function teleportToPlace(num1: number)
    getRemote():FireServer(num1)
end

return teleportToPlace
