-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRoduxParent = script:FindFirstAncestor("GameDetailRodux").Parent

local Promise = require(GameDetailRoduxParent.Promise)
local Url = require(GameDetailRoduxParent.Http).Url

local tbl1 = ({})

return function(arg1, arg2)
    if tbl1[arg2] then
        return tbl1[arg2]
    end

    local str1 = string.format("%sv1/games?universeIds=%s", Url.GAME_URL, tostring(arg2))
    tbl1[arg2] = arg1(str1, "GET"):andThen(function(arg3)
        if not (arg3.responseBody and arg3.responseBody.data) then
            Promise.reject("Unexpected response when fetching game name")
        end

        local var1 = arg3.responseBody.data[1]
        if not (var1 and var1.name) then
            Promise.reject("Unexpected response when fetching game name, no game info")
        end
        return Promise.resolve({ Name = var1.name, Description = var1.description or "", Created = var1.created })
    end, function(arg3)
        return Promise.reject(arg3)
    end)

    return tbl1[arg2]
end
