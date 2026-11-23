-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:02Z
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
local Constants = require(Foundation.Constants)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local useOverlay = require(Foundation.Providers.Overlay.useOverlay)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)

local SheetContext = require(script.Parent.SheetContext)
local Types = require(script.Parent.Types)

local SheetType = require(script.Parent.SheetType)

local useElevation = require(Foundation.Providers.Elevation.useElevation)
local ElevationOwnerScope = require(Foundation.Providers.Elevation.ElevationProvider).ElevationOwnerScope
local ElevationLayer = require(Foundation.Enums.ElevationLayer)

local DialogSize = require(Foundation.Enums.DialogSize)

local childrenHasFullBleed = require(script.Parent.childrenHasFullBleed)
local useHardwareInsets = require(script.Parent.useHardwareInsets)
local useScreenSize = require(script.Parent.useScreenSize)

local CloseAffordance = require(Foundation.Components.CloseAffordance)
local Image = require(Foundation.Components.Image)
local View = require(Foundation.Components.View)

local usePreferences = require(Foundation.Providers.Preferences.usePreferences)

local tbl1 = {
    [DialogSize.Medium] = { TARGET_WIDTH = 0.4, MIN = 360, MAX = 440 },
    [DialogSize.Large] = { TARGET_WIDTH = 0.5, MIN = 440, MAX = 640 }
}

local tbl2 = {
    testId = "--foundation-sheet",
    size = DialogSize.Medium
}

local SHADOW_IMAGE = Constants.SHADOW_IMAGE
local SHADOW_SIZE = Constants.SHADOW_SIZE

