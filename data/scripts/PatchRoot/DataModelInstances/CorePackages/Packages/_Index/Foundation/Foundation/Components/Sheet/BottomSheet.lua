-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)
local ReactRoblox = require(FoundationParent.ReactRoblox)
local ReactUtils = require(FoundationParent.ReactUtils)
local useAnimatedBinding = ReactOtter.useAnimatedBinding
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local useElevation = require(Foundation.Providers.Elevation.useElevation)
local useOverlay = require(Foundation.Providers.Overlay.useOverlay)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)
local ElevationOwnerScope = require(Foundation.Providers.Elevation.ElevationProvider).ElevationOwnerScope
local ElevationLayer = require(Foundation.Enums.ElevationLayer)

local Constants = require(Foundation.Constants)
local Flags = require(Foundation.Utility.Flags)

local SheetContext = require(script.Parent.SheetContext)
local Types = require(script.Parent.Types)

local SheetType = require(script.Parent.SheetType)

local childrenHasFullBleed = require(script.Parent.childrenHasFullBleed)
local useHardwareInsets = require(script.Parent.useHardwareInsets)
local useScreenHeight = require(script.Parent.useScreenHeight)

local Backdrop = require(Foundation.Components.Backdrop)
local Image = require(Foundation.Components.Image)
local View = require(Foundation.Components.View)

local usePreferences = require(Foundation.Providers.Preferences.usePreferences)

local tbl1 = { defaultSnapPointIndex = 1, testId = "--foundation-sheet" }

local SHADOW_IMAGE = Constants.SHADOW_IMAGE
local SHADOW_SIZE = Constants.SHADOW_SIZE

local function advanceCriticalDampedSpring(num1: number, current: number, num2: number, deltaTime: number): (number, number) -- Luacid: Inlined by compiler; 1 call site recovered
    local num3 = num1 - num2
    local num4 = math.rad(1440) * deltaTime
    local num5 = math.exp(-num4)
    local num6 = current + math.rad(1440) * num3

    local num7 = (num3 + num6 * deltaTime) * num5
    local num8 = (current - num6 * num4) * num5

    return num2 + num7, num8
end

