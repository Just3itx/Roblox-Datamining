-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParent.Cryo)
local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)
local t = require(scriptParentParentParentParent.t)

local Button = require(scriptParent.Button)
local ButtonType = require(scriptParent.Enum.ButtonType)
local GetTextSize = require(scriptParentParentParent.Core.Text.GetTextSize)
local withStyle = require(scriptParentParentParent.Core.Style.withStyle)

local FitFrameOnAxis = require(scriptParentParentParentParent.FitFrame).FitFrameOnAxis

local var1 = Roact.PureComponent:extend("ButtonStack")

var1.validateProps = t.strictInterface({
    buttons = t.array(
        t.strictInterface({
            buttonType = t.optional(ButtonType.isEnumValue),
            props = Button.validateProps,
            isDefaultChild = t.optional(t.boolean)
        })
    ),
    buttonHeight = t.optional(t.numberMin(0)),
    forcedFillDirection = t.optional(t.enum(Enum.FillDirection)),
    marginBetween = t.optional(t.numberMin(0)),
    minHorizontalButtonPadding = t.optional(t.numberMin(0)),
    disableRoactGamepadButtonSelection = t.optional(t.boolean),
    disableGamepadRefs = t.optional(t.boolean),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    frameRef = t.optional(t.table),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.defaultProps = {
    buttonHeight = 36,
    marginBetween = 12,
    minHorizontalButtonPadding = 8,
    isRoactGamepadEnabled = true
}

function var1.init(arg1)
    arg1.buttonRefs = RoactGamepad.createRefCache()

    arg1.state = { frameWidth = 0 }

    function arg1.updateFrameSize(arg2)
        local absoluteSizeX = arg2.AbsoluteSize.X
        if absoluteSizeX ~= arg1.state.frameWidth then
            arg1:setState({ frameWidth = absoluteSizeX })
        end
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local font = arg2.Font
        local var2 = font.Body.RelativeSize * font.BaseSize

        local isRoactGamepadEnabled = arg1.props.isRoactGamepadEnabled

        local buttons = arg1.props.buttons
        local marginBetween = #buttons > 1 and arg1.props.marginBetween or 0
        local xOffset = arg1.state.frameWidth / #buttons - marginBetween * (#buttons - 1) / #buttons

        local bool1 = false

        local var3 = nil
        local forcedFillDirection

        if arg1.props.forcedFillDirection then
            bool1 = arg1.props.forcedFillDirection == Enum.FillDirection.Vertical
            forcedFillDirection = arg1.props.forcedFillDirection
        else
            for _, button in ipairs(buttons) do
                local var4 = GetTextSize
                local text = button.props.text or ""

                local font2 = font.Body.Font
                local vector2 = Vector2.new(arg1.state.frameWidth, arg1.props.buttonHeight)
                local richText = if button.props.buttonTextOverride then button.props.buttonTextOverride.RichText else false

                if var4(text, var2, font2, vector2, richText).X > xOffset - 2 * arg1.props.minHorizontalButtonPadding then
                    bool1 = true
                    break
                end
            end

            forcedFillDirection = bool1 and Enum.FillDirection.Vertical or Enum.FillDirection.Horizontal
        end

        local uDim2 = bool1 and UDim2.new(1, 0, 0, arg1.props.buttonHeight) or UDim2.new(0, xOffset, 0, arg1.props.buttonHeight)

        local tbl1 = {}
        for i, button in ipairs(buttons) do
            local tbl2 = {
                key = tostring(i),
                layoutOrder = if bool1 then #buttons - i or i else i,
                size = uDim2,
                buttonType = button.buttonType or ButtonType.Secondary,
                isRoactGamepadEnabled = isRoactGamepadEnabled
            }
            local var4 = Cryo.Dictionary.join(tbl2, button.props)

            if button.isDefaultChild then
                var3 = i
            end

            if not arg1.props.disableGamepadRefs and isRoactGamepadEnabled then
                local tbl3

                if arg1.props.disableRoactGamepadButtonSelection then
                    tbl3 = {
                        [Roact.Ref] = arg1.buttonRefs[i]
                    }
                else
                    tbl3 = {
                        [Roact.Ref] = arg1.buttonRefs[i],
                        NextSelectionUp = if bool1 and i > 1 then arg1.buttonRefs[i - 1] or nil else nil,
                        NextSelectionDown = if bool1 and i < #buttons then arg1.buttonRefs[i + 1] or nil else nil,
                        NextSelectionLeft = if bool1 or not (i > 1) then nil else arg1.buttonRefs[i - 1] or nil,
                        NextSelectionRight = if bool1 or not (i < #buttons) then nil else arg1.buttonRefs[i + 1] or nil
                    }
                end

                var4 = Cryo.Dictionary.join(var4, tbl3)
            end
            table.insert(tbl1, Roact.createElement(Button, var4))
        end

        return Roact.createElement(
            if isRoactGamepadEnabled then RoactGamepad.Focusable[FitFrameOnAxis] else FitFrameOnAxis,
            {
                BackgroundTransparency = 1,
                contentPadding = UDim.new(0, marginBetween),
                FillDirection = forcedFillDirection,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                LayoutOrder = 3,
                minimumSize = UDim2.new(1, 0, 0, arg1.props.buttonHeight),
                [Roact.Ref] = arg1.props.frameRef,
                [Roact.Change.AbsoluteSize] = arg1.updateFrameSize,
                NextSelectionLeft = if isRoactGamepadEnabled then arg1.props.NextSelectionLeft else nil,
                NextSelectionRight = if isRoactGamepadEnabled then arg1.props.NextSelectionRight else nil,
                NextSelectionUp = if isRoactGamepadEnabled then arg1.props.NextSelectionUp else nil,
                NextSelectionDown = if isRoactGamepadEnabled then arg1.props.NextSelectionDown else nil,
                defaultChild = if isRoactGamepadEnabled then var3 and arg1.buttonRefs[var3] or nil else nil
            },
            tbl1
        )
    end)
end

local var2 = Roact.forwardRef(function(arg1, frameRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { frameRef = frameRef }))
end)

var2.validateProps = var1.validateProps

return var2
