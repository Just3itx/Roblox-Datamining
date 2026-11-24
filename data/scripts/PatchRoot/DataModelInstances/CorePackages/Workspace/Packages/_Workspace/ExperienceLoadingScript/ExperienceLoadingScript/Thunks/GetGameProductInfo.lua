-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")

local ExperienceLoadingScript = script:FindFirstAncestor("ExperienceLoadingScript")
local SetGameProductInfo = require(ExperienceLoadingScript.Actions.SetGameProductInfo)

return function(arg1)
    return function(arg2)
        coroutine.wrap(function()
            local assetId = arg1
            if not assetId or assetId <= 0 then
                while game.PlaceId <= 0 do
                    wait()
                end
                assetId = game.PlaceId
            end
            local success, getGameProductInfo = pcall(function()
                local productInfoAsync = MarketplaceService:GetProductInfoAsync(assetId)
                arg2:dispatch(SetGameProductInfo(productInfoAsync))
            end)
            if not success then
                print("LoadingScreen:GetGameProductInfo: %s", getGameProductInfo)
            end
        end)()
    end
end
