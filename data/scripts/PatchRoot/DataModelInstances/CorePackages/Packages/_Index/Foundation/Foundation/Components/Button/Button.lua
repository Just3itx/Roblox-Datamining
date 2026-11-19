-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:21:14Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Motion = require(FoundationParent.Motion)
local useMotion = Motion.useMotion
local AnimatePresence = Motion.AnimatePresence

local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)

local InputSize = require(Foundation.Enums.InputSize)
local Spinner = require(script.Parent.Spinner)
local endAlignedIcons = require(script.Parent.endAlignedIcons)

local ButtonVariant = require(Foundation.Enums.ButtonVariant)

local FillBehavior = require(Foundation.Enums.FillBehavior)

local ControlState = require(Foundation.Enums.ControlState)

local ButtonIcon = require(script.Parent.ButtonIcon)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local Constants = require(Foundation.Constants)

local Flags = require(Foundation.Utility.Flags)
local withDefaults = require(Foundation.Utility.withDefaults)

local withCommonProps = require(Foundation.Utility.withCommonProps)

local useButtonMotionStates = require(script.Parent.useButtonMotionStates)
local useButtonVariants = require(script.Parent.useButtonVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local usePresentationContext = require(Foundation.Providers.Style.PresentationContext).usePresentationContext

local tbl1 = {
    [ButtonVariant.Link] = {
        format = "<u>%s</u>",
        controlState = { ControlState.Hover, ControlState.Pressed }
    }
}

local function onProgressChange(num1: number)
    return NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(math.max(0, num1 - 0.0001), 0),
        NumberSequenceKeypoint.new(math.min(1, num1 + 0.0001), Constants.DISABLED_TRANSPARENCY),
        NumberSequenceKeypoint.new(1, Constants.DISABLED_TRANSPARENCY)
    })
end

