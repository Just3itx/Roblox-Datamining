-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent

local InputLabel = require(script.Parent.InputLabel)
local SliderWithInput = require(scriptParentParentParent.Components.SliderWithInput)

local var1 = Roact.PureComponent:extend("SliderEntry")
var1.validateProps = t.strictInterface({
    LayoutOrder = t.integer,
    labelKey = t.string,
    min = t.number,
    max = t.number,
    stepInterval = t.number,
    keyboardInputStepInterval = t.optional(t.numberPositive),
    value = t.number,
    disabled = t.optional(t.boolean),
    valueChanged = t.callback,
    canCaptureFocus = t.optional(t.boolean),
    isMenuOpen = t.optional(t.boolean),
    buttonRef = t.optional(t.table)
})

function var1.init(arg1)
    arg1.state = { isFrameSelectable = true }
end

function var1.render(arg1)
    local sliderDotRef = arg1.props.buttonRef or Roact.createRef()
    local createElement = Roact.createElement
    local tbl1 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 92),
        LayoutOrder = arg1.props.LayoutOrder,
        Selectable = arg1.state.isFrameSelectable
    }

    tbl1[Roact.Event.SelectionGained] = function()
        GuiService.SelectedCoreObject = sliderDotRef:getValue()
        arg1:setState({ isFrameSelectable = false })
    end

    return createElement("Frame", tbl1, {
        Padding = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, 24),
            PaddingTop = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 30),
            PaddingBottom = UDim.new(0, 24)
        }),
        Label = Roact.createElement(InputLabel, {
            Size = UDim2.new(1, 0, 0, 24),
            localizationKey = arg1.props.labelKey,
            Position = UDim2.new(0, 0, 0, 0),
            AnchorPoint = Vector2.new(0, 0)
        }),
        Slider = Roact.createElement(SliderWithInput, {
            min = arg1.props.min,
            max = arg1.props.max,
            stepInterval = arg1.props.stepInterval,
            keyboardInputStepInterval = arg1.props.keyboardInputStepInterval,
            value = arg1.props.value,
            Position = UDim2.new(0, 0, 0, 32),
            disabled = arg1.props.disabled,
            valueChanged = arg1.props.valueChanged,
            canCaptureFocus = arg1.props.canCaptureFocus,
            isMenuOpen = arg1.props.isMenuOpen,
            sliderDotRef = sliderDotRef,
            onSelectionLost = function()
                arg1:setState({ isFrameSelectable = true })
            end,
            onSelectionGained = function()
                arg1:setState({ isFrameSelectable = false })
            end
        })
    })
end

return var1
