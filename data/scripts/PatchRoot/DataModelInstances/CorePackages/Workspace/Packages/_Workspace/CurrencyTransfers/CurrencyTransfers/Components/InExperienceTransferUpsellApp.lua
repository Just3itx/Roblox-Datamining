-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local React = require(CurrencyTransfersParent.React)

local InExperienceRobuxTransferSubscriptionUpsell = require(CurrencyTransfers.Components.InExperienceRobuxTransferSubscriptionUpsell)

local useRobuxTransferSubscriptionUpsellListenerEffect = require(CurrencyTransfers.Hooks.useRobuxTransferSubscriptionUpsellListenerEffect)

local function InExperienceTransferUpsellApp()
    local var1, var2 = React.useState(false)

    local var3 = React.useCallback(function()
        var2(true)
    end, {})

    local onClose = React.useCallback(function()
        var2(false)
    end, {})

    useRobuxTransferSubscriptionUpsellListenerEffect(var3)

    if not var1 then
        return nil
    end

    return React.createElement(
        "ScreenGui",
        {
            ScreenInsets = Enum.ScreenInsets.None,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 8
        },
        {
            SubscriptionUpsell = React.createElement(InExperienceRobuxTransferSubscriptionUpsell, { onClose = onClose })
        }
    )
end

return InExperienceTransferUpsellApp
