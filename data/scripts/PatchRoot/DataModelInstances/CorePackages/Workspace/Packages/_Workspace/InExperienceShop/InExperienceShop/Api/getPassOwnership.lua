-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local _Types = require(InExperienceShop.Types)

return {
    getPassOwnership = function(player: Player, gamePassId: number)
        return Promise.new(function(callback, callback2)
            task.spawn(function()
                local success, result = pcall(function()
                    return MarketplaceService:GetPassOwnershipAsync(player, gamePassId)
                end)
                if not success then
                    callback2(tostring(result))
                    return
                end
                local var1 = typeof(result) == "table"
                    and {
                        Owned = result.Owned == true,
                        Active = result.Active == true,
                        StartTime = result.StartTime,
                        EndTime = result.EndTime
                    }
                    or nil

                callback(var1)
            end)
        end)
    end
}
