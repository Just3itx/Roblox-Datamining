-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local AppContext = require(PurchasePrompt.Utils.AppContext)
local PromptState = require(PurchasePrompt.Enums.PromptState)
local WindowState = require(PurchasePrompt.Enums.WindowState)

local RobloxSubscriptionPurchaseApp = require(PurchasePromptParent.RobloxSubscriptionPurchaseApp)
local RobloxSubscriptionFlowCompleteReason = RobloxSubscriptionPurchaseApp.RobloxSubscriptionFlowCompleteReason
local SurfaceName = RobloxSubscriptionPurchaseApp.SurfaceName
local SurfaceContext = RobloxSubscriptionPurchaseApp.SurfaceContext
local PurchaseClientSessionIdType = RobloxSubscriptionPurchaseApp.PurchaseClientSessionIdType

local function startRobuxUpsellPlusPurchase(tbl1)
    tbl1.setPromptState(PromptState.BlackbirdUpsellInProgress)
    tbl1.setWindowState(WindowState.Suspended)

    local clientSessionId = type(tbl1.purchaseFlowUUID) == "string"
        and tbl1.purchaseFlowUUID ~= ""
        and {
            clientSessionIdType = PurchaseClientSessionIdType.PurchaseFlowUUID,
            clientSessionId = tbl1.purchaseFlowUUID
        }
        or nil

    RobloxSubscriptionPurchaseApp.initiateRobloxSubscriptionPurchase(
        { showBackButton = true },
        {
            onFlowComplete = function(upsellPurchaseSucceeded)
                if tbl1.onFlowEnded then
                    tbl1.onFlowEnded()
                end
                if upsellPurchaseSucceeded ~= RobloxSubscriptionFlowCompleteReason.UpsellPurchaseSucceeded then
                    tbl1.completeRequest()

                    return
                end

                if tbl1.onRobloxSubscriptionUpsellSuccess then
                    tbl1.onRobloxSubscriptionUpsellSuccess()
                end
                tbl1.retryPurchaseAfterUpsell()
            end,
            onBackButtonActivated = function()
                if tbl1.onFlowEnded then
                    tbl1.onFlowEnded()
                end
                tbl1.setPromptState(PromptState.RobuxUpsell)
                tbl1.setWindowState(WindowState.Shown)
            end
        },
        nil,
        SurfaceName.InGameRobuxUpsell,
        if AppContext.get() == AppContext.Enum.IN_APP then SurfaceContext.InApp else SurfaceContext.InGame,
        nil,
        clientSessionId and { clientSessionId = clientSessionId } or nil
    )
end

return startRobuxUpsellPlusPurchase
