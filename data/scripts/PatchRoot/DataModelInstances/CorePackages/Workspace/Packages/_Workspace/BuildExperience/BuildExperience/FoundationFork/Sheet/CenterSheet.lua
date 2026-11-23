-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = game:GetService("CorePackages").Packages._Index.Foundation.Foundation
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)
local ReactRoblox = require(FoundationParent.ReactRoblox)
local useAnimatedBinding = ReactOtter.useAnimatedBinding
local CloseAffordanceVariant = require(Foundation.Enums.CloseAffordanceVariant)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local useOverlay = require(Foundation.Providers.Overlay.useOverlay)
local useScaledValue = require(Foundation.Utility.useScaledValue)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)
local DIALOG_SIZES = require(Foundation.Components.Dialog.useDialogVariants).DIALOG_SIZES
local Constants = require(Foundation.Constants)
local DialogSize = require(Foundation.Enums.DialogSize)

local ElevationLayer = require(Foundation.Enums.ElevationLayer)

local useElevation = require(Foundation.Providers.Elevation.useElevation)
local ElevationOwnerScope = require(Foundation.Providers.Elevation.ElevationProvider).ElevationOwnerScope

local usePreferences = require(Foundation.Providers.Preferences.usePreferences)

local SheetContext = require(script.Parent.SheetContext)
local Types = require(script.Parent.Types)

local SheetType = require(script.Parent.SheetType)

local childrenHasFullBleed = require(script.Parent.childrenHasFullBleed)

local CloseAffordance = require(Foundation.Components.CloseAffordance)
local Image = require(Foundation.Components.Image)
local View = require(Foundation.Components.View)

local tbl1 = {
    size = DialogSize.Medium,
    testId = "--foundation-sheet"
}

local SHADOW_IMAGE = Constants.SHADOW_IMAGE
local SHADOW_SIZE = Constants.SHADOW_SIZE

