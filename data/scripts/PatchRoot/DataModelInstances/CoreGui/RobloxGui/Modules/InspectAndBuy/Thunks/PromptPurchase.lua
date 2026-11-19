-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Analytics = require(scriptParentParent.Services.Analytics)
local Constants = require(scriptParentParent.Constants)
local SetItemBeingPurchased = require(scriptParentParent.Actions.SetItemBeingPurchased)

local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local ReportPurchaseAttemptUnifiedEvent = require(scriptParentParent.Thunks.ReportPurchaseAttemptUnifiedEvent)

local FFlagAXIaBSinglePurchaseUnifiedEvents = require(scriptParentParent.Flags.FFlagAXIaBSinglePurchaseUnifiedEvents)
local bool1 = game:DefineFastFlag("FixInspectAndBuyThirdPartySales", false)

local tbl1 = { Analytics }

local function PromptPurchase(num1: number, arg1, collectibleItemId: string, collectibleProductId: string, collectibleItemInstanceId: string, expectedPrice: number, arg2)
    return Thunk.new(script.Name, tbl1, function(arg3, arg4)
        local var1 = arg4[Analytics]
        local bool2 = not (collectibleProductId == nil) and arg1 ~= Constants.ItemType.Bundle
        local var2 = if FFlagAXIaBSinglePurchaseUnifiedEvents and bool2 then expectedPrice else nil
        arg3:dispatch(SetItemBeingPurchased(num1, arg1, var2))

        if bool2 then
            MarketplaceService:PromptCollectiblesPurchase(
                Players.LocalPlayer,
                num1,
                collectibleItemId,
                collectibleItemInstanceId,
                collectibleProductId,
                expectedPrice
            )
            arg3:dispatch(SendCounter(Constants.Counters.PromptLimitedCollectiblesPurchase))
        elseif arg1 == Constants.ItemType.Bundle then
            MarketplaceService:PromptBundlePurchase(Players.LocalPlayer, num1)
            arg3:dispatch(SendCounter(Constants.Counters.PromptBundlePurchase))
        elseif arg1 ~= Constants.ItemType.Asset then
            arg3:dispatch(SendCounter(Constants.Counters.PromptPurchaseUnknownItemType))
        elseif not bool1 and collectibleItemId ~= nil and not arg2 then
            MarketplaceService:PromptPurchase(Players.LocalPlayer, num1, false)
            arg3:dispatch(SendCounter(Constants.Counters.PromptUnlimitedCollectiblePurchase))
        else
            MarketplaceService:PromptRobloxPurchase(num1, false)
            arg3:dispatch(SendCounter(Constants.Counters.PromptRobloxPurchase))
        end

        if FFlagAXIaBSinglePurchaseUnifiedEvents then
            arg3:dispatch(ReportPurchaseAttemptUnifiedEvent(num1, arg1, var2))
            return
        end
        var1.reportPurchaseAttempt(arg1, num1)
    end)
end

return PromptPurchase
