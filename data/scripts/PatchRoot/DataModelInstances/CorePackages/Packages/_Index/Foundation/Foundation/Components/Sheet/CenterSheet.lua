-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:31:04Z
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
local CloseAffordanceVariant = require(Foundation.Enums.CloseAffordanceVariant)
local Flags = require(Foundation.Utility.Flags)
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

local Backdrop = require(Foundation.Components.Backdrop)
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
    local transparency, var12 = useAnimatedBinding(1, function()
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
    local var20, var21 = React.useBinding(0)
    local fullBleedHeight = var20
    local setFullBleedHeight = var21

    local innerScrollY, setInnerScrollY = React.useBinding(0)
    local var26, var27 = React.useBinding(0)

    local var28 = React.useRef(nil)
    local var29, setContentStartRef = React.useState(nil)

    local var31 = React.useMemo(function(): Frame
        local frame = Instance.new("Frame")
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0
        frame.AutomaticSize = Enum.AutomaticSize.XY
        return frame
    end, {})
    React.useEffect(function()
        return function()
            var31:Destroy()
        end
    end, {})

    local var4 = React.useCallback(function(arg2)
        if arg2 then
            var31.Parent = arg2
            return
        end

        var31.Parent = nil
    end, {})

    React.useEffect(function()
        if reducedMotion then
            var14((Otter.instant(0)))
            var12((Otter.instant(0)))
            return
        end
        var14(Otter.ease(0, { easingStyle = var3.Ease.StandardOut, duration = var3.Time.Time_300 }))

        var12(Otter.ease(0, { duration = var3.Time.Time_100 }))
    end, {})

    local var33 = React.useCallback(function()
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
        return { close = var33 }
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
            closeSheet = var33,
            hasRadius = true,
            sheetType = SheetType.Center,
            testId = var1.testId,
            closeAffordanceRef = var28,
            contentStartRef = var29,
            setContentStartRef = setContentStartRef
        }
    end, {
        var1.testId,
        var33,
        var29,
        var28,
        sheetContentHeight,
        hasFullBleed
    })

    local createElement = React.createElement
    local var35 = View

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
        var27(arg2.AbsoluteSize.Y)
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
    local var36 = View
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
        var36,
        tbl4,
        React.createElement(
            SheetContext.Provider,
            { value = value },
            React.createElement(ElevationOwnerScope, { owner = owner }, var1.children)
        )
    )

    tbl3.CloseAffordance = React.createElement(CloseAffordance, {
        onActivated = var33,
        ref = var28,
        NextSelectionDown = var29,
        variant = if hasFullBleed then CloseAffordanceVariant.OverMedia else CloseAffordanceVariant.Utility,
        Position = UDim2.new(1, -var3.Margin.Small, 0, var3.Margin.Small),
        AnchorPoint = Vector2.new(1, 0),
        Visible = hasHeader:map(function(bool1: boolean): boolean
            return not bool1
        end),
        testId = `{var1.testId}--close-affordance`
    })

    local sheet = createElement(var35, tbl2, tbl3)
    local element2

    if Flags.FoundationCenterSheetOverlayShadow then
        element2 = React.createElement(View, {
            tag = "shadow-overlay-300 radius-large",
            Size = var26:map(function(yOffset: number): UDim2
                return UDim2.new(1, 0, 0, yOffset)
            end),
            ZIndex = 1,
            testId = `{var1.testId}--shadow`
        })
    else
        element2 = React.createElement(Image, {
            Image = SHADOW_IMAGE,
            Size = var26:map(function(num1: number): UDim2
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
    end

    if var2 then
        local createElement3 = React.createElement
        local fragment = React.Fragment
        local var37 = nil
        local tbl5 = { OverlayPortal = 0, SheetContent = 0 }
        local createPortal = ReactRoblox.createPortal
        local createElement4 = React.createElement
        local var38 = View
        local tbl6 = {
            ZIndex = owner.zIndex,
            tag = "size-full",
            testId = `{var1.testId}--surface`
        }
        local tbl7 = { ShadowHost = 0, SheetContainer = 0, Backdrop = 0 }
        local var39

        if Flags.FoundationCenterSheetOverlayShadow then
            local createElement5 = React.createElement
            local var40 = View
            local tbl8 = {
                ZIndex = 2,
                sizeConstraint = 0,
                Position = 0,
                tag = "anchor-center-center size-full",
                GroupTransparency = 0
            }
            local sizeConstraint = { MaxSize = 0 }
            local new = Vector2.new
            local var41 = x + math.max(0, var3.Size.Size_1400 - var3.Padding.Medium) * 2

            local var42 = var3.Size.Size_1400 - var3.Padding.Medium
            sizeConstraint.MaxSize = new(var41, y + math.max(0, var42) + math.max(0, var3.Size.Size_1400 + var3.Size.Size_1200 - var3.Padding.Medium))
            tbl8.sizeConstraint = sizeConstraint

            tbl8.Position = var13:map(function(yOffset: number): UDim2
                return UDim2.new(0.5, 0, 0.5, yOffset)
            end)

            tbl8.GroupTransparency = var13:map(function(num1: number)
                return num1 / size800
            end)

            var39 = createElement5(var40, tbl8, {
                SheetContainer = React.createElement(View, {
                    ref = var4,
                    ZIndex = 2,
                    sizeConstraint = {
                        MaxSize = Vector2.new(x, y)
                    },
                    Position = UDim2.fromScale(0.5, 0.5),
                    tag = "col align-y-center anchor-center-center size-full padding-medium",
                    testId = `{var1.testId}--center-sheet-container`,
                    onAbsoluteSizeChanged = function(arg2)
                        local var43 = var3.Margin.Medium * 2
                        var6(math.min(arg2.AbsoluteSize.Y - var43, y))
                    end
                }, nil)
            })
        else
            var39 = nil
        end

        tbl7.ShadowHost = var39
        local var40

        if Flags.FoundationCenterSheetOverlayShadow then
            var40 = nil
        else
            local createElement5 = React.createElement
            local var41 = View

            local tbl8 = {
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
                onAbsoluteSizeChanged = 0
            }

            function tbl8.onAbsoluteSizeChanged(arg2)
                local var42 = var3.Margin.Medium * 2
                var6(math.min(arg2.AbsoluteSize.Y - var42, y))
            end

            var40 = createElement5(var41, tbl8, nil)
        end

        tbl7.SheetContainer = var40
        local element3

        if Flags.FoundationCenterSheetInternalBackdrop then
            element3 = React.createElement(
                Backdrop,
                {
                    transparency = transparency,
                    onActivated = var33,
                    ZIndex = 1,
                    testId = `{var1.testId}--backdrop`
                }
            )
        else
            element3 = React.createElement(View, {
                Size = UDim2.fromScale(2, 2),
                Position = UDim2.fromScale(-0.5, -0.5),
                ZIndex = 1,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                backgroundStyle = transparency:map(function(num1: number)
                    return {
                        Color3 = var3.Color.Common.Backdrop.Color3,
                        Transparency = math.lerp(var3.Color.Common.Backdrop.Transparency, 1, num1)
                    }
                end),
                onActivated = var33,
                testId = `{var1.testId}--backdrop`
            })
        end

        tbl7.Backdrop = element3
        tbl5.OverlayPortal = createPortal(createElement4(var38, tbl6, tbl7), var2)

        tbl5.SheetContent = ReactRoblox.createPortal({ Sheet = sheet, Shadow = element2 }, var31)
        var2 = createElement3(fragment, var37, tbl5)
    end

    return var2
end))
