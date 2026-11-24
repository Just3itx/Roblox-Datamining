-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local Promise = require(InExperienceShopParent.Promise)

local function userOwnsGamePass(gamePassId: number)
    return Promise.new(function(callback, callback2)
        task.spawn(function()
            local localPlayer = Players.LocalPlayer
            if localPlayer == nil then
                callback2("userOwnsGamePass: no LocalPlayer")
                return
            end
            local success, result = pcall(function(): boolean
                return MarketplaceService:UserOwnsGamePassAsync(localPlayer.UserId, gamePassId)
            end)
            if success then
                callback(result == true)
                return
            end
            callback2(tostring(result))
        end)
    end)
end

return userOwnsGamePass
