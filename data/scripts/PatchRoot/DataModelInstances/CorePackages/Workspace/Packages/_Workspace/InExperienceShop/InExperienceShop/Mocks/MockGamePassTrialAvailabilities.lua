-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local _Types = require(InExperienceShop.Types)

local tbl1 = {}
local tbl2 = {}
local tbl3 = {}

return {
    fetchGamePassTrialAvailabilities = function(_: number)
        local tbl4 = {
            available = {},
            active = {},
            redeemed = {}
        }

        for _, value in tbl1 do
            tbl4.available[value] = true
        end
        for _, value in tbl2 do
            tbl4.active[value] = true
        end
        for _, value in tbl3 do
            local redeemed = tbl4.redeemed
            local gamePassId = value.gamePassId
            redeemed[gamePassId] = {
                gamePassId = value.gamePassId,
                endTime = value.endTime
            }
        end
        return Promise.resolve(tbl4)
    end
}
