-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local _Promise = require(InExperienceShopParent.Promise)
local _Types = require(InExperienceShop.Types)
local fetchShopItemIds = require(script.Parent.fetchShopItemIds)
local buildShopDataFromWidgets = require(script.Parent.buildShopDataFromWidgets)

local function fetchShopWidgetsOnly()
    local str1 = HttpService:GenerateGUID(false)
    return fetchShopItemIds(str1):andThen(function(arg1)
        return buildShopDataFromWidgets(arg1, nil)
    end)
end

return fetchShopWidgetsOnly