return React.memo(React.forwardRef(function(arg1, arg2) -- name: BottomSheet
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useOverlay()
    local var3 = useTokens()
    local owner = useElevation(ElevationLayer.Sheet, { stackAboveOwner = false })

    local reducedMotion = usePreferences().reducedMotion

    local var5 = useScreenHeight()

    local var6, var7 = React.useState(if var2 then var2.AbsoluteSize.Y else 0)
    local var8, var9 = React.useState(0)
    local var10 = React.useMemo(function()
        return { var8 }
    end, { var8 })
    local var11 = var1.snapPoints or var10

    local var12 = React.useCallback(function(num1: number)
        return if num1 > 1 then num1 else num1 * var5
    end, { var5 })

    local num1 = 0
    local huge = math.huge
    for _, value in var11 do
        local var13 = var12(value)
        if num1 < var13 then
            num1 = var13
        end

        if Flags.FoundationSheetReversedContent then
            huge = math.min(huge, var13)
        end
    end
    local num2 = math.min(num1, var5)
    if var6 > 0 then
        num2 = math.min(num2, var6)
    end
    if Flags.FoundationSheetReversedContent then
        huge = math.min(huge, num2)
    end

    local bottom = useHardwareInsets(var2).bottom

    local var13 = React.useRef(0)
    local var14 = React.useRef(false)

    local var15 = React.useRef(var1.onSnapPointChanged)
    var15.current = var1.onSnapPointChanged

    local transparency, var17 = useAnimatedBinding(1, function()
        if var14.current then
            var1.onClose()
        end
    end)
    local sheetHeightAvailable, setSheetHeightAvailable = React.useBinding(-bottom)
    local actionsHeight, setActionsHeight = React.useBinding(0)
    local hasActionsDivider, setHasActionsDivider = React.useBinding(false)
    local hasHeader, setHasHeader = React.useBinding(false)

    local hasFullBleed = childrenHasFullBleed(var1.children)
    local var27, var28 = React.useBinding(0)
    local fullBleedHeight = var27
    local setFullBleedHeight = var28

    local var31 = React.useRef(0)
    local ref = React.useRef(nil)
    local innerScrollY, var34 = React.useBinding(0)
    local innerScrollingRef = React.useRef(nil)
    local innerScrollingEnabled, var37 = React.useBinding(false)
    local var38 = if Flags.FoundationSheetReversedContent then React.useRef(false) else nil

    local setIsContentReversed = if Flags.FoundationSheetReversedContent then React.useCallback(function(current: boolean)
        var38.current = current
    end, {}) else nil

    local contentRevealOffset = if Flags.FoundationSheetReversedContent then React.useMemo(function()
        if var1.snapPoints == nil then
            return nil
        end
        return sheetHeightAvailable:map(function(num3: number): number
            local var40 = num3 + var3.Margin.Small
            return num2 - math.clamp(var40, huge, num2)
        end)
    end, {
        var1.snapPoints == nil,
        sheetHeightAvailable,
        huge,
        num2,
        var3.Margin.Small
    }) else nil

    local var41 = React.useRef(false)
    local var42 = React.useRef(0)
    local var43 = React.useRef(nil)
    local var44 = React.useRef(false)
    local var45 = React.useRef(0)

    local var46 = React.useRef(false)
    local var47, var48 = React.useState(false)
    local isVerticalSheetGesture = var47
    local var50 = var48
    local var51 = React.useCallback(function(current: boolean)
        if var46.current == current then
            return
        end
        var46.current = current
        var50(current)
    end, {})

    local var52 = React.useCallback(function()
        if var43.current then
            var43.current:Disconnect()
            var43.current = nil
        end
        var42.current = 0
        var44.current = false
    end, {})

    local var53 = React.useCallback(function(y: number)
        var52()
        var44.current = true

        if ref.current then
            ref.current:ResetScrollVelocity()
        end

        var43.current = game:GetService("RunService").Heartbeat:Connect(function(deltaTime: number)
            if not (ref.current and var44.current) then
                var52()
                return
            end

            local y2, current = advanceCriticalDampedSpring(ref.current.CanvasPosition.Y, var45.current, y, deltaTime)

            var45.current = current
            ref.current.CanvasPosition = Vector2.new(0, y2)
            local var53 = y - ref.current.CanvasPosition.Y

            if math.abs(var53) < 0.5 and math.abs(var45.current) < 1 then
                ref.current.CanvasPosition = Vector2.new(0, y)
                var52()
            end
        end)
    end, { var52 })

    local var54 = React.useCallback(function(num3: number): number
        return math.min(var12(num3), num2) + bottom
    end, { bottom, var12, num2 })

    local var55 = React.useCallback(function(current: number)
        var13.current = current
        var53(var54(var11[current]))
        if var15.current then
            var15.current(var11[current], current)
        end
    end, { var54, var11 })

    local var56 = React.useCallback(function(current: number)
        var52()
        var13.current = current
        if ref.current then
            ref.current.CanvasPosition = Vector2.new(0, var54(var11[current]))
        end
        if var15.current then
            var15.current(var11[current], current)
        end
    end, { var52, var54, var11 })

    local var57 = React.useCallback(function(bool1: boolean?)
        if var14.current then
            return
        end

        if reducedMotion and not bool1 then
            var14.current = true
            var52()
            if ref.current then
                ref.current.CanvasPosition = Vector2.new(0, 0)
            end
            var17((Otter.instant(1)))
        else
            var45.current = -var42.current
            var53(0)
            var17(Otter.ease(1, { duration = var3.Time.Time_100 }))

            var14.current = true
        end
    end, { var53, var52, reducedMotion })

    local var58 = React.useCallback(function(): boolean
        local num3 = math.floor(num2 + bottom)
        return var31.current >= num3 - 0.01
    end, { num2, bottom })

    local var59 = React.useCallback(function()
        local bool1 = innerScrollY:getValue() <= 0
        local var59 = var58()

        if not Flags.FoundationSheetReversedContent or not var38.current then
            if not var59 and var42.current < 0 or var42.current > 0 and bool1 and var41.current then
                var37(false)
            elseif (var42.current < 0 or var42.current == 0) and var59 then
                var37(true)
            end

            return
        end

        if var41.current and not (innerScrollingEnabled:getValue() or var59) then
            return
        end
        local current = innerScrollingRef.current
        local bool2 = current == nil or innerScrollY:getValue() >= current.AbsoluteCanvasSize.Y - current.AbsoluteWindowSize.Y - 1
        local current2 = var42.current
        local current3 = var41.current

        if current3 then
            if not (current2 > 0 and bool1) then
                if current2 < 0 then
                    bool1 = bool2 and not var59
                else
                    bool1 = false
                end
            end
        else
            bool1 = current3
        end
        var37(not bool1)
    end, { var58 })

    local var60 = React.useCallback(function()
        local current = var42.current
        local var60 = var31.current - current / 2.35

        local tbl2 = {{ index = 0, position = 0 }}

        for index, value2 in var11 do
            table.insert(tbl2, { index = index, position = var54(value2) })
        end

        table.sort(tbl2, function(arg3, arg4): boolean
            return math.abs(arg3.position - var60) < math.abs(arg4.position - var60)
        end)
        local var61 = tbl2[1]

        if var41.current then
            return
        end

        var45.current = -current
        if var61.index == 0 then
            var57(true)
            return
        end
        var55(var61.index)
    end, {
        var11,
        var55,
        var54,
        var57
    })

    local var61 = if Flags.FoundationBottomSheetKeepsSnapPoint then React.useCallback(function()
        local var61 = var11[var13.current]
        if var61 == nil or var12(var61) >= num2 then
            return
        end

        local num3 = 1
        for value, value2 in var11 do
            if var12(value2) > var12(var11[num3]) then
                num3 = value
            end
        end

        var13.current = num3
        if var15.current then
            var15.current(var11[num3], num3)
        end
    end, { var11, var12, num2 }) else nil

    React.useEffect(function()
        if var2 then
            local var62 = if Flags.FoundationBottomSheetKeepsSnapPoint and var11[var13.current] ~= nil then var13.current else var1.defaultSnapPointIndex

            if reducedMotion then
                var56(var62)
                var17(Otter.instant(0))
            else
                var55(var62)
                var17(Otter.ease(0, { duration = var3.Time.Time_100 }))
            end

            local var63 = var12(var11[var62])
            local bool1 = num2 <= var63
            local var64 = var37
            if Flags.FoundationSheetReversedContent and not bool1 then
                bool1 = var38.current
            end

            var64(bool1)
        end

        return function()
            var52()
        end
    end, {
        var2,
        var11,
        var1.defaultSnapPointIndex,
        var55,
        var12,
        var56,
        reducedMotion
    })

    React.useLayoutEffect(function()
        if not var2 then
            return
        end

        var7(var2.AbsoluteSize.Y)
        local connection = var2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            var7(var2.AbsoluteSize.Y)
        end)
        return function()
            connection:Disconnect()
        end
    end, { var2 })

    React.useEffect(function()
        local connection = game:GetService("UserInputService").TouchPan:Connect(function(_: {Vector2}, totalTranslation: Vector2, velocity: Vector2, _userInputState: Enum.UserInputState)
            var42.current = velocity.Y
            if var41.current and totalTranslation and math.abs(totalTranslation.Y) > math.abs(totalTranslation.X) then
                var51(true)
            end

            var59()
        end)
        local connection2 = game:GetService("UserInputService").InputBegan:Connect(function()
            var41.current = true
            var42.current = 0
            var51(false)
            var52()
        end)
        local connection3 = game:GetService("UserInputService").InputEnded:Connect(function()
            if var41.current == false then
                return
            end

            var41.current = false
            var51(false)
            var42.current = if ref.current then ref.current:GetScrollVelocity().Y else 0

            if Flags.FoundationSheetReversedContent and var38.current then
                var37(true)
            end

            if not (var58() or var14.current) then
                var60()
                return
            end

            var37(true)
            if Flags.FoundationBottomSheetKeepsSnapPoint and not var14.current then
                var61()
            end
        end)

        return function()
            var51(false)
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, {
        var2,
        var60,
        var59,
        var52,
        var58,
        var51,
        var61
    })

    local closeAffordanceRef = React.useRef(nil)
    local contentStartRef, setContentStartRef = React.useState(nil)

    local innerSurface, var66 = React.useState(nil)
    local var4 = ReactUtils.useComposedRef(arg2, var66)

    React.useImperativeHandle(var1.sheetRef, function()
        return { close = var57 }
    end, {})

    local var16 = React.useMemo(function()
        return {
            actionsHeight = actionsHeight,
            setActionsHeight = setActionsHeight,
            hasActionsDivider = hasActionsDivider,
            setHasActionsDivider = setHasActionsDivider,
            sheetHeightAvailable = sheetHeightAvailable,
            setSheetHeightAvailable = setSheetHeightAvailable,
            safeAreaPadding = bottom,
            bottomPadding = 200,
            innerScrollingEnabled = innerScrollingEnabled,
            innerScrollY = innerScrollY,
            innerScrollingRef = innerScrollingRef,
            setInnerScrollY = function(num3: number)
                var34(num3)
                var59()
            end,
            hasHeader = hasHeader,
            setHasHeader = setHasHeader,
            hasFullBleed = hasFullBleed,
            fullBleedHeight = fullBleedHeight,
            setFullBleedHeight = setFullBleedHeight,
            closeSheet = var57,
            hasRadius = true,
            sheetType = SheetType.Bottom,
            innerSurface = innerSurface,
            testId = var1.testId,
            closeAffordanceRef = closeAffordanceRef,
            contentStartRef = contentStartRef,
            setContentStartRef = setContentStartRef,
            isVerticalSheetGesture = isVerticalSheetGesture,
            contentRevealOffset = contentRevealOffset,
            setIsContentReversed = setIsContentReversed
        }
    end, {
        var1.testId,
        var57,
        bottom,
        var59,
        innerSurface,
        closeAffordanceRef,
        contentStartRef,
        hasFullBleed,
        isVerticalSheetGesture,
        contentRevealOffset,
        setIsContentReversed
    })

    local createElement = React.createElement
    local var69 = View
    local tbl2 = {
        ZIndex = 5,
        backgroundStyle = var3.Color.Content.Muted,
        Position = UDim2.new(0.5, 0, 0, if hasFullBleed then var3.Padding.Small else -var3.Padding.XSmall),
        AnchorPoint = Vector2.new(0.5, 0),
        tag = "align-y-center size-1000-100 padding-y-small radius-small",
        testId = `{var1.testId}--gripper`
    }

    local gripper = createElement(var69, tbl2, {
        TouchTarget = React.createElement(View, {
            tag = "size-1000-600",
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = function()
                var41.current = false
                if Flags.FoundationSheetReversedContent and var38.current and innerScrollingRef.current then
                    local current = innerScrollingRef.current

                    local y = math.max(0, current.AbsoluteCanvasSize.Y - current.AbsoluteWindowSize.Y)
                    var34(y)
                    current.CanvasPosition = Vector2.new(0, y)
                    current:ResetScrollVelocity()
                elseif innerScrollingRef.current then
                    var34(0)
                    innerScrollingRef.current.CanvasPosition = Vector2.new(0, 0)
                    innerScrollingRef.current:ResetScrollVelocity()
                end
                if not (#var11 > 1) then
                    var57()

                    return
                end

                local var70 = var13.current % #var11 + 1
                if reducedMotion then
                    var56(var70)
                else
                    var55(var70)
                end
                local var71 = var12(var11[var70])
                local bool1 = num2 <= var71
                local var72 = var37
                if Flags.FoundationSheetReversedContent and not bool1 then
                    bool1 = var38.current
                end

                var72(bool1)
            end
        })
    })

    local var70

    if var2 then
        local createPortal = ReactRoblox.createPortal
        local createElement2 = React.createElement
        local var71 = View
        local tbl3 = {
            ZIndex = owner.zIndex,
            ref = var4,
            selection = Types.nonSelectable,
            selectionGroup = Types.isolatedSelectionGroup,
            tag = "size-full",
            testId = `{var1.testId}--surface`
        }
        local createElement3 = React.createElement
        local str1 = "ScrollingFrame"
        local tbl4 = {
            Size = UDim2.fromScale(1, 1),
            CanvasSize = UDim2.new(1, 0, 1, num2 + bottom),
            ClipsDescendants = false,
            BackgroundTransparency = 1,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollBarThickness = 0,
            ref = ref
        }

        tbl4[React.Change.CanvasPosition] = function(arg3)
            var31.current = arg3.CanvasPosition.Y
            local value = if Flags.FoundationSheetReversedContent and contentRevealOffset then contentRevealOffset:getValue() else nil
            setSheetHeightAvailable(var31.current - bottom - var3.Margin.Small)

            if Flags.FoundationSheetReversedContent and contentRevealOffset and value then
                local current = innerScrollingRef.current
                local var72 = contentRevealOffset:getValue() - value
                if var38.current and current and var72 ~= 0 then
                    current.CanvasPosition = Vector2.new(0, current.CanvasPosition.Y + var72)
                end
            end
            var59()
            if var31.current <= 0 then
                var57()
            end
        end
        local tbl5 = { SheetContainer = 0, Shadow = 0, Backdrop = 0 }
        local createElement4 = React.createElement
        local var72 = View
        local tbl6 = {
            Size = UDim2.new(1, 0, 1, 200 - num2 - bottom),
            Position = UDim2.new(0, 0, 1, -num2),
            ZIndex = 3
        }
        local tbl7 = { Sheet = 0 }
        local createElement5 = React.createElement
        local var73 = View

        local tbl8 = {
            Size = if var1.snapPoints == nil then UDim2.fromScale(1, 0) else UDim2.new(1, 0, 0, num2 + 200),
            AutomaticSize = if var1.snapPoints == nil then Enum.AutomaticSize.Y else nil,
            onAbsoluteSizeChanged = var1.snapPoints == nil and function(arg3)
                var9(arg3.AbsoluteSize.Y - 200)
            end or nil,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = Dash.noop,
            testId = var1.testId,
            tag = {
                ["col items-center radius-large clip bg-surface-100"] = true,
                ["padding-top-medium"] = not hasFullBleed
            }
        }

        tbl7.Sheet = createElement5(var73, tbl8, {
            GripperContainer = React.createElement("Folder", nil, { Gripper = gripper }),
            Content = React.createElement(
                SheetContext.Provider,
                { value = var16 },
                React.createElement(ElevationOwnerScope, { owner = owner }, var1.children)
            )
        })
        tbl5.SheetContainer = createElement4(var72, tbl6, tbl7)
        local element2

        if Flags.FoundationBottomSheetOverlayShadow then
            element2 = React.createElement(View, {
                tag = "shadow-overlay-300 radius-large",
                Size = UDim2.new(1, 0, 0, num2 + 200),
                Position = UDim2.new(0, 0, 1, -num2),
                ZIndex = 2,
                testId = `{var1.testId}--shadow`
            })
        else
            element2 = React.createElement(Image, {
                Image = SHADOW_IMAGE,
                Size = UDim2.new(1, SHADOW_SIZE * 2, 0, num2 + 200 + SHADOW_SIZE * 2),
                Position = UDim2.new(-SHADOW_SIZE, 0, 1, -num2 - SHADOW_SIZE),
                ZIndex = 2,
                slice = {
                    center = Rect.new(SHADOW_SIZE, SHADOW_SIZE, SHADOW_SIZE + 1, SHADOW_SIZE + 1),
                    scale = 2
                },
                imageStyle = var3.Color.Extended.Black.Black_10
            })
        end

        tbl5.Shadow = element2
        local element3

        if Flags.FoundationBottomSheetInternalBackdrop then
            element3 = React.createElement(Backdrop, {
                transparency = transparency,
                onActivated = function()
                    var57()
                end,
                Size = UDim2.fromScale(1, 2),
                ZIndex = 1,
                testId = `{var1.testId}--backdrop`
            })
        else
            element3 = React.createElement(View, {
                Size = UDim2.fromScale(1, 2),
                Position = UDim2.fromScale(0, -0.5),
                ZIndex = 1,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                backgroundStyle = transparency:map(function(num3: number)
                    return {
                        Color3 = var3.Color.Common.Backdrop.Color3,
                        Transparency = math.lerp(var3.Color.Common.Backdrop.Transparency, 1, num3)
                    }
                end),
                onActivated = function()
                    var57()
                end,
                testId = `{var1.testId}--backdrop`
            })
        end

        tbl5.Backdrop = element3
        var70 = createPortal(createElement2(var71, tbl3, createElement3(str1, tbl4, tbl5)), var2)
    else
        var70 = var2
    end

    return var70
end))
