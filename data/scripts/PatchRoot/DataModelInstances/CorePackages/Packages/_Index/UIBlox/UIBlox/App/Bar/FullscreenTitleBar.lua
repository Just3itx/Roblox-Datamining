-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local Roact = require(scriptParentParentParentParent.Roact)
local Otter = require(scriptParentParentParentParent.Otter)
local t = require(scriptParentParentParentParent.t)

local IconButton = require(scriptParentParent.Button.IconButton)
local Images = require(scriptParentParent.ImageSet.Images)
local IconSize = require(scriptParentParent.ImageSet.Enum.IconSize)
local getIconSize = require(scriptParentParent.ImageSet.getIconSize)
local ControlState = require(scriptParentParentParentParent.UIBlox.Core.Control.Enum.ControlState)
local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local ThreeSectionBar = require(scriptParentParentParent.Core.Bar.ThreeSectionBar)

local lerp = require(scriptParentParentParentParent.UIBlox.Utility.lerp)
local divideTransparency = require(scriptParentParentParentParent.UIBlox.Utility.divideTransparency)

local uDim2 = UDim2.new(0, 0, 0, -88)
local uDim2_2 = UDim2.fromOffset(0, 0)

local tbl1 = { frequency = 5 }

local var1 = Roact.PureComponent:extend("FullscreenTitleBar")

var1.validateProps = t.strictInterface({
    title = t.string,
    isTriggered = t.optional(t.boolean),
    onDisappear = t.optional(t.callback),
    onHover = t.optional(t.callback),
    exitFullscreen = t.optional(t.callback),
    closeRoblox = t.optional(t.callback)
})

function var1.init(arg1)
    local num1 = if arg1.props.isTriggered then 1 else 0

    local progress, var3 = Roact.createBinding(num1)
    arg1.progress = progress

    local exitControlState, setExitControlState = Roact.createBinding(ControlState.Default)
    arg1.exitControlState = exitControlState
    arg1.setExitControlState = setExitControlState
    local closeControlState, setCloseControlState = Roact.createBinding(ControlState.Default)
    arg1.closeControlState = closeControlState
    arg1.setCloseControlState = setCloseControlState

    arg1.titleBarPosition = arg1.progress:map(function(arg2)
        return uDim2:lerp(uDim2_2, arg2)
    end)

    arg1.progressMotor = Otter.createSingleMotor(num1)
    arg1.progressMotor:onStep(var3)
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font

        local backgroundUiDefault = theme.BackgroundUIDefault
        local textEmphasis = theme.TextEmphasis

        local header2 = font.Header2
        local textSize = header2.RelativeSize * font.BaseSize

        local backgroundTransparency = arg1.progress:map(function(arg3)
            local backgroundUiDefaultTransparency = backgroundUiDefault.Transparency
            return lerp(1, backgroundUiDefaultTransparency, arg3)
        end)

        local iconTransparency = Roact.joinBindings({ progress = arg1.progress, controlState = arg1.exitControlState }):map(function(arg3)
            local contextualPrimaryDefaultTransparency = theme.ContextualPrimaryDefault.Transparency
            local num1 = if arg3.controlState == ControlState.Pressed then 2 else 1
            return lerp(1, divideTransparency(contextualPrimaryDefaultTransparency, num1), arg3.progress)
        end)

        local var2 = Roact.joinBindings({ progress = arg1.progress, controlState = arg1.closeControlState }):map(function(arg3)
            local contextualPrimaryDefaultTransparency = theme.ContextualPrimaryDefault.Transparency
            local num1 = if arg3.controlState == ControlState.Pressed then 2 else 1
            return lerp(1, divideTransparency(contextualPrimaryDefaultTransparency, num1), arg3.progress)
        end)

        local textTransparency = arg1.progress:map(function(arg3)
            local textEmphasisTransparency = textEmphasis.Transparency
            return lerp(1, textEmphasisTransparency, arg3)
        end)

        local function renderCenterText()
            return Roact.createElement("TextLabel", {
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(header2.Font),
                Size = UDim2.new(1, 0, 0, textSize),
                Text = arg1.props.title,
                TextColor3 = textEmphasis.Color,
                TextSize = textSize,
                TextTransparency = textTransparency,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false
            })
        end

        local function renderRightButtons()
            return Roact.createFragment({
                ExitButton = Roact.createElement(IconButton, {
                    icon = Images["icons/actions/previewShrink"],
                    iconSize = IconSize.Medium,
                    iconTransparency = iconTransparency,
                    onActivated = arg1.props.exitFullscreen,
                    layoutOrder = 1,
                    onStateChanged = function(_, arg3)
                        arg1.setExitControlState(arg3)
                    end
                }),
                CloseButton = Roact.createElement(IconButton, {
                    icon = Images["icons/navigation/close"],
                    iconSize = IconSize.Medium,
                    iconTransparency = var2,
                    onActivated = arg1.props.closeRoblox,
                    layoutOrder = 2,
                    onStateChanged = function(_, arg3)
                        arg1.setCloseControlState(arg3)
                    end
                })
            })
        end

        local function renderMirrorButtons()
            local iconSize = getIconSize(IconSize.Medium)
            return Roact.createFragment({
                First = Roact.createElement("ImageLabel", { BackgroundTransparency = 1, Size = UDim2.fromOffset(iconSize, iconSize) }),
                Second = Roact.createElement("ImageLabel", { BackgroundTransparency = 1, Size = UDim2.fromOffset(iconSize, iconSize) })
            })
        end

        local createElement = Roact.createElement
        local tbl2 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = arg1.titleBarPosition,
            Size = UDim2.new(1, 0, 0, 88)
        }
        local tbl3 = {
            BarFrame = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.fromOffset(0, 0),
                Size = UDim2.new(1, 0, 0, 64),
                [Roact.Event.MouseLeave] = arg1.props.onDisappear,
                [Roact.Event.MouseEnter] = arg1.props.onHover
            }, {
                ThreeSectionBar = Roact.createElement(ThreeSectionBar, {
                    BackgroundColor3 = backgroundUiDefault.Color,
                    BackgroundTransparency = backgroundTransparency,
                    barHeight = 64,
                    marginLeft = 20,
                    contentPaddingLeft = UDim.new(0, 12),
                    renderLeft = renderMirrorButtons,
                    renderCenter = renderCenterText,
                    marginRight = 20,
                    contentPaddingRight = UDim.new(0, 12),
                    renderRight = renderRightButtons
                })
            }),
            ShadowFrame = Roact.createElement("Frame", {
                BackgroundTransparency = backgroundUiDefault.Transparency,
                BackgroundColor3 = backgroundUiDefault.Color,
                BorderSizePixel = 0,
                Position = UDim2.fromOffset(0, 64),
                Size = UDim2.new(1, 0, 0, 24)
            }, {
                UIGradient = Roact.createElement("UIGradient", {
                    Rotation = 90,
                    Color = ColorSequence.new(
                        { ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) }
                    ),
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.75), NumberSequenceKeypoint.new(1, 1) })
                })
            })
        }
        return createElement("Frame", tbl2, tbl3)
    end)
end

function var1.didMount(arg1)
    arg1.progressMotor:start()
end

function var1.didUpdate(arg1, arg2, _)
    if arg2.isTriggered ~= arg1.props.isTriggered then
        local num1 = if arg1.props.isTriggered then 1 else 0
        arg1.progressMotor:setGoal(Otter.spring(num1, tbl1))
    end
end

function var1.willUnmount(arg1)
    arg1.progressMotor:destroy()
end

return var1
