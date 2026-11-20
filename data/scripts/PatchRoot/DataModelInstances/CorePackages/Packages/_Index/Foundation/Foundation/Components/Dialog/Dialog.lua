-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)
local ReactRoblox = require(FoundationParent.ReactRoblox)
local useAnimatedBinding = ReactOtter.useAnimatedBinding

local Backdrop = require(Foundation.Components.Backdrop)
local CloseAffordance = require(Foundation.Components.CloseAffordance)
local Constants = require(Foundation.Constants)
local Image = require(Foundation.Components.Image)
local View = require(Foundation.Components.View)

local useOverlay = require(Foundation.Providers.Overlay.useOverlay)

local DialogSize = require(Foundation.Enums.DialogSize)
local OnCloseCallbackReason = require(Foundation.Enums.OnCloseCallbackReason)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)

local Flags = require(Foundation.Utility.Flags)
local useScaledValue = require(Foundation.Utility.useScaledValue)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local usePreferences = require(Foundation.Providers.Preferences.usePreferences)

local Types = require(script.Parent.Types)
local _Types = require(Foundation.Components.Types)
local useDialogVariants = require(script.Parent.useDialogVariants).useDialogVariants
local DialogProvider = require(script.Parent.DialogProvider)
local useDialog = require(script.Parent.useDialog)
local useDialogResponsiveSize = require(script.Parent.useDialogResponsiveSize)

local useElevation = require(Foundation.Providers.Elevation.useElevation)
local ElevationOwnerScope = require(Foundation.Providers.Elevation.ElevationProvider).ElevationOwnerScope
local ElevationLayer = require(Foundation.Enums.ElevationLayer)

local tbl1 = {
    size = DialogSize.Medium,
    disablePortal = true,
    hasBackdrop = false,
    testId = "--foundation-dialog"
}

local SHADOW_IMAGE = Constants.SHADOW_IMAGE
local SHADOW_SIZE = Constants.SHADOW_SIZE

