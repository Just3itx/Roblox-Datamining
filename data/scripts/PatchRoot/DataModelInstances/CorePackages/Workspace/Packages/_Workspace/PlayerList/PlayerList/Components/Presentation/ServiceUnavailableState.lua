-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local useLocalization = require(scriptParentParentParentParent.Localization).Hooks.useLocalization

local View = Foundation.View
local Empty = Foundation.Empty
local IconSize = Foundation.Enums.IconSize

local FFlagPlayerListLocalizeGameText = require(scriptParentParentParent.Flags.FFlagPlayerListLocalizeGameText)
local useLegacyAndTransparencyAwarePanelStyle = require(scriptParentParentParent.Hooks.useLegacyAndTransparencyAwarePanelStyle)

local function func1() end

return React.memo(function(tbl1) -- name: ServiceUnavailableStateImpl
    local var1 = useLegacyAndTransparencyAwarePanelStyle(tbl1.useLegacyPanelStyling)
    local body, retry

    if FFlagPlayerListLocalizeGameText then
        local var2 = useLocalization({ body = "InGame.PlayerList.LeaderboardUnavailable", retry = "InGame.PlayerList.Retry" })

        body = var2.body
        retry = var2.retry
    else
        body = "Leaderboard unavailable. Please try again later."
        retry = "Retry"
    end

    return React.createElement(
        View,
        {
            tag = var1.panelTag,
            LayoutOrder = tbl1.layoutOrder,
            backgroundStyle = var1.backgroundStyle
        },
        {
            Content = React.createElement(Empty, {
                icon = {
                    name = "triangle-exclamation",
                    size = IconSize.Large
                },
                text = body,
                button = {
                    text = retry,
                    onActivated = tbl1.onRetry or func1
                }
            })
        }
    )
end)
