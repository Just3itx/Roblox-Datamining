-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)

local Foundation = require(scriptParentParentParent.Foundation)
local FoundationText = Foundation.Text
local View = Foundation.View
local Image = Foundation.Image
local useTokens = Foundation.Hooks.useTokens

return function(tbl1)
    local emphasis = useTokens().LightMode.Content.Emphasis
    local coolYellow = Color3.fromRGB(239, 215, 140)

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "radius-circle padding-small row gap-xsmall align-y-center align-x-center auto-xy",
        backgroundStyle = { Color3 = coolYellow, Transparency = 0 }
    }, {
        Icon = if tbl1.Icon then React.createElement(Image, { LayoutOrder = 1, Image = tbl1.Icon, imageStyle = emphasis, tag = "size-300" }) else nil,
        Text = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = tbl1.Text,
            textStyle = emphasis,
            tag = "text-caption-small content-emphasis text-align-x-center auto-xy"
        })
    })
end
