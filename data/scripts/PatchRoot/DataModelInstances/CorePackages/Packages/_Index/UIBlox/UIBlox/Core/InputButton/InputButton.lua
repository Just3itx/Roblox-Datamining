-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)
local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local withStyle = require(scriptParentParentParentParent.UIBlox.Core.Style.withStyle)
local ImageSetComponent = require(scriptParentParentParentParent.UIBlox.Core.ImageSet.ImageSetComponent)
local Controllable = require(scriptParentParentParentParent.UIBlox.Core.Control.Controllable)
local ControlState = require(scriptParentParentParentParent.UIBlox.Core.Control.Enum.ControlState)

local FitTextLabel = require(scriptParentParentParentParent.FitFrame).FitTextLabel
local FitFrameHorizontal = require(scriptParentParentParentParent.FitFrame).FitFrameHorizontal

local var1 = Roact.PureComponent:extend("InputButton")

var1.validateProps = t.strictInterface({
    text = t.string,
    size = t.optional(t.UDim2),
    image = t.table,
    imageColor = t.Color3,
    fillImage = t.optional(t.table),
    fillImageSize = t.optional(t.UDim2),
    fillImageColor = t.optional(t.Color3),
    selectedColor = t.Color3,
    textColor = t.Color3,
    transparency = t.number,
    onActivated = t.callback,
    isDisabled = t.optional(t.boolean),
    layoutOrder = t.optional(t.number),
    frameRef = t.optional(t.table),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    SelectionImageObject = t.optional(t.table),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.defaultProps = { layoutOrder = 0, isDisabled = false, isRoactGamepadEnabled = true }

function var1.init(arg1)
    arg1.state = {
        outerImage = arg1.props.image,
        outerTransparency = 1,
        outerImageColor = arg1.props.imageColor,
        innerImage = arg1.props.image,
        innerImageColor = arg1.props.fillImageColor,
        innerTransparency = 1
    }

    function arg1.changeSprite(arg2)
        if arg2 == ControlState.Hover then
            if not arg1.props.isDisabled then
                arg1:setState({ outerImageColor = arg1.props.selectedColor })
            end
        elseif arg2 == ControlState.Default then
            arg1:setState({ outerImageColor = arg1.props.imageColor })
        end
    end

    if arg1.props.size then
        return
    end
    local sizeBinding, updateSizeBinding = Roact.createBinding(UDim2.new(1, 0, 0, 26))
    arg1.sizeBinding = sizeBinding
    arg1.updateSizeBinding = updateSizeBinding

    function arg1.textAbsoluteSizeChanged(arg2)
        local yOffset = 26
        if yOffset < arg2.AbsoluteSize.Y then
            yOffset = arg2.AbsoluteSize.Y
        end
        arg1.updateSizeBinding(UDim2.new(1, 0, 0, yOffset))
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local font = arg2.Font
        local textSize = font.Body.RelativeSize * font.BaseSize
        local font2 = font.Body.Font

        local tbl1 = {
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            Text = arg1.props.text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextSize = textSize,
            FontFace = normalizeFontFace(font2),
            TextWrapped = true,
            TextColor3 = arg1.props.textColor,
            TextTransparency = arg1.props.transparency
        }

        local str1 = "Frame"
        local bool1 = false
        local str2, var3

        if arg1.props.size then
            str2 = "TextButton"

            var3 = Cryo.Dictionary.join(tbl1, {
                Size = UDim2.new(1, -34, 0, 26),
                AutomaticSize = Enum.AutomaticSize.Y,
                [Roact.Event.Activated] = if arg1.props.isDisabled then nil else arg1.props.onActivated or nil
            })
        else
            str1 = FitFrameHorizontal
            str2 = FitTextLabel
            var3 = Cryo.Dictionary.join(tbl1, {
                Font = normalizeFontFace(font2),
                FontFace = Cryo.None,
                width = FitTextLabel.Width.FitToText,
                onActivated = arg1.props.onActivated,
                [Roact.Change.AbsoluteSize] = arg1.textAbsoluteSizeChanged
            })
            bool1 = true
        end

        local fillImage = arg1.props.fillImage

        local createElement = Roact.createElement
        if arg1.props.isRoactGamepadEnabled then
            str1 = RoactGamepad.Focusable[str1]
        end

        local tbl2 = {
            Size = if bool1 then nil else arg1.props.size or arg1.sizeBinding or nil,
            height = bool1 and UDim.new(0, 26) or nil,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.layoutOrder,
            [Roact.Ref] = arg1.props.frameRef,
            SelectionImageObject = arg1.props.SelectionImageObject,
            FillDirection = bool1 and Enum.FillDirection.Horizontal or nil,
            VerticalAlignment = bool1 and Enum.VerticalAlignment.Center or nil,
            contentPadding = bool1 and UDim.new(0, 8) or nil,
            NextSelectionLeft = arg1.props.NextSelectionLeft,
            NextSelectionRight = arg1.props.NextSelectionRight,
            NextSelectionUp = arg1.props.NextSelectionUp,
            NextSelectionDown = arg1.props.NextSelectionDown,
            inputBindings = arg1.props.isRoactGamepadEnabled
                and {
                    Activated = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, arg1.props.onActivated)
                }
                or nil
        }

        local tbl3 = {
            HorizontalLayout = if bool1 then nil else Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, 8),
                VerticalAlignment = Enum.VerticalAlignment.Center
            })
                or nil,
            Padding = if bool1 then nil else Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 8) }) or nil,
            InputButtonImage = 0,
            InputButtonText = 0
        }

        local createElement2 = Roact.createElement
        local var4 = Controllable
        local tbl4 = {
            controlComponent = {
                component = ImageSetComponent.Button,
                props = {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 26, 0, 26),
                    Image = arg1.props.image,
                    ImageTransparency = arg1.props.transparency,
                    ScaleType = arg1.props.buttonSliceType,
                    SliceCenter = arg1.props.buttonSliceCenter,
                    ImageColor3 = arg1.state.outerImageColor,
                    [Roact.Event.Activated] = arg1.props.onActivated,
                    LayoutOrder = 1
                },
                children = {
                    InputFillImage = fillImage
                        and Roact.createElement(ImageSetComponent.Label, {
                            BackgroundTransparency = 1,
                            Size = arg1.props.fillImageSize,
                            Image = fillImage,
                            ImageTransparency = arg1.props.transparency,
                            ImageColor3 = arg1.props.fillImageColor,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.new(0.5, 0, 0.5, 0)
                        })
                }
            },
            isDisabled = arg1.props.isDisabled,
            onStateChanged = 0
        }
        function tbl4.onStateChanged(_, arg3)
            arg1.changeSprite(arg3)
        end

        tbl3.InputButtonImage = createElement2(var4, tbl4)

        tbl3.InputButtonText = not (arg1.props.text == "")
            and Roact.createElement(Controllable, {
                controlComponent = { component = str2, props = var3 },
                isDisabled = arg1.props.isDisabled,
                onStateChanged = function(_, arg3)
                    arg1.changeSprite(arg3)
                end
            })

        return createElement(str1, tbl2, tbl3)
    end)
end

return Roact.forwardRef(function(arg1, frameRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { frameRef = frameRef }))
end)
