-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Constants = require(scriptParentParentParent.Constants)
local Foundation = require(scriptParentParentParentParent.Foundation)
local _TouchControlsEnum = require(scriptParentParentParent.Enums.TouchControlsEnum)

local FoundationText = Foundation.Text
local View = Foundation.View
local Icon = Foundation.Icon
local useTokens = Foundation.Hooks.useTokens
local useLocalizedLabels = require(scriptParentParentParent.Hooks.useLocalizedLabels)

return function(tbl1)
    local var1 = useTokens()
    local var2 = useLocalizedLabels({ action = tbl1.action })

    local actionComponent = React.createElement(View, {
        tag = "auto-xy padding-x-large padding-y-xsmall radius-large",
        backgroundStyle = var1.Color.Extended.Gray.Gray_600,
        LayoutOrder = 1
    }, {
        InnerAction = React.createElement(FoundationText, {
            tag = "auto-xy text-title-small text-align-x-center",
            textStyle = var1.Color.Extended.White.White_100,
            Text = var2.action
        })
    })

    local name = Constants.HELP_PAGE.TOUCH_ENUM_TO_ICON[tbl1.touchInput]
    local innerIcon = name and React.createElement(Icon, { name = name, size = var1.Size.Size_1200 })

    local iconComponent = name and React.createElement(View, { tag = "auto-xy", LayoutOrder = 2 }, { InnerIcon = innerIcon }) or nil

    return React.createElement(
        View,
        {
            tag = "col align-x-center gap-small auto-xy",
            LayoutOrder = tbl1.layoutOrder
        },
        { actionComponent = actionComponent, iconComponent = iconComponent }
    )
end
