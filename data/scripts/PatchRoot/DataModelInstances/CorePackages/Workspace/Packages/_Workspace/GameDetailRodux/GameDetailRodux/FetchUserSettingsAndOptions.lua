-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRodux = script:FindFirstAncestor("GameDetailRodux")
local GetUserSettingsAndOptions = require(GameDetailRodux.GameDetails.GetUserSettingsAndOptions)

local GameDetailRoduxParent = GameDetailRodux.Parent
local Promise = require(GameDetailRoduxParent.Promise)

return function(arg1)
    return GetUserSettingsAndOptions(arg1):andThen(function(arg2)
        local responseBody = arg2.responseBody

        if not responseBody then
            Promise.reject("Unexpected response when fetching user settings and options")
        end

        return Promise.resolve(responseBody)
    end, function(arg2)
        return Promise.reject(arg2)
    end)
end
