-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local Cryo = InGameMenuDependencies.Cryo
local t = InGameMenuDependencies.t

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Foundation = require(CorePackages.Packages.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParent = script.Parent.Parent

local ExternalEventConnection = require(scriptParentParent.Utility.ExternalEventConnection)
local FocusHandler = require(script.Parent.Connection.FocusHandler)
local Slider = require(script.Parent.Slider)
local AssetImage = require(script.Parent.AssetImage)

local var3 = Roact.PureComponent:extend("SliderWithInput")
var3.defaultProps = {
    width = UDim.new(1, 0)
}

var3.validateProps = t.intersection(
    t.strictInterface({
        min = t.number,
        max = t.number,
        stepInterval = t.numberPositive,
        keyboardInputStepInterval = t.optional(t.numberPositive),
        value = t.number,
        valueChanged = t.callback,
        disabled = t.optional(t.boolean),
        width = t.optional(t.UDim),
        AnchorPoint = t.optional(t.Vector2),
        LayoutOrder = t.optional(t.integer),
        Position = t.optional(t.UDim2),
        canCaptureFocus = t.optional(t.boolean),
        isMenuOpen = t.optional(t.boolean),
        sliderDotRef = t.optional(t.table),
        onSelectionLost = t.callback,
        onSelectionGained = t.callback
    }),
    function(arg1)
        if arg1.min > arg1.max then
            return false, "min must be less than or equal to max"
        elseif arg1.value > arg1.max or arg1.value < arg1.min then
            return false, "value must be within min and max"
        end

        return true
    end
)

function var3.init(arg1)
    arg1.textBoxRef = Roact.createRef()

    arg1.state = { textEntryMode = false }
end

function var3.renderFocusHandler(arg1)
    local createElement = Roact.createElement
    local var4 = FocusHandler
    local tbl1 = {
        isFocused = if arg1.props.canCaptureFocus then arg1.state.textEntryMode or false else false,
        didFocus = 0,
        didBlur = 0
    }
    function tbl1.didFocus()
        GuiService.CoreGuiNavigationEnabled = false

        local value = arg1.props.value

        ContextActionService:BindCoreAction("LeaveTextEntryMode", function(_, userInputState)
            if userInputState ~= Enum.UserInputState.End then
                return Enum.ContextActionResult.Pass
            end

            arg1:setState({ textEntryMode = false })
            local current = arg1.textBoxRef.current
            current.Text = value
            current:ReleaseFocus()
            return Enum.ContextActionResult.Sink
        end, false, Enum.KeyCode.ButtonB)
    end

    function tbl1.didBlur()
        GuiService.CoreGuiNavigationEnabled = true
        ContextActionService:UnbindCoreAction("LeaveTextEntryMode")
    end

    return createElement(var4, tbl1) or nil
end

function var3.renderWithSelectionCursor(arg1, arg2)
    local props = arg1.props
    local var4 = Cryo.Dictionary.join(props, {
        width = UDim.new(1, -80),
        LayoutOrder = Cryo.None,
        Position = Cryo.None,
        AnchorPoint = Cryo.None,
        keyboardInputStepInterval = Cryo.None,
        NextSelectionRight = arg1.textBoxRef
    })

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(props.width.Scale, props.width.Offset, 0, 36),
        Position = props.Position,
        LayoutOrder = props.LayoutOrder
    }, {
        Slider = Roact.createElement(Slider, var4),
        TextContainer = withFoundationOrUIBloxStyle(function(tokens)
            return {
                Tokens = tokens,
                Theme = {
                    TextMuted = {
                        Color = tokens.Color.Content.Muted.Color3,
                        Transparency = tokens.Color.Content.Muted.Transparency
                    },
                    TextDefault = {
                        Color = tokens.Color.Content.Default.Color3,
                        Transparency = tokens.Color.Content.Default.Transparency
                    },
                    BackgroundUIContrast = {
                        Color = tokens.Color.OverMedia.OverMedia_0.Color3,
                        Transparency = tokens.Color.OverMedia.OverMedia_0.Transparency
                    }
                },
                Font = {
                    BaseSize = 1,
                    Body = {
                        Font = tokens.Typography.BodyLarge.Font,
                        RelativeSize = tokens.Typography.BodyLarge.FontSize,
                        RelativeMinSize = tokens.Typography.BodyLarge.FontSize
                    }
                }
            }
        end, function(arg3)
            local var5 = props.disabled and arg3.Theme.TextMuted or arg3.Theme.TextDefault

            local createElement = Roact.createElement
            local label = AssetImage.Label
            local tbl1 = {
                BackgroundTransparency = 1,
                imageKey = "RoundedRect",
                ImageTransparency = arg3.Theme.BackgroundUIContrast.Transparency,
                ImageColor3 = arg3.Theme.BackgroundUIContrast.Color,
                Size = UDim2.new(0, 64, 0, 36),
                Position = UDim2.new(1, 0, 0.5, 0),
                AnchorPoint = Vector2.new(1, 0.5)
            }
            local tbl2 = {
                FocusHandler = arg1:renderFocusHandler(),
                Box = 0
            }
            local createElement2 = Roact.createElement

            local tbl3 = {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                FontFace = normalizeFontFace(arg3.Tokens.Typography.BodyLarge.Font),
                TextScaled = true,
                ClearTextOnFocus = false,
                TextEditable = not props.disabled,
                TextColor3 = var5.Color,
                TextTransparency = var5.Transparency,
                Text = tostring(props.value),
                NextSelectionLeft = arg1.props.sliderDotRef,
                SelectionImageObject = arg2(var2.InputFields),
                [Roact.Event.SelectionLost] = arg1.props.onSelectionLost,
                [Roact.Event.SelectionGained] = arg1.props.onSelectionGained,
                [Roact.Ref] = arg1.textBoxRef,
                [Roact.Event.Focused] = props.disabled and function(arg4)
                    arg4:ReleaseFocus(false)
                end or function()
                    arg1:setState({ textEntryMode = true })
                end
            }

            tbl3[Roact.Event.FocusLost] = function(arg4, _)
                arg1:setState({ textEntryMode = false })

                local var6 = tonumber(arg4.Text)
                if var6 == props.value then
                    return
                end

                if var6 == nil then
                    arg4.Text = tostring(props.value)
                    return
                end

                local stepInterval = props.stepInterval
                if props.keyboardInputStepInterval then
                    stepInterval = props.keyboardInputStepInterval
                end

                local num1 = math.clamp(math.floor(var6 / stepInterval + 0.5) * stepInterval, props.min, props.max)

                arg4.Text = tostring(num1)

                if num1 ~= props.value then
                    props.valueChanged(num1)
                end
            end

            tbl2.Box = createElement2("TextBox", tbl3, {
                TextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                    MinTextSize = arg3.Font.Body.RelativeMinSize * arg3.Font.BaseSize,
                    MaxTextSize = arg3.Font.Body.RelativeSize * arg3.Font.BaseSize
                })
            })
            return createElement(label, tbl1, tbl2)
        end),
        UserInputConnection = not props.disabled
            and Roact.createElement(ExternalEventConnection, {
                event = UserInputService.InputBegan,
                callback = function(arg3, _)
                    if arg3.UserInputType ~= Enum.UserInputType.Keyboard or UserInputService:GetFocusedTextBox() ~= arg1.textBoxRef.current then
                        return
                    end

                    local num1 = 0
                    if arg3.KeyCode == Enum.KeyCode.Up then
                        num1 = 1
                    elseif arg3.KeyCode == Enum.KeyCode.Down then
                        num1 = -1
                    end

                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                        num1 *= 10
                    end

                    if num1 == 0 then
                        return
                    end

                    local num2 = math.clamp(
                        math.floor((props.value + props.stepInterval * num1) / props.stepInterval + 0.5) * props.stepInterval,
                        props.min,
                        props.max
                    )

                    if num2 ~= props.value then
                        props.valueChanged(num2)
                    end
                end
            })
    })
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

return var3
