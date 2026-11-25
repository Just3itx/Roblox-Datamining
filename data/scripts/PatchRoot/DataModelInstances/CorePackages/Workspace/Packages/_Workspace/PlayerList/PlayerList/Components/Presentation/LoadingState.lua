-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)

local View = Foundation.View
local Loading = Foundation.Loading
local IconSize = Foundation.Enums.IconSize

local useLegacyAndTransparencyAwarePanelStyle = require(scriptParentParentParent.Hooks.useLegacyAndTransparencyAwarePanelStyle)

return React.memo(function(tbl1) -- name: LoadingStateImpl
    local var1 = useLegacyAndTransparencyAwarePanelStyle(tbl1.useLegacyPanelStyling)

    return React.createElement(
        View,
        {
            tag = var1.panelTag,
            LayoutOrder = tbl1.layoutOrder,
            backgroundStyle = var1.backgroundStyle
        },
        {
            Spinner = React.createElement(Loading, { size = IconSize.XLarge })
        }
    )
end)
