-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ComponentsParent = script:FindFirstAncestor("Components").Parent
local ComponentsParentParent = ComponentsParent.Parent
local InlineLayoutElements = script:FindFirstAncestor("InlineLayoutElements")

local Dash = require(ComponentsParentParent.Dash)
local Foundation = require(ComponentsParentParent.Foundation)
local React = require(ComponentsParentParent.React)

local BaseTextElement = require(InlineLayoutElements.BaseTextElement)
local getFontFace = require(ComponentsParent.Utils.getFontFace)

local View = Foundation.View

local module = {}

function mapProps(arg1)
    return Dash.omit(arg1, { "id", "EngineTags" })
end

local function TextElementWrapper(arg1)
    local fontFace = getFontFace(arg1.fontStyle)
    local var1 = typeof(arg1.textStyle) ~= "table" and {} or arg1.textStyle

    local viewTags = arg1.viewTags
    local tbl1

    if typeof(viewTags) == "string" then
        tbl1 = {
            [arg1.viewTags] = true
        }

        if tbl1 then
            return React.createElement(
                View,
                {
                    tag = Dash.join({ ["size-full-0 auto-y"] = true }, tbl1),
                    LayoutOrder = arg1.LayoutOrder
                },
                {
                    SelectableText = React.createElement("TextBox", {
                        Text = arg1.Text,
                        FontFace = fontFace,
                        TextSize = arg1.fontStyle and arg1.fontStyle.FontSize,
                        TextColor3 = var1.Color3,
                        TextTransparency = var1.Transparency,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        TextEditable = false,
                        ZIndex = 0,
                        Size = UDim2.fromScale(1, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextWrapped = false,
                        ClearTextOnFocus = false,
                        RichText = false,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                }
            )
        end
    end

    tbl1 = arg1.viewTags or {}

    return React.createElement(
        View,
        {
            tag = Dash.join({ ["size-full-0 auto-y"] = true }, tbl1),
            LayoutOrder = arg1.LayoutOrder
        },
        {
            SelectableText = React.createElement("TextBox", {
                Text = arg1.Text,
                FontFace = fontFace,
                TextSize = arg1.fontStyle and arg1.fontStyle.FontSize,
                TextColor3 = var1.Color3,
                TextTransparency = var1.Transparency,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                TextEditable = false,
                ZIndex = 0,
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                TextWrapped = false,
                ClearTextOnFocus = false,
                RichText = false,
                TextXAlignment = Enum.TextXAlignment.Left
            })
        }
    )
end

function module.new(arg1)
    return BaseTextElement.new(TextElementWrapper, Dash.omit(arg1, { "EngineTags" }), mapProps)
end

return module