return React.memo(React.forwardRef(function(arg1, ref) -- name: CenterSheet
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useOverlay()
    local var3 = useTokens()
    local owner = useElevation(ElevationLayer.Sheet, { stackAboveOwner = false })

    local reducedMotion = usePreferences().reducedMotion

    local x = useScaledValue(DIALOG_SIZES[var1.size])
    local y = useScaledValue(600)
    local size800 = var3.Size.Size_800

    local var5, var6 = React.useBinding(y)

    local sheetContentHeight = if var5 then var5:map(function(num1: number)
        if var1.centerSheetHeight then
            if var1.centerSheetHeight > 0 and var1.centerSheetHeight <= 1 then
                return num1 * var1.centerSheetHeight
            end

            if var1.centerSheetHeight > 1 then
                return math.min(var1.centerSheetHeight, num1)
            end
        end
        return nil
    end) else nil

    local var8, var9 = React.useState(true)

    local var10 = React.useRef(false)
    local var11, var12 = useAnimatedBinding(1, function()
        if var10.current then
            var1.onClose()
        end
    end)

    local var13, var14 = useAnimatedBinding(size800, function()
        var9(false)
    end)

    local hasActionsDivider, setHasActionsDivider = React.useBinding(false)
    local hasHeader, setHasHeader = React.useBinding(false)
    local hasFullBleed = childrenHasFullBleed(var1.children)
    local fullBleedHeight, setFullBleedHeight = React.useBinding(0)

    local innerScrollY, setInnerScrollY = React.useBinding(0)
    local var24, var25 = React.useBinding(0)

    local var26 = React.useRef(nil)
    local var27, setContentStartRef = React.useState(nil)

    local var29 = React.useMemo(function(): Frame
        local frame = Instance.new("Frame")
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0
        frame.AutomaticSize = Enum.AutomaticSize.XY
        return frame
    end, {})

    React.useEffect(function()
        return function()
            var29:Destroy()
        end
    end, { var29 })

    local var4 = React.useCallback(function(arg2)
        if arg2 then
            var29.Parent = arg2
            return
        end

        var29.Parent = nil
    end, { var29 })

    React.useEffect(function()
        if reducedMotion then
            var14((Otter.instant(0)))
            var12((Otter.instant(0)))
            return
        end
        var14(Otter.ease(0, { easingStyle = var3.Ease.StandardOut, duration = var3.Time.Time_300 }))

        var12(Otter.ease(0, { duration = var3.Time.Time_100 }))
    end, {})

    local var31 = React.useCallback(function()
        if var10.current then
            return
        end

        if reducedMotion then
            var10.current = true
            var14(Otter.instant(size800))
            var12(Otter.instant(1))
            return
        end
        var14(Otter.ease(size800, { easingStyle = var3.Ease.StandardIn, duration = var3.Time.Time_100 }))

        var12(Otter.ease(1, { duration = var3.Time.Time_100 }))

        var9(true)
        var10.current = true
    end, { size800, reducedMotion })

    React.useImperativeHandle(var1.sheetRef, function()
        return { close = var31 }
    end, {})

    local value = React.useMemo(function()
        return {
            actionsHeight = 0,
            setActionsHeight = Dash.noop,
            hasActionsDivider = hasActionsDivider,
            setHasActionsDivider = setHasActionsDivider,
            sheetContentHeight = sheetContentHeight,
            setSheetContentHeight = Dash.noop,
            sheetHeightAvailable = 0,
            setSheetHeightAvailable = Dash.noop,
            safeAreaPadding = 0,
            bottomPadding = 0,
            innerScrollingEnabled = true,
            innerScrollY = innerScrollY,
            setInnerScrollY = setInnerScrollY,
            hasHeader = hasHeader,
            setHasHeader = setHasHeader,
            hasFullBleed = hasFullBleed,
            fullBleedHeight = fullBleedHeight,
            setFullBleedHeight = setFullBleedHeight,
            closeSheet = var31,
            hasRadius = true,
            sheetType = SheetType.Center,
            testId = var1.testId,
            closeAffordanceRef = var26,
            contentStartRef = var27,
            setContentStartRef = setContentStartRef
        }
    end, {
        var1.testId,
        var31,
        var27,
        var26,
        sheetContentHeight,
        hasFullBleed
    })

    local createElement = React.createElement
    local var33 = View

    local tbl2 = {
        ClipsDescendants = true,
        Size = if var1.centerSheetHeight and sheetContentHeight then sheetContentHeight:map(function(yOffset: number?)
            if yOffset then
                return UDim2.new(1, 0, 0, yOffset)
            end

            return nil
        end) else nil,
        sizeConstraint = var1.centerSheetHeight and var5 and {
            MaxSize = var5:map(function(y2: number): Vector2
                return Vector2.new(math.huge, y2)
            end)
        } or nil,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        ZIndex = 2,
        onActivated = Dash.noop,
        onAbsoluteSizeChanged = 0,
        ref = 0,
        selection = 0,
        selectionGroup = 0,
        tag = 0,
        testId = 0
    }

    function tbl2.onAbsoluteSizeChanged(arg2)
        var25(arg2.AbsoluteSize.Y)
    end
    tbl2.ref = ref
    tbl2.selection = Types.nonSelectable
    tbl2.selectionGroup = Types.isolatedSelectionGroup
    tbl2.tag = {
        ["bg-surface-100 stroke-default stroke-standard radius-large"] = true,
        ["size-full-0 auto-y"] = var1.centerSheetHeight == nil
    }
    tbl2.testId = var1.testId
    local tbl3 = { Content = 0, CloseAffordance = 0 }
    local createElement2 = React.createElement
    local var34 = View
    local tbl4 = {
        Size = if var1.centerSheetHeight and sheetContentHeight then sheetContentHeight:map(function(yOffset: number?)
            if yOffset then
                return UDim2.new(1, 0, 0, yOffset)
            end

            return nil
        end) else nil,
        tag = "col items-center size-full-0 auto-y clip"
    }

    tbl3.Content = createElement2(
        var34,
        tbl4,
        React.createElement(
            SheetContext.Provider,
            { value = value },
            React.createElement(ElevationOwnerScope, { owner = owner }, var1.children)
        )
    )

    tbl3.CloseAffordance = React.createElement(CloseAffordance, {
        onActivated = var31,
        ref = var26,
        NextSelectionDown = var27,
        variant = if hasFullBleed then CloseAffordanceVariant.OverMedia else CloseAffordanceVariant.Utility,
        Position = UDim2.new(1, -var3.Margin.Small, 0, var3.Margin.Small),
        AnchorPoint = Vector2.new(1, 0),
        Visible = hasHeader:map(function(bool1: boolean): boolean
            return not bool1
        end),
        testId = `{var1.testId}--close-affordance`
    })

    local sheet = createElement(var33, tbl2, tbl3)

    local shadow = React.createElement(Image, {
        Image = SHADOW_IMAGE,
        Size = var24:map(function(num1: number): UDim2
            return UDim2.new(1, SHADOW_SIZE * 2, 0, num1 + SHADOW_SIZE * 2)
        end),
        Position = UDim2.new(0, -SHADOW_SIZE, 0.5, 0),
        ZIndex = 1,
        slice = {
            center = Rect.new(SHADOW_SIZE, SHADOW_SIZE, SHADOW_SIZE + 1, SHADOW_SIZE + 1),
            scale = 2
        },
        imageStyle = var3.Color.Extended.Black.Black_10,
        tag = "anchor-center-left"
    })

    if var2 then
        local createElement3 = React.createElement
        local fragment = React.Fragment
        local var35 = nil
        local tbl5 = { OverlayPortal = 0, SheetContent = 0 }
        local createPortal = ReactRoblox.createPortal
        local createElement4 = React.createElement
        local var36 = View
        local tbl6 = {
            ZIndex = owner.zIndex,
            tag = "size-full",
            testId = `{var1.testId}--surface`
        }

        local tbl7 = {
            SheetContainer = React.createElement(View, {
                ref = var4,
                ZIndex = 2,
                sizeConstraint = {
                    MaxSize = Vector2.new(x, y)
                },
                Position = var13:map(function(yOffset: number): UDim2
                    return UDim2.new(0.5, 0, 0.5, yOffset)
                end),
                tag = "col align-y-center anchor-center-center size-full padding-medium",
                testId = `{var1.testId}--center-sheet-container`,
                GroupTransparency = if var8 then var13:map(function(num1: number)
                    return num1 / size800
                end) else nil,
                onAbsoluteSizeChanged = var1.centerSheetHeight and var6 and function(arg2)
                    local var37 = var3.Margin.Medium * 2
                    var6(math.min(arg2.AbsoluteSize.Y - var37, y))
                end or nil
            }),
            Backdrop = React.createElement(View, {
                Size = UDim2.fromScale(2, 2),
                Position = UDim2.fromScale(-0.5, -0.5),
                ZIndex = 1,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                backgroundStyle = var11:map(function(num1: number)
                    return {
                        Color3 = var3.Color.Common.Backdrop.Color3,
                        Transparency = math.lerp(var3.Color.Common.Backdrop.Transparency, 1, num1)
                    }
                end),
                onActivated = var31,
                testId = `{var1.testId}--backdrop`
            })
        }

        tbl5.OverlayPortal = createPortal(createElement4(var36, tbl6, tbl7), var2)

        tbl5.SheetContent = ReactRoblox.createPortal({ Sheet = sheet, Shadow = shadow }, var29)
        var2 = createElement3(fragment, var35, tbl5)
    end

    return var2
end))
