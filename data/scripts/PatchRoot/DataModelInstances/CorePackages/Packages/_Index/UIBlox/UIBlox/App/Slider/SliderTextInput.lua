-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local EventConnection = require(scriptParentParentParentParent.ReactUtils).EventConnection

local ImageSetComponent = require(scriptParentParentParentParent.UIBlox.Core.ImageSet.ImageSetComponent)
local Images = require(scriptParentParentParentParent.UIBlox.App.ImageSet.Images)
local withStyle = require(scriptParentParentParentParent.UIBlox.Core.Style.withStyle)

local divideTransparency = require(scriptParentParentParentParent.UIBlox.Utility.divideTransparency)

local var1 = Roact.PureComponent:extend("SliderTextInput")
var1.validateProps = t.strictInterface({
    position = t.optional(t.union(t.UDim2, t.table)),
    anchorPoint = t.optional(t.Vector2),
    value = t.number,
    min = t.number,
    max = t.number,
    disabled = t.optional(t.boolean),
    stepInterval = t.numberPositive,
    onValueChanged = t.callback,
    layoutOrder = t.optional(t.integer)
})

var1.defaultProps = { disabled = false }

function var1.init(arg1)
    arg1.textBoxRef = Roact.createRef()
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local num1 = if arg1.props.disabled then 2 else 1
        local textTransparency = divideTransparency(arg2.Theme.TextDefault.Transparency, num1)

        local imageTransparency = divideTransparency(arg2.Theme.Divider.Transparency, num1)

        local var2 = divideTransparency(arg2.Theme.BackgroundUIContrast.Transparency, num1)

        local createElement = Roact.createElement
        local label = ImageSetComponent.Label
        local tbl1 = {
            BackgroundTransparency = 1,
            Image = Images["component_assets/circle_16"],
            ImageColor3 = arg2.Theme.BackgroundUIContrast.Color,
            ImageTransparency = var2,
            Position = arg1.props.position,
            AnchorPoint = arg1.props.anchorPoint,
            ScaleType = Enum.ScaleType.Slice,
            Size = UDim2.fromOffset(56, 36),
            SliceCenter = Rect.new(8, 8, 8, 8),
            LayoutOrder = arg1.props.layoutOrder
        }
        local tbl2 = {
            Border = Roact.createElement(ImageSetComponent.Label, {
                BackgroundTransparency = 1,
                Image = Images["component_assets/circle_17_stroke_1"],
                ImageColor3 = arg2.Theme.Divider.Color,
                ImageTransparency = imageTransparency,
                ScaleType = Enum.ScaleType.Slice,
                Size = UDim2.fromScale(1, 1),
                SliceCenter = Rect.new(8, 8, 8, 8)
            }),
            TextBox = 0,
            UserInputConnection = 0
        }
        local createElement2 = Roact.createElement

        local tbl3 = {
            [Roact.Ref] = arg1.textBoxRef,
            BackgroundTransparency = 1,
            ClearTextOnFocus = false,
            FontFace = normalizeFontFace(arg2.Font.Body.Font),
            TextSize = arg2.Font.Body.RelativeSize * arg2.Font.BaseSize,
            TextColor3 = arg2.Theme.TextDefault.Color,
            TextTransparency = textTransparency,
            Size = UDim2.fromScale(1, 1),
            Text = tostring(arg1.props.value),
            TextScaled = true,
            TextEditable = not arg1.props.disabled,
            ZIndex = 2,
            [Roact.Event.Focused] = arg1.props.disabled and function(arg3)
                arg3:ReleaseFocus()
            end or nil
        }
        tbl3[Roact.Event.FocusLost] = function(arg3, _)
            local var5 = tonumber(arg3.Text)

            if var5 == nil then
                arg3.Text = tostring(arg1.props.value)
                return
            end

            local num2 = math.clamp(math.floor(var5 / arg1.props.stepInterval + 0.5) * arg1.props.stepInterval, arg1.props.min, arg1.props.max)

            arg1.props.onValueChanged(num2)
        end

        tbl2.TextBox = createElement2("TextBox", tbl3, {
            TextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MinTextSize = arg2.Font.Body.RelativeMinSize * arg2.Font.BaseSize,
                MaxTextSize = arg2.Font.Body.RelativeSize * arg2.Font.BaseSize
            })
        })
        tbl2.UserInputConnection = not arg1.props.disabled and Roact.createElement(EventConnection, {
            event = UserInputService.InputBegan,
            callback = function(arg3, _)
                if arg3.UserInputType ~= Enum.UserInputType.Keyboard or UserInputService:GetFocusedTextBox() ~= arg1.textBoxRef.current then
                    return
                end

                local num2 = 0
                if arg3.KeyCode == Enum.KeyCode.Up then
                    num2 = 1
                elseif arg3.KeyCode == Enum.KeyCode.Down then
                    num2 = -1
                end

                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                    num2 *= 10
                end

                if num2 == 0 then
                    return
                end

                local num3 = math.clamp(
                    math.floor((arg1.props.value + arg1.props.stepInterval * num2) / arg1.props.stepInterval + 0.5) * arg1.props.stepInterval,
                    arg1.props.min,
                    arg1.props.max
                )

                if num3 ~= arg1.props.value then
                    arg1.props.onValueChanged(num3)
                end
            end
        })

        return createElement(label, tbl1, tbl2)
    end)
end

function var1.didMount(arg1)
    pcall(function()
        arg1.textBoxRef.current.TextInputType = Enum.TextInputType.Number
    end)
end

return var1
