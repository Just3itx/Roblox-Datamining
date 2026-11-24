-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRodux = script:FindFirstAncestor("GameDetailRodux")
local GameDetailRoduxParent = GameDetailRodux.Parent

local Immutable = require(GameDetailRoduxParent.AppCommonLib).Immutable
local AddGameDetails = require(GameDetailRodux.GameDetails.AddGameDetails)
local SetGameDetailError = require(GameDetailRodux.GameDetails.SetGameDetailError)

return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type == SetGameDetailError.name then
        return (Immutable.Set(arg1, arg2.universeId, { errorType = arg2.errorType }))
    end
    if arg2.type == AddGameDetails.name then
        if not next(arg1) then
            return arg1
        end
        for k, _ in pairs(arg2.gameDetails) do
            if arg1[k] then
                arg1 = Immutable.RemoveFromDictionary(arg1, k)
            end
        end
    end

    return arg1
end