local function Dialog(arg1)
    local var1 = Dash.assign({}, arg1, { LayoutOrder = 1 })
    local var2 = useDialogVariants()
    local x = useScaledValue(var2.inner.maxWidth)

    local var3, var4 = React.useBinding(Vector2.new(0, 0))

    local var5 = useOverlay()
    local owner = useElevation(ElevationLayer.Dialog, { stackAboveOwner = false })
    local var7 = useDialog()

    useDialogResponsiveSize(var1.size)

    local var8 = useTokens()
    local reducedMotion = usePreferences().reducedMotion

    local size800 = var8.Size.Size_800
    local var9, var10 = React.useState(true)

    local var11 = React.useRef(false)
    local var12 = React.useRef(nil)

    local var13, var14 = useAnimatedBinding(1)

    local var15, var16 = useAnimatedBinding(size800, function()
        if var11.current then
            if var1.onClose then
                var1.onClose(var12.current)
            end
        else
            var10(false)
        end
    end)

    React.useEffect(function()
        if reducedMotion then
            var16((Otter.instant(0)))
            var14((Otter.instant(0)))
            return
        end
        var16(Otter.ease(0, { easingStyle = var8.Ease.StandardOut, duration = var8.Time.Time_300 }))

        var14(Otter.ease(0, { duration = var8.Time.Time_100 }))
    end, {})

    local var17 = React.useCallback(function(current)
        if var11.current then
            return
        end
        var12.current = current
        if reducedMotion then
            var11.current = true
            var16(Otter.instant(size800))
            var14(Otter.instant(1))
            return
        end
        var16(Otter.ease(size800, { easingStyle = var8.Ease.StandardIn, duration = var8.Time.Time_200 }))

        var14(Otter.ease(1, { duration = var8.Time.Time_100 }))

        var10(true)
        var11.current = true
    end, { size800, reducedMotion })

    local var18 = React.useMemo(function(): Folder
        return Instance.new("Folder")
    end, {})

    React.useEffect(function()
        return function()
            var18:Destroy()
        end
    end, { var18 })

    local var19, var20 = React.useState(false)

    local var21 = React.useCallback(function(arg2)
        if arg2 then
            var18.Parent = arg2
            var20(true)
            return
        end
        var18.Parent = nil
        var20(false)
    end, { var18 })

    local createElement = React.createElement
    local var22 = View
    local tbl2 = {
        tag = var2.container.tag,
        ZIndex = 2
    }
    local tbl3 = { Shadow = 0 }
    local element

    if Flags.FoundationDialogOverlayShadow then
        element = React.createElement(View, {
            tag = "shadow-overlay-300 radius-large",
            Size = var3:map(function(vector2: Vector2): UDim2
                return UDim2.fromOffset(vector2.X, vector2.Y)
            end),
            testId = `{var1.testId}--shadow`
        })
    else
        element = React.createElement(Image, {
            Image = SHADOW_IMAGE,
            Size = var3:map(function(vector2: Vector2): UDim2
                return UDim2.fromOffset(vector2.X + SHADOW_SIZE * 2, vector2.Y + SHADOW_SIZE * 2)
            end),
            slice = {
                center = Rect.new(SHADOW_SIZE, SHADOW_SIZE, SHADOW_SIZE, SHADOW_SIZE),
                scale = 2
            },
            imageStyle = var2.shadow.imageStyle,
            testId = `{var1.testId}--shadow`
        })
    end

    tbl3.Shadow = element
    local dialogShadowWrapper = createElement(var22, tbl2, tbl3)

    local createElement2 = React.createElement
    local var23 = View
    local tbl4 = {
        tag = var2.container.tag,
        ZIndex = 3
    }
    local tbl5 = { DialogInner = 0 }
    local createElement3 = React.createElement
    local var24 = View
    local var25 = withCommonProps(var1, {
        tag = var2.inner.tag,
        ref = var1.forwardRef,
        sizeConstraint = {
            MaxSize = Vector2.new(x, math.huge)
        },
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        selection = Types.nonSelectable,
        selectionGroup = Types.isolatedSelectionGroup,
        onActivated = Dash.noop
    })
    local tbl6 = { CloseAffordance = 0, DialogBody = 0 }
    local element3

    if var1.onClose then
        element3 = React.createElement(CloseAffordance, {
            onActivated = var17 and not reducedMotion and var17 or var1.onClose,
            ref = var7.closeAffordanceRef,
            NextSelectionDown = var7.contentStartRef,
            Position = UDim2.new(1, -var2.closeAffordance.offset, 0, var2.closeAffordance.offset),
            AnchorPoint = Vector2.new(1, 0),
            ZIndex = 2,
            testId = `{var1.testId}--close-affordance`
        })
    else
        element3 = nil
    end

    tbl6.CloseAffordance = element3

    tbl6.DialogBody = React.createElement(View, {
        tag = var2.body.tag,
        onAbsoluteSizeChanged = function(arg2)
            local absoluteSize = arg2.AbsoluteSize
            if absoluteSize.X > 0 and absoluteSize.Y > 0 then
                var4(absoluteSize)
            end
        end,
        testId = `{var1.testId}--body`
    }, React.createElement(ElevationOwnerScope, { owner = owner }, var1.children))

    tbl5.DialogInner = createElement3(var24, var25, tbl6)
    local dialog = createElement2(var23, tbl4, tbl5)

    local createElement4 = React.createElement
    local var26 = View
    local tbl7 = {
        ZIndex = owner.zIndex,
        tag = "size-full padding-y-xlarge",
        testId = `{var1.testId}--container`
    }
    local tbl8 = { Backdrop = 0, DialogContentWrapper = 0 }
    local var27

    if var1.hasBackdrop then
        if Flags.FoundationDialogInternalBackdrop then
            local createElement5 = React.createElement
            local var28 = Backdrop
            local tbl9 = { transparency = 0, onActivated = 0, ZIndex = 2, testId = 0 }
            if reducedMotion then
                var13 = nil
            end

            tbl9.transparency = var13
            function tbl9.onActivated()
                if not var1.onClose then
                    return
                end

                if var17 and not reducedMotion then
                    var17(OnCloseCallbackReason.BackdropClick)
                    return
                end
                var1.onClose(OnCloseCallbackReason.BackdropClick)
            end

            tbl9.testId = `{var1.testId}--backdrop`
            var27 = createElement5(var28, tbl9)
        else
            local createElement5 = React.createElement
            local var28 = View

            local tbl9 = {
                tag = "position-center-center anchor-center-center",
                Size = UDim2.fromScale(2, 2),
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                onActivated = function()
                    if not var1.onClose then
                        return
                    end

                    if var17 and not reducedMotion then
                        var17(OnCloseCallbackReason.BackdropClick)
                        return
                    end
                    var1.onClose(OnCloseCallbackReason.BackdropClick)
                end,
                backgroundStyle = if not reducedMotion and var13 then var13:map(function(num1: number)
                    return {
                        Color3 = var2.backdrop.backgroundStyle.Color3,
                        Transparency = math.lerp(var2.backdrop.backgroundStyle.Transparency, 1, num1)
                    }
                end) else var2.backdrop.backgroundStyle,
                ZIndex = 2,
                testId = `{var1.testId}--backdrop`
            }

            var27 = createElement5(var28, tbl9)
        end
    else
        var27 = nil
    end

    tbl8.Backdrop = var27

    local createElement5 = React.createElement
    local var28 = View
    local tbl9 = {
        ref = 0,
        Position = 0,
        sizeConstraint = 0,
        testId = 0,
        tag = 0,
        ZIndex = 2,
        GroupTransparency = 0
    }

    if reducedMotion then
        var21 = nil
    end

    tbl9.ref = var21
    tbl9.Position = if reducedMotion or not var15 then nil else var15:map(function(yOffset: number): UDim2
        return UDim2.new(0.5, 0, 0.5, yOffset)
    end)

    local tbl10

    if reducedMotion then
        tbl10 = nil
    else
        tbl10 = { MaxSize = 0 }
        local new = Vector2.new
        local var29 = if Flags.FoundationDialogOverlayShadow then var8.Size.Size_1400 * 2 else SHADOW_SIZE * 2
        tbl10.MaxSize = new(x + var29, math.huge)
    end

    tbl9.sizeConstraint = tbl10

    tbl9.testId = `{var1.testId}--content-wrapper`
    tbl9.tag = {
        ["anchor-center-center size-full"] = not reducedMotion,
        ["size-full"] = reducedMotion
    }

    tbl9.GroupTransparency = if Flags.FoundationDialogOverlayShadow then if reducedMotion or not var15 then nil else var15:map(function(num1: number)
        return num1 / size800
    end) elseif reducedMotion or not (var9 and var15) then nil else var15:map(function(num1: number)
        return num1 / size800
    end)

    tbl8.DialogContentWrapper = createElement5(var28, tbl9, reducedMotion and { DialogShadowWrapper = dialogShadowWrapper, Dialog = dialog } or nil)
    local element4 = createElement4(var26, tbl7, tbl8)

    if not reducedMotion then
        if not var1.disablePortal and var5 ~= nil then
            element4 = ReactRoblox.createPortal(element4, var5)
        end
        return React.createElement(React.Fragment, nil, {
            Main = element4,
            StableContent = if var19 then ReactRoblox.createPortal(
                React.createElement(React.Fragment, nil, { DialogShadowWrapper = dialogShadowWrapper, Dialog = dialog }),
                var18
            ) else nil
        })
    elseif var1.disablePortal or var5 == nil then
        return element4
    else
        return ReactRoblox.createPortal(element4, var5)
    end
end
return React.memo(React.forwardRef(function(arg1, forwardRef) -- name: DialogContainer
    local var1 = withDefaults(arg1, tbl1)

    return React.createElement(
        DialogProvider,
        {
            size = var1.size,
            responsiveSize = var1.size,
            testId = var1.testId
        },
        {
            Dialog = React.createElement(Dialog, Dash.assign({}, var1, { forwardRef = forwardRef }))
        }
    )
end))
