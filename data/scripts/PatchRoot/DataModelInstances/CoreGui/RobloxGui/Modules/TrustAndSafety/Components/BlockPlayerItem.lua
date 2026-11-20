-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Checkbox = require(CorePackages.Packages.Foundation).Checkbox

local t = require(CorePackages.Packages.t)

local scriptParentParent = script.Parent.Parent
local Dependencies = require(scriptParentParent.Dependencies)
local Divider = require(Dependencies.Divider)
local ThemedTextLabel = require(Dependencies.ThemedTextLabel)
local withStyle = UIBlox.Style.withStyle

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local var1 = Roact.PureComponent:extend("BlockPlayerItem")

var1.validateProps = t.strictInterface({
    layoutOrder = t.optional(t.number),
    size = t.UDim2,
    text = t.string,
    description = t.string,
    icon = t.union(t.string, t.table),
    iconSize = t.UDim2,
    isDisabled = t.optional(t.boolean),
    isCheckBoxSelected = t.boolean,
    onCheckBoxActivated = t.callback
})

var1.defaultProps = { isDisabled = false, isCheckBoxSelected = false }

function var1.init(arg1)
    function arg1.onClicked()
        if arg1.props.onCheckBoxActivated and not arg1.props.isDisabled then
            arg1.props.onCheckBoxActivated(not arg1.props.isCheckBoxSelected)
        end
    end
end

function var1.render(arg1)
    local props = arg1.props

    return withStyle(function(arg2)
        local _theme = arg2.Theme
        return Roact.createElement("TextButton", {
            BackgroundTransparency = 1,
            LayoutOrder = props.layoutOrder,
            Size = props.size,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            Text = "",
            [Roact.Event.Activated] = arg1.onClicked
        }, {
            BlockIcon = Roact.createElement(ImageSetLabel, {
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Image = props.icon,
                ImageTransparency = if props.isDisabled then 0.5 else nil,
                Position = UDim2.new(0, 16, 0.5, 0),
                Size = props.iconSize
            }),
            CheckBoxFrame = Roact.createElement("Frame", {
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(1, -20, 0.5, 0),
                Size = UDim2.fromOffset(24, 24)
            }, {
                CheckBox = Roact.createElement(Checkbox, {
                    label = "",
                    isDisabled = props.isDisabled,
                    onActivated = props.onCheckBoxActivated,
                    isChecked = props.isCheckBoxSelected
                })
            }),
            TextFrame = Roact.createElement("Frame", {
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 60, 0.5, 0),
                Size = UDim2.new(1, -124, 1, 0)
            }, {
                Layout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 4)
                }),
                Text = Roact.createElement(ThemedTextLabel, {
                    LayoutOrder = 1,
                    TextTransparency = if props.isDisabled then 0.5 else nil,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    fontKey = "SubHeader1",
                    themeKey = "TextEmphasis",
                    Text = props.text,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextXAlignment = Enum.TextXAlignment.Left
                }),
                Description = Roact.createElement(ThemedTextLabel, {
                    LayoutOrder = 2,
                    TextTransparency = if props.isDisabled then 0.5 else nil,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    fontKey = "Footer",
                    TextWrapped = true,
                    themeKey = "TextDefault",
                    Text = props.description,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LineHeight = 1.25
                })
            }),
            Divider = Roact.createElement(Divider, { Position = UDim2.new(0, 0, 1, 0) })
        })
    end)
end

return var1