local function getTransparency(transparency: number?, transparency2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return transparency2:map(function(arg1)
        if transparency == nil then
            return arg1
        end

        return transparency + (1 - transparency) * arg1
    end)
end

local tbl2 = {
    isDisabled = false,
    isLoading = false,
    variant = ButtonVariant.Standard,
    size = InputSize.Medium,
    width = UDim.new(0, 0),
    inputDelay = 0,
    testId = "--foundation-button"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Button
    local var1 = withDefaults(arg1, tbl2)
    local inputDelay = var1.inputDelay

    local var2, onStateChanged = React.useBinding(ControlState.Initialize)
    local var4, var5 = React.useState(inputDelay > 0)
    local var6, var7 = ReactOtter.useAnimatedBinding(0, function()
        var5(false)
    end)

    local endAlignedIcon = var1.icon and endAlignedIcons[var1.icon]

    React.useEffect(function()
        if var4 == false then
            var7(ReactOtter.instant(0))
        end
    end, { var4 })

    React.useEffect(function()
        if var4 then
            var5(false)
        end

        if not (inputDelay > 0) then
            return
        end
        var5(true)
        var7((ReactOtter.ease(1, { duration = inputDelay, easingStyle = Enum.EasingStyle.Quad })))
    end, { inputDelay })

    local var8 = useTokens()
    local var9 = usePresentationContext()
    local var10 = useButtonVariants

    local size = var1.size
    local variant = var1.variant
    local colorNamespace = if var9 then var9.colorNamespace else nil
    local var11 = var10(var8, size, variant, colorNamespace)

    local var12 = useButtonMotionStates(var11.content.style.Transparency, Constants.DISABLED_TRANSPARENCY)
    local var13, var14 = useMotion(var12.Default)
    local var15, var16 = useMotion(var12.Default)

    React.useEffect(function()
        if var1.isLoading then
            var16(var12.Loading)
            return
        end
        var16(var12.Default)
    end, { var1.isLoading })

    React.useEffect(function()
        if var1.isDisabled then
            var14(var12.Disabled)
            return
        end
        var14(var12.Default)
    end, { var1.isDisabled })

    local cursor = React.useMemo(function()
        return {
            radius = UDim.new(0, var11.container.radius),
            offset = var8.Size.Size_200,
            borderWidth = var8.Stroke.Thicker
        }
    end, { var8, var11.container.radius })

    local var18 = var1.text and var1.text ~= ""

    local var19 = React.useCallback(function(arg2)
        local var19 = tbl1[var1.variant]
        if var18 and var19 and table.find(var19.controlState, arg2) then
            return (var19.format:format(var1.text))
        end
        return var1.text
    end, { var1.text, var1.variant, var18 })

    local createElement = React.createElement
    local var20 = View
    local var21 = withCommonProps

    local tbl3 = {
        AutomaticSize = if var1.width.Scale == 0 and var1.width.Offset == 0 then Enum.AutomaticSize.X else nil,
        cornerRadius = UDim.new(0, var11.container.radius),
        backgroundStyle = if var11.container.style then getTransparency(var11.container.style.Transparency, var13.transparency):map(function(transparency)
            return {
                Color3 = var11.container.style.Color3,
                Transparency = transparency
            }
        end) else nil,
        flexItem = if var1.fillBehavior then {
            FlexMode = if var1.fillBehavior == FillBehavior.Fill then Enum.UIFlexMode.Fill else Enum.UIFlexMode.Shrink
        } else nil,
        stroke = var11.container.stroke
            and {
                Color = var11.container.stroke.Color,
                Transparency = getTransparency(var11.container.stroke.Transparency, var13.transparency)
            }
            or nil,
        Size = UDim2.new(
            if var1.fillBehavior == FillBehavior.Fill then 1 else var1.width.Scale,
            if var1.fillBehavior == FillBehavior.Fill then 0 else var1.width.Offset,
            0,
            var11.container.height
        ),
        selection = {
            Selectable = not var1.isDisabled and var1.Selectable,
            NextSelectionUp = var1.NextSelectionUp,
            NextSelectionDown = var1.NextSelectionDown,
            NextSelectionLeft = var1.NextSelectionLeft,
            NextSelectionRight = var1.NextSelectionRight
        },
        cursor = cursor,
        onActivated = var1.onActivated,
        onStateChanged = onStateChanged,
        isDisabled = var1.isDisabled or var1.isLoading or var4,
        stateLayer = var11.container.stateLayer,
        tag = var11.container.tag,
        ref = ref
    }

    local var22 = var21(var1, tbl3)

    local tbl5 = { Loading = 0, IconWrapper = 0, Text = 0, Gradient = 0 }
    local var23

    if var1.isLoading then
        local createElement2 = React.createElement
        local str1 = "Folder"
        local tbl6 = {}
        local tbl7 = { PresenceWrapper = 0 }
        local createElement3 = React.createElement
        local var24 = AnimatePresence
        local tbl8 = {}

        local tbl9 = {
            Spinner = React.createElement(Spinner, {
                Size = var11.icon.size - (if Flags.FoundationUsePath2DSpinner then UDim2.fromOffset(var8.Padding.XSmall, var8.Padding.XSmall) else UDim2.fromOffset(0, 0)),
                style = var13.transparency:map(function(transparency)
                    return {
                        Color3 = var11.content.style.Color3,
                        Transparency = transparency
                    }
                end),
                testId = `{var1.testId}--spinner`
            })
        }

        tbl7.PresenceWrapper = createElement3(var24, tbl8, tbl9)
        var23 = createElement2(str1, tbl6, tbl7)
    else
        var23 = nil
    end

    tbl5.Loading = var23
    local element

    if var1.icon then
        element = React.createElement(View, {
            Size = if var1.icon then var11.icon.size else nil,
            LayoutOrder = var1.icon and (if endAlignedIcon then 3 else 1) or nil,
            testId = if var1.icon then `{var1.testId}--icon-wrapper` else nil
        }, {
            Icon = React.createElement(ButtonIcon, {
                icon = var1.icon,
                isLoading = var1.isLoading,
                variant = var1.variant,
                size = var1.size,
                disabledTransparencyBinding = var13.transparency,
                textTransparencyBinding = var15.textTransparency,
                testId = var1.testId
            })
        })
    else
        element = nil
    end

    tbl5.IconWrapper = element

    tbl5.Text = if var18 then React.createElement(Text, {
        Text = var2:map(var19),
        RichText = tbl1[var1.variant] ~= nil,
        tag = var11.text.tag,
        textStyle = React.joinBindings({ var13.transparency, var15.textTransparency }):map(function(arg2)
            local var24 = arg2[1]
            local var25 = arg2[2]
            return {
                Color3 = var11.content.style.Color3,
                Transparency = var25 + var24
            }
        end),
        LayoutOrder = 2,
        testId = `{var1.testId}--text`
    }) else nil

    tbl5.Gradient = if var4 then React.createElement("UIGradient", { Transparency = var6:map(onProgressChange) }) else nil
    return createElement(var20, var22, tbl5)
end))