return React.memo(React.forwardRef(function(arg1, ref) -- name: SideSheet
    local var1 = withDefaults(arg1, tbl2)
    local var2 = useOverlay()
    local var3 = useTokens()
    local owner = useElevation(ElevationLayer.Sheet, { stackAboveOwner = false })
    local reducedMotion = usePreferences().reducedMotion

    local var5 = useHardwareInsets(var2)
    local var6 = useScreenSize()
    local right = var5.right

    local bool1 = var1.displaySize == Enum.DisplaySize.Small

    local scale = var3.Config.UI.Scale
    local targetWidth = tbl1[var1.size].TARGET_WIDTH
    local num1 = math.clamp(var6.X * targetWidth, tbl1[var1.size].MIN * scale, tbl1[var1.size].MAX * scale)
    local medium = var3.Padding.Medium

    local var7 = React.useRef(false)
    local var8, var9 = useAnimatedBinding(1, function()
        if var7.current then
            var1.onClose()
        end
    end)

    local var10 = -(right + (if bool1 then 0 else medium))
    local var11, var12 = useAnimatedBinding(var10)

    local hasActionsDivider, setHasActionsDivider = React.useBinding(false)
    local hasHeader, setHasHeader = React.useBinding(false)
    local hasFullBleed = childrenHasFullBleed(var1.children)
    local fullBleedHeight, setFullBleedHeight = React.useBinding(0)

    local innerScrollY, setInnerScrollY = React.useBinding(0)

    local var22 = React.useRef(nil)
    local var23, setContentStartRef = React.useState(nil)

    React.useEffect(function()
        if reducedMotion then
            var12((Otter.instant(num1)))
            var9((Otter.instant(0)))
            return
        end
        var12(Otter.ease(num1, { easingStyle = var3.Ease.StandardOut, duration = var3.Time.Time_300 }))

        var9(Otter.ease(0, { duration = var3.Time.Time_100 }))
    end, { num1, reducedMotion })

    local var25 = React.useCallback(function()
        if var7.current then
            return
        end

        if reducedMotion then
            var7.current = true
            var12(Otter.instant(var10))
            var9(Otter.instant(1))
            return
        end
        var12(Otter.ease(var10, { easingStyle = var3.Ease.StandardIn, duration = var3.Time.Time_100 }))

        var9(Otter.ease(1, { duration = var3.Time.Time_100 }))

        var7.current = true
    end, { var10, reducedMotion })

    React.useImperativeHandle(var1.sheetRef, function()
        return { close = var25 }
    end, {})

    local uDim2 = UDim2.new(0, num1 + (if bool1 then right else 0), 1, if bool1 then 0 else -medium * 2)

    local var26 = var11:map(function(num2: number)
        return UDim2.new(1, if bool1 then -num2 else -(num2 + medium), 0, if bool1 then 0 else medium)
    end)

    local value = React.useMemo(function()
        return {
            actionsHeight = 0,
            setActionsHeight = Dash.noop,
            hasActionsDivider = hasActionsDivider,
            setHasActionsDivider = setHasActionsDivider,
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
            closeSheet = var25,
            hasRadius = not bool1,
            sheetType = SheetType.Side,
            testId = var1.testId,
            closeAffordanceRef = var22,
            contentStartRef = var23,
            setContentStartRef = setContentStartRef
        }
    end, {
        var1.testId,
        var25,
        var23,
        var22,
        hasFullBleed,
        bool1
    })

    if var2 then
        local createPortal = ReactRoblox.createPortal
        local createElement = React.createElement
        local var28 = View
        local tbl3 = {
            ZIndex = owner.zIndex,
            tag = "size-full",
            testId = `{var1.testId}--surface`
        }
        local tbl4 = { Sheet = 0, Shadow = 0, Backdrop = 0 }
        local createElement2 = React.createElement
        local var29 = View
        local tbl5 = {
            Size = uDim2,
            Position = var26,
            ClipsDescendants = true,
            ZIndex = 3,
            padding = bool1 and right > 0 and {
                right = UDim.new(0, right)
            } or nil,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = Dash.noop,
            ref = ref,
            selection = Types.nonSelectable,
            selectionGroup = Types.isolatedSelectionGroup,
            tag = {
                ["stroke-standard stroke-default bg-surface-100"] = true,
                ["radius-large"] = not bool1
            },
            testId = var1.testId
        }

        local tbl6 = {
            Content = React.createElement(
                View,
                { tag = "col items-center size-full-full clip" },
                React.createElement(
                    SheetContext.Provider,
                    { value = value },
                    React.createElement(ElevationOwnerScope, { owner = owner }, var1.children)
                )
            ),
            CloseAffordance = React.createElement(CloseAffordance, {
                onActivated = var25,
                ref = var22,
                NextSelectionDown = var23,
                variant = if hasFullBleed then CloseAffordanceVariant.OverMedia else CloseAffordanceVariant.Utility,
                Position = UDim2.new(1, -var3.Margin.Small, 0, var3.Margin.Small),
                AnchorPoint = Vector2.new(1, 0),
                Visible = hasHeader:map(function(bool2: boolean): boolean
                    return not bool2
                end),
                testId = `{var1.testId}--close-affordance`
            })
        }

        tbl4.Sheet = createElement2(var29, tbl5, tbl6)

        tbl4.Shadow = React.createElement(Image, {
            Image = SHADOW_IMAGE,
            Size = uDim2 + UDim2.fromOffset(SHADOW_SIZE * 2, SHADOW_SIZE * 2),
            Position = var26:map(function(uDim2_2: UDim2)
                return uDim2_2 + UDim2.fromOffset(-SHADOW_SIZE, -SHADOW_SIZE)
            end),
            ZIndex = 2,
            slice = {
                center = Rect.new(SHADOW_SIZE, SHADOW_SIZE, SHADOW_SIZE + 1, SHADOW_SIZE + 1),
                scale = 2
            },
            imageStyle = var3.Color.Extended.Black.Black_10
        })
        tbl4.Backdrop = React.createElement(View, {
            Size = UDim2.fromScale(2, 2),
            Position = UDim2.fromScale(-0.5, -0.5),
            ZIndex = 1,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            backgroundStyle = var8:map(function(num2: number)
                return {
                    Color3 = var3.Color.Common.Backdrop.Color3,
                    Transparency = math.lerp(var3.Color.Common.Backdrop.Transparency, 1, num2)
                }
            end),
            onActivated = var25,
            testId = `{var1.testId}--backdrop`
        })

        var2 = createPortal(createElement(var28, tbl3, tbl4), var2)
    end

    return var2
end))
