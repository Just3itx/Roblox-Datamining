-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local GamePlayButtonParent = GamePlayButton.Parent

local React = require(GamePlayButtonParent.React)

local Foundation = require(GamePlayButtonParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize

local RoactServiceTags = require(GamePlayButtonParent.RoactServiceTags)
local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local usePlayButtonState = require(GamePlayButton.usePlayButtonState)
local useLocalization = require(GamePlayButtonParent.Localization).Hooks.useLocalization

return React.memo(function(tbl1) -- name: PlusEarlyAccessUpsellBanner
    local var1 = useLocalization({
        subscribe = "Feature.RobloxSubscription.Action.Subscribe",
        joinEarly = "Feature.RobloxSubscription.Description.JoinEarly"
    })

    local var2 = useRoactService(RoactServiceTags.RoactNetworking)
    local earlyAccess = usePlayButtonState(var2, tbl1.universeId).earlyAccess

    if earlyAccess == nil or not earlyAccess.showPlusUpsell then
        return nil
    end

    return React.createElement(View, {
        tag = "row align-y-center gap-small size-full-1100 padding-medium stroke-default radius-medium clip",
        LayoutOrder = tbl1.LayoutOrder,
        onActivated = earlyAccess.openUpsell,
        testId = "--early-access-plus-upsell"
    }, {
        PlusIcon = React.createElement(Icon, { name = IconName.RobloxPlus, size = IconSize.Medium, LayoutOrder = 1 }),
        Label = React.createElement(FoundationText, {
            tag = "fill auto-y text-body-medium text-align-x-left text-truncate-end content-emphasis",
            Text = var1.joinEarly,
            LayoutOrder = 2
        }),
        Subscribe = React.createElement(FoundationText, {
            tag = "auto-xy text-body-medium content-emphasis",
            Text = `<u>{var1.subscribe}</u>`,
            RichText = true,
            LayoutOrder = 3,
            testId = "--early-access-subscribe"
        })
    })
end)
