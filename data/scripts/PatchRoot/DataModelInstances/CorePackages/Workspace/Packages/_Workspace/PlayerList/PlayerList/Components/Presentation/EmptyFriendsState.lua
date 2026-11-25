-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local useLocalization = require(scriptParentParentParentParent.Localization).Hooks.useLocalization

local View = Foundation.View
local FoundationText = Foundation.Text

local FFlagPlayerListLocalizeGameText = require(scriptParentParentParent.Flags.FFlagPlayerListLocalizeGameText)
local useLegacyAndTransparencyAwarePanelStyle = require(scriptParentParentParent.Hooks.useLegacyAndTransparencyAwarePanelStyle)

return React.memo(function(tbl1) -- name: EmptyFriendsStateImpl
    local var1 = useLegacyAndTransparencyAwarePanelStyle(tbl1.useLegacyPanelStyling)

    local var2 = if FFlagPlayerListLocalizeGameText then useLocalization({ friendsEmpty = "InGame.PlayerList.FriendsEmpty" }).friendsEmpty else "None of your friends have played this experience yet."

    return React.createElement(
        View,
        {
            tag = var1.panelTag,
            LayoutOrder = tbl1.layoutOrder,
            backgroundStyle = var1.backgroundStyle
        },
        {
            Message = React.createElement(
                FoundationText,
                {
                    Text = var2,
                    tag = "size-full-0 auto-y text-body-small text-align-x-center content-default",
                    TextWrapped = true
                }
            )
        }
    )
end)
