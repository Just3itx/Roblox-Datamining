-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Core = scriptParentParentParent.Core

local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)
local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)
local t = require(scriptParentParentParentParent.t)
local Foundation = require(scriptParentParentParentParent.Foundation)
local FoundationButtonUtils = require(scriptParent.FoundationButtonUtils)

local validateImage = require(Core.ImageSet.Validator.validateImage)
local validateFontInfo = require(Core.Style.Validator.validateFontInfo)
local validateTypographyInfo = require(scriptParentParentParent.Core.Style.Validator.validateTypographyInfo)

local ButtonType = require(scriptParent.Enum.ButtonType)
local StandardButtonSize = require(Core.Button.Enum.StandardButtonSize)
local GenericButton = require(Core.Button.GenericButton)
local ControlState = require(Core.Control.Enum.ControlState)

local isReactTagProp = require(scriptParentParentParent.Utility.isReactTagProp)

local Images = require(scriptParentParent.ImageSet.Images)
local CursorKind = require(scriptParentParent.SelectionImage.CursorKind)
local withSelectionCursorProvider = require(scriptParentParent.SelectionImage.withSelectionCursorProvider)
local useCursor = require(scriptParentParentParent.App.SelectionCursor.useCursor)
local UIBloxConfig = require(scriptParentParentParent.UIBloxConfig)

local var1 = React.PureComponent:extend("Button")

local tbl1 = {
    [ButtonType.Alert] = {
        [ControlState.Default] = "Alert"
    },
    [ButtonType.PrimaryContextual] = {
        [ControlState.Default] = "ContextualPrimaryDefault",
        [ControlState.Hover] = "ContextualPrimaryOnHover"
    },
    [ButtonType.PrimarySystem] = {
        [ControlState.Default] = "SystemPrimaryDefault",
        [ControlState.Hover] = "SystemPrimaryOnHover"
    },
    [ButtonType.Secondary] = {
        [ControlState.Default] = "SecondaryDefault",
        [ControlState.Hover] = "SecondaryOnHover"
    }
}

local tbl2 = {
    [ButtonType.Alert] = {
        [ControlState.Default] = "Alert"
    },
    [ButtonType.PrimaryContextual] = {
        [ControlState.Default] = "ContextualPrimaryContent"
    },
    [ButtonType.PrimarySystem] = {
        [ControlState.Default] = "SystemPrimaryContent"
    },
    [ButtonType.Secondary] = {
        [ControlState.Default] = "SecondaryContent",
        [ControlState.Hover] = "SecondaryOnHover"
    }
}

local tbl3 = {
    [ButtonType.Alert] = Images["component_assets/circle_17_stroke_1"],
    [ButtonType.PrimaryContextual] = Images["component_assets/circle_17"],
    [ButtonType.PrimarySystem] = Images["component_assets/circle_17"],
    [ButtonType.Secondary] = Images["component_assets/circle_17_stroke_1"]
}

local tbl4 = {
    [ButtonType.PrimaryContextual] = Images["component_assets/bulletRight_17"],
    [ButtonType.PrimarySystem] = Images["component_assets/bulletRight_17"]
}

local tbl5 = {
    [ButtonType.Alert] = false,
    [ButtonType.PrimaryContextual] = true,
    [ButtonType.PrimarySystem] = false,
    [ButtonType.Secondary] = false
}

local uDim = UDim.new(0, 8)

local strictInterface = t.strictInterface
local tbl6 = {
    [React.Tag] = isReactTagProp,
    buttonType = t.optional(ButtonType.isEnumValue),
    automaticSize = t.optional(t.EnumItem),
    size = t.optional(t.UDim2),
    standardSize = t.optional(StandardButtonSize.isEnumValue),
    maxWidth = t.optional(t.numberPositive),
    fitContent = t.optional(t.boolean),
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    layoutOrder = t.optional(t.number),
    icon = t.optional(validateImage),
    text = t.optional(t.string),
    inputIcon = t.optional(validateImage),
    fontStyle = t.optional(t.union(t.string, validateFontInfo, validateTypographyInfo)),
    buttonTextOverride = t.optional(t.table),
    isDisabled = t.optional(t.boolean),
    isLoading = t.optional(t.boolean),
    isHoverBackgroundEnabled = t.optional(t.boolean),
    isDelayedInput = t.optional(t.boolean),
    enableInputDelayed = t.optional(t.boolean),
    delayInputSeconds = t.optional(t.numberPositive),
    onActivated = t.callback,
    onStateChanged = t.optional(t.callback),
    userInteractionEnabled = t.optional(t.boolean),
    feedbackType = t.optional(t.string),
    Selectable = t.optional(t.boolean),
    NextSelectionDown = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    buttonRef = t.optional(t.union(t.table, t.callback)),
    isRoactGamepadEnabled = t.optional(t.boolean),
    cursor = t.optional(t.any),
    DO_NOT_USE_useUIBloxButton = t.optional(t.boolean),
    [React.Change.AbsoluteSize] = t.optional(t.callback),
    [React.Change.AbsolutePosition] = t.optional(t.callback)
}
var1.validateProps = strictInterface(tbl6)

var1.defaultProps = {
    buttonType = ButtonType.PrimarySystem,
    isDisabled = false,
    isLoading = false,
    isRoactGamepadEnabled = true
}

