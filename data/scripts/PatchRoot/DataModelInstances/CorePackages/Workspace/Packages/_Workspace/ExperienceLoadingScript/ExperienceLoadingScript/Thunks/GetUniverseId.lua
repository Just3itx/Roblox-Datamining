-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceLoadingScript = script:FindFirstAncestor("ExperienceLoadingScript")
local ExperienceLoadingScriptParent = ExperienceLoadingScript.Parent
local SetUniverseId = require(ExperienceLoadingScript.Actions.SetUniverseId)
local Url = require(ExperienceLoadingScriptParent.Http).Url

return function(arg1, placeId)
    local function func1(arg2)
        local placeId2 = game.PlaceId
        local gameId = game.GameId
        while placeId2 <= 0 or gameId <= 0 do
            wait()
            placeId2 = game.PlaceId
            gameId = game.GameId
        end
        arg2:dispatch(SetUniverseId({ universeId = gameId, placeId = placeId2 }))
    end

    return function(arg2)
        coroutine.wrap(function()
            local var1 = placeId
            local gameId = game.GameId
            if not (var1 > 0) or not (gameId <= 0) then
                func1(arg2)
                return
            end

            local str1 = string.format("%suniverses/v1/places/%d/universe", Url.APIS_URL, var1)
            arg1(str1, "GET"):andThen(function(arg3)
                if arg3 and arg3.responseBody then
                    gameId = arg3.responseBody.universeId
                    if gameId and gameId >= 0 then
                        arg2:dispatch(SetUniverseId({ universeId = gameId, placeId = var1 }))

                        return
                    end
                end

                func1(arg2)
            end, function(_)
                func1(arg2)
            end)
        end)()
    end
end
