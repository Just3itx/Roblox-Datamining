-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent

local ToggleSwitch = require(scriptParentParentParent.Components.ToggleSwitch)

local InputLabel = require(script.Parent.InputLabel)
local DeveloperLockLabel = require(script.Parent.DeveloperLockLabel)
local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)
local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local var1 = Roact.PureComponent:extend("ToggleEntry")
var1.validateProps = t.strictInterface({
    LayoutOrder = t.integer,
    labelKey = t.string,
    lockedToOff = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    subtextEnabled = t.optional(t.boolean),
    subtextKey = t.optional(t.string),
    checked = t.boolean,
    onToggled = t.callback,
    buttonRef = t.optional(t.table),
    NextSelectionUp = t.optional(t.union(t.Instance, t.table))
})

function var1.init(arg1)
    arg1.state = { isSelectable = true }
end

function var1.render(arg1)
    local buttonRef = arg1.props.buttonRef or Roact.createRef()

    local createElement = Roact.createElement
    local tbl1 = {
        BackgroundTransparency = 1,
        LayoutOrder = arg1.props.LayoutOrder,
        Size = UDim2.new(1, 0, 0, 56),
        Selectable = arg1.state.isSelectable
    }

    tbl1[Roact.Event.SelectionGained] = function()
        GuiService.SelectedCoreObject = buttonRef:getValue()
        arg1:setState({ isSelectable = false })
    end

    return createElement("Frame", tbl1, {
        Padding = Roact.createElement("UIPadding", { PaddingRight = UDim.new(0, 30), PaddingLeft = UDim.new(0, 24) }),
        ControlLabel = Roact.createElement(InputLabel, { localizationKey = arg1.props.labelKey }),
        LockedLabel = arg1.props.lockedToOff
            and Roact.createElement(
                DeveloperLockLabel,
                {
                    Size = UDim2.new(1, -72, 0.25, 0),
                    Position = UDim2.new(0, 0, 1, 0),
                    AnchorPoint = Vector2.new(0, 1)
                }
            ),
        SubtextLabel = arg1.props.subtextEnabled and withLocalization({ text = arg1.props.subtextKey })(function(arg2)
            return Roact.createElement(ThemedTextLabel, {
                Text = arg2.text,
                themeKey = "TextDefault",
                fontKey = "CaptionBody",
                TextTransparency = 0.5,
                Size = UDim2.new(1, -72, 0.25, 0),
                Position = UDim2.new(0, 0, 1, 0),
                AnchorPoint = Vector2.new(0, 1),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Bottom
            })
        end),
        Toggle = Roact.createElement(ToggleSwitch, {
            Position = UDim2.new(1, 0, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            checked = arg1.props.checked and not arg1.props.lockedToOff,
            onToggled = arg1.props.onToggled,
            disabled = arg1.props.lockedToOff or arg1.props.isDisabled,
            buttonRef = buttonRef,
            onSelectionLost = function()
                arg1:setState({ isSelectable = true })
            end,
            onSelectionGained = function()
                arg1:setState({ isSelectable = false })
            end,
            NextSelectionUp = arg1.props.NextSelectionUp
        })
    })
end

return var1