function var1.render(arg1)
    return withSelectionCursorProvider(function(arg2)
        local isRoactGamepadEnabled = arg1.props.isRoactGamepadEnabled
        return React.createElement(if isRoactGamepadEnabled then RoactGamepad.Focusable[GenericButton] else GenericButton, {
            [React.Tag] = arg1.props[React.Tag],
            Size = arg1.props.size,
            standardSize = arg1.props.standardSize,
            maxWidth = arg1.props.maxWidth,
            fitContent = arg1.props.fitContent,
            AnchorPoint = arg1.props.anchorPoint,
            Position = arg1.props.position,
            LayoutOrder = arg1.props.layoutOrder,
            SelectionImageObject = if arg1.props.cursor then arg1.props.cursor else arg2(CursorKind.RoundedRectNoInset),
            icon = arg1.props.icon,
            text = arg1.props.text,
            inputIcon = arg1.props.inputIcon,
            fontStyle = arg1.props.fontStyle,
            isDisabled = arg1.props.isDisabled,
            isLoading = arg1.props.isLoading,
            isHoverBackgroundEnabled = tbl5[arg1.props.buttonType],
            isDelayedInput = arg1.props.isDelayedInput,
            enableInputDelayed = arg1.props.enableInputDelayed,
            delayInputSeconds = arg1.props.delayInputSeconds,
            onActivated = arg1.props.onActivated,
            onStateChanged = arg1.props.onStateChanged,
            userInteractionEnabled = arg1.props.userInteractionEnabled,
            buttonImage = tbl3[arg1.props.buttonType],
            delayedInputImage = tbl4[arg1.props.buttonType],
            buttonStateColorMap = tbl1[arg1.props.buttonType],
            contentStateColorMap = tbl2[arg1.props.buttonType],
            buttonTextOverride = arg1.props.buttonTextOverride,
            Selectable = arg1.props.Selectable,
            NextSelectionUp = arg1.props.NextSelectionUp,
            NextSelectionDown = arg1.props.NextSelectionDown,
            NextSelectionLeft = arg1.props.NextSelectionLeft,
            NextSelectionRight = arg1.props.NextSelectionRight,
            ref = arg1.props.buttonRef,
            feedbackType = arg1.props.feedbackType,
            [React.Change.AbsoluteSize] = arg1.props[React.Change.AbsoluteSize],
            [React.Change.AbsolutePosition] = arg1.props[React.Change.AbsolutePosition]
        })
    end)
end

local function func1(arg1)
    local cursor = useCursor(uDim)
    local var3 = Cryo.Dictionary.join({ cursor = cursor }, arg1)

    return React.createElement(var1, var3)
end

local var2 = React.forwardRef(function(arg1, arg2)
    if not UIBloxConfig.useFoundationButton or arg1.DO_NOT_USE_useUIBloxButton then
        return React.createElement(func1, Cryo.Dictionary.join(arg1, { buttonRef = arg1.buttonRef or arg2 }))
    end

    local var2 = Foundation.Hooks.useTokens()
    local var3 = Cryo.Dictionary.join(var1.defaultProps, arg1)
    local isRoactGamepadEnabled = var3.isRoactGamepadEnabled

    local maxWidth = FoundationButtonUtils.getMaxWidth(var3.standardSize, var3.maxWidth)

    local var4 = React.useRef(nil)
    local ref = arg1.buttonRef or arg2 or var4

    React.useLayoutEffect(function()
        local uiSizeConstraint = nil
        if maxWidth and ref and typeof(ref) == "table" and ref.current then
            uiSizeConstraint = Instance.new("UISizeConstraint")
            local vector2 = Vector2.new(maxWidth, math.huge)
            uiSizeConstraint.MaxSize = vector2
            local current = ref.current
            uiSizeConstraint.Parent = current
        end

        return function()
            if uiSizeConstraint then
                uiSizeConstraint.Parent = nil
                uiSizeConstraint:Destroy()
            end
        end
    end, { maxWidth, ref })

    return React.createElement(
        if isRoactGamepadEnabled then RoactGamepad.Focusable[Foundation.Button] else Foundation.Button,
        {
            variant = FoundationButtonUtils.buttonMapping[var3.buttonType],
            size = FoundationButtonUtils.getSizeMapping(var3.standardSize, var3.size, var2),
            width = FoundationButtonUtils.getWidth(var3.standardSize, var3.size, var3.fitContent),
            icon = FoundationButtonUtils.findIcon(var3.icon),
            text = var3.text,
            isLoading = var3.isLoading,
            isDisabled = var3.isDisabled or var3.userInteractionEnabled == false or var3.isDelayedInput and not var3.enableInputDelayed,
            inputDelay = if var3.isDelayedInput and var3.enableInputDelayed then var3.delayInputSeconds or 3 else nil,
            onActivated = var3.onActivated,
            testId = FoundationButtonUtils.getTestId(var3[React.Tag]),
            ref = ref,
            AnchorPoint = var3.anchorPoint,
            Position = var3.position,
            LayoutOrder = var3.layoutOrder,
            onAbsoluteSizeChanged = var3[React.Change.AbsoluteSize],
            onAbsolutePositionChanged = var3[React.Change.AbsolutePosition],
            Selectable = var3.Selectable,
            NextSelectionUp = var3.NextSelectionUp,
            NextSelectionDown = var3.NextSelectionDown,
            NextSelectionLeft = var3.NextSelectionLeft,
            NextSelectionRight = var3.NextSelectionRight
        }
    )
end)

var2.validateProps = var1.validateProps

return var2
