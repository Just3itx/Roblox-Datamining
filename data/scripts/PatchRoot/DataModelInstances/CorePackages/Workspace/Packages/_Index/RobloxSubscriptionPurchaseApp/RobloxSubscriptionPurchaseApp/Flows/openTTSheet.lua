-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")

local RobloxPlusSheetKind = require(RobloxSubscriptionPurchaseApp.Enums.RobloxPlusSheetKind)
local RobloxSubscriptionFlowCompleteReason = require(RobloxSubscriptionPurchaseApp.Enums.RobloxSubscriptionFlowCompleteReason)
local SurfaceContext = require(RobloxSubscriptionPurchaseApp.Enums.SurfaceContext)
local SurfaceName = require(RobloxSubscriptionPurchaseApp.Enums.SurfaceName)
local initiateRobloxSubscriptionPurchase = require(RobloxSubscriptionPurchaseApp.Flows.initiateRobloxSubscriptionPurchase)

local function openTTSheet(callback: ((...any) -> (...any))?, arg1, arg2)
    return initiateRobloxSubscriptionPurchase({
        sheetKind = RobloxPlusSheetKind.TT
    }, {
        onFlowComplete = function(upsellPurchaseSucceeded)
            if callback and upsellPurchaseSucceeded == RobloxSubscriptionFlowCompleteReason.UpsellPurchaseSucceeded then
                callback()
            end
        end
    }, nil, arg1 or SurfaceName.TTGrantSheet, arg2 or SurfaceContext.InApp)
end

return openTTSheet
