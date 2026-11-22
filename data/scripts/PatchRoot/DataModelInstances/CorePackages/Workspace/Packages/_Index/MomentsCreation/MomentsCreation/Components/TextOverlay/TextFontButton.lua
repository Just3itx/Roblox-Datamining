-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local IconButton = Foundation.IconButton
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function TextFontButton(tbl1)
    local var1 = useTokens()

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "auto-xy radius-circle"
    }, {
        Icon = React.createElement(IconButton, {
            icon = BuilderIcons.Icon.TextUppercaseALowercaseA,
            onActivated = tbl1.onToggle,
            size = Foundation.Enums.InputSize.Medium,
            isCircular = true
        }),
        Highlight = if tbl1.expanded then React.createElement(View, { ZIndex = 2, tag = "size-full radius-circle", backgroundStyle = var1.Color.State.Hover }) else nil
    })
end

return TextFontButton
