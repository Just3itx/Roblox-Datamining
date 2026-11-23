-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)

local useLocalization = Localization.Hooks.useLocalization

local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local MenuButton = require(scriptParentParentParent.Components.Common.MenuButton)
local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)

return function(tbl1)
    local var1 = useAnalytics()
    local var2 = useLocalization({ showMore = "Feature.Avatar.Action.ShowMore" })

    local onActivated = React.useCallback(function()
        var1.fireEvent(EventNames.CapturesShowMoreInGameMenu)
        tbl1.onActivated()
    end, { tbl1.onActivated })

    return React.createElement(
        MenuButton,
        {
            buttonHeight = tbl1.buttonHeight,
            LayoutOrder = tbl1.LayoutOrder,
            onActivated = onActivated,
            text = var2.showMore
        }
    )
end
