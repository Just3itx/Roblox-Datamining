-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local React = require(GamePlayButtonParent.React)

local Foundation = require(GamePlayButtonParent.Foundation)
local EducationalTooltip = Foundation.EducationalTooltip
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local RobloxSubscriptionPurchaseApp = require(GamePlayButtonParent.RobloxSubscriptionPurchaseApp)
local SignalsReact = require(GamePlayButtonParent.SignalsReact)
local useLocalization = require(GamePlayButtonParent.Localization).Hooks.useLocalization

return React.memo(function(tbl1) -- name: EarlyAccessPlusTooltip
    local var1 = useLocalization({
        title = "Feature.RobloxSubscription.ToolTip.EarlyAccess.Title",
        body = "Feature.RobloxSubscription.ToolTip.EarlyAccess.Body"
    })

    local var2 = RobloxSubscriptionPurchaseApp.RobloxSubscriptionSignals.get()
    if not SignalsReact.useSignalState(var2.getHasRobloxSubscription) then
        return nil
    end

    return React.createElement(EducationalTooltip, {
        isOpen = tbl1.isOpen,
        onClose = tbl1.onRequestClose,
        onPressedOutside = tbl1.onRequestClose,
        anchorRef = tbl1.anchorRef,
        title = var1.title,
        text = var1.body,
        side = PopoverSide.Top,
        align = PopoverAlign.Center
    })
end)
