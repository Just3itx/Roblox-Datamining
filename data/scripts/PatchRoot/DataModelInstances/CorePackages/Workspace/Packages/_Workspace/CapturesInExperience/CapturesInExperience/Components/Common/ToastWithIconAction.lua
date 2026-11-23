-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)

local Button = Foundation.Button
local Image = Foundation.Image
local FoundationText = Foundation.Text
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local function ToastWithIconAction(tbl1)
    local bool1 = not (tbl1.text == nil) and tbl1.text ~= ""
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        Size = UDim2.new(tbl1.width, UDim.new()),
        tag = "col gap-medium auto-y padding-medium radius-medium bg-over-media-0",
        testId = "--captures-toast-with-icon-action"
    }

    local tbl3 = { Header = 0, Actions = 0 }
    local createElement2 = React.createElement
    local var2 = View
    local tbl4 = { LayoutOrder = 1, tag = "row gap-small size-full-0 auto-y" }

    local tbl5 = {
        Media = React.createElement(Image, { LayoutOrder = 1, Image = tbl1.icon, tag = "size-1200-1200" }),
        Content = React.createElement(View, {
            LayoutOrder = 2,
            tag = "col fill self-center gap-xxsmall auto-y"
        }, {
            Header = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.title,
                tag = "size-full-0 auto-y text-title-small text-align-x-left text-truncate-end content-emphasis"
            }),
            Body = if bool1 then React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.text,
                tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-default"
            }) else nil
        })
    }
    tbl3.Header = createElement2(var2, tbl4, tbl5)

    tbl3.Actions = React.createElement(
        View,
        {
            LayoutOrder = 2,
            tag = "row gap-small size-full-0 auto-y",
            testId = "--captures-toast-with-icon-action--actions"
        },
        {
            PrimaryAction = React.createElement(Button, {
                LayoutOrder = 1,
                text = tbl1.actionText,
                onActivated = tbl1.onAction,
                variant = ButtonVariant.Emphasis,
                size = InputSize.Medium,
                fillBehavior = FillBehavior.Fill,
                testId = "--captures-toast-with-icon-action--primary"
            }),
            IconAction = React.createElement(Button, {
                LayoutOrder = 2,
                icon = tbl1.iconActionIcon,
                onActivated = tbl1.onIconAction,
                variant = ButtonVariant.Standard,
                size = InputSize.Medium,
                testId = "--captures-toast-with-icon-action--icon"
            })
        }
    )
    return createElement(var1, tbl2, tbl3)
end

return ToastWithIconAction
