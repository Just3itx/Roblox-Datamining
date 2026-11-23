-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = game:GetService("CorePackages").Packages._Index.Foundation.Foundation
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
local useScreen = require(Foundation.Providers.Overlay.useScreen)
local SheetContext = require(script.Parent.SheetContext)
local Types = require(script.Parent.Types)

local SheetType = require(script.Parent.SheetType)

local childrenHasFullBleed = require(script.Parent.childrenHasFullBleed)
local getHardwareSafeAreaInsets = require(script.Parent.getHardwareSafeAreaInsets)
local useHardwareInsets = require(script.Parent.useHardwareInsets)
local useScreenHeight = require(script.Parent.useScreenHeight)

local Image = require(Foundation.Components.Image)
local View = require(Foundation.Components.View)

local usePreferences = require(Foundation.Providers.Preferences.usePreferences)

local num1 = game:DefineFastInt("FoundationBottomSheetIOSInsetWorkaroundDelayMs", 100)

local bool1 = game:DefineFastFlag("FoundationBottomSheetIOSInsetWorkaround", false)

local tbl1 = { defaultSnapPointIndex = 1, testId = "--foundation-sheet" }

local SHADOW_IMAGE = Constants.SHADOW_IMAGE
local SHADOW_SIZE = Constants.SHADOW_SIZE

local function advanceCriticalDampedSpring(num2: number, current: number, num3: number, deltaTime: number): (number, number) -- Luacid: Inlined by compiler; 1 call site recovered
    local num4 = num2 - num3
    local num5 = math.rad(1440) * deltaTime
    local num6 = math.exp(-num5)
    local num7 = current + math.rad(1440) * num4

    local num8 = (num4 + num7 * deltaTime) * num6
    local num9 = (current - num7 * num5) * num6

    return num3 + num8, num9
end

local function useStableGuiHeight(arg1)
    local var1 = if arg1 then arg1.AbsoluteSize.Y else 0
    local var2, var3 = React.useState(var1)
    local var4 = React.useRef(var1)
    local var5 = React.useRef(0)

    local var6 = React.useCallback(function(current: number)
        if var4.current == current then
            return
        end

        var4.current = current
        var3(current)
    end, {})

    React.useLayoutEffect(function()
        local var7 = var5
        var7.current += 1

        if not arg1 then
            var6(0)
            return function()
                local var8 = var5
                var8.current += 1
            end
        end

        local function updateHeight()
            local absoluteSizeY = arg1.AbsoluteSize.Y

            if var4.current <= 0 or absoluteSizeY <= var4.current then
                local var8 = var5
                var8.current += 1
                var6(absoluteSizeY)
                return
            end

            local var8 = var5
            var8.current += 1
            local current = var5.current

            task.delay(num1 / 1000, function()
                if var5.current ~= current or arg1.AbsoluteSize.Y ~= absoluteSizeY then
                    return
                end

                var6(absoluteSizeY)
            end)
        end

        updateHeight()
        local connection = arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateHeight)

        return function()
            local var8 = var5
            var8.current += 1
            connection:Disconnect()
        end
    end, { arg1, var6 })

    return var2
end

local function useStableScreenHeight() -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = useScreen()
    return (useStableGuiHeight(var1))
end

local function useStableBottomSafeAreaPadding(arg1)
    local bottom = getHardwareSafeAreaInsets().bottom
    local var1, var2 = React.useState(bottom)
    local var3 = React.useRef(bottom)
    local var4 = React.useRef(0)

    local var5 = React.useCallback(function(current: number)
        if var3.current == current then
            return
        end

        var3.current = current
        var2(current)
    end, {})

    React.useEffect(function()
        local var6 = var4
        var6.current += 1

        if not arg1 then
            return function()
                local var7 = var4
                var7.current += 1
            end
        end

        local function updateBottomInset()
            local bottom2 = getHardwareSafeAreaInsets().bottom

            if var3.current <= bottom2 then
                local var7 = var4
                var7.current += 1
                var5(bottom2)
                return
            end

            local var7 = var4
            var7.current += 1
            local current = var4.current

            task.delay(num1 / 1000, function()
                local bottom3 = getHardwareSafeAreaInsets().bottom
                if var4.current ~= current or bottom3 ~= bottom2 then
                    return
                end

                var5(bottom2)
            end)
        end

        updateBottomInset()
        local connection = arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateBottomInset)

        return function()
            local var7 = var4
            var7.current += 1
            connection:Disconnect()
        end
    end, { arg1, var5 })

    return var1
end

local function getIOSInsetWorkaroundValues(arg1) -- Luacid: unused: defined but never referenced
    return useStableScreenHeight(), useStableGuiHeight(arg1), (useStableBottomSafeAreaPadding(arg1))
end

return React.memo(React.forwardRef(function(arg1, arg2) -- name: BottomSheet
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useOverlay()
    local var3 = useTokens()
    local owner = useElevation(ElevationLayer.Sheet, { stackAboveOwner = false })

    local reducedMotion = usePreferences().reducedMotion

    local var5 = nil
    local var6 = nil
    local var7, yOffset

    if bool1 then
        local var8 = useStableScreenHeight()

        local var9 = useStableGuiHeight(var2)
        local var10 = useStableBottomSafeAreaPadding(var2)
        var7 = var8
        yOffset = var9
        var6 = var10
    else
        var7 = useScreenHeight()

        yOffset, var5 = React.useState(if var2 then var2.AbsoluteSize.Y else 0)
    end
    local var8, var9 = React.useState(0)
    local var10 = React.useMemo(function()
        return { var8 }
    end, { var8 })
    local var11 = var1.snapPoints or var10

    local var12 = React.useCallback(function(num2: number)
        return if num2 > 1 then num2 else num2 * var7
    end, { var7 })

    local num2 = 0
    for _, value in var11 do
        local var13 = var12(value)
        if num2 < var13 then
            num2 = var13
        end
    end

    local num3 = math.min(num2, var7)
    if yOffset > 0 then
        num3 = math.min(num3, yOffset)
    end

    if not bool1 then
        var6 = useHardwareInsets(var2).bottom

        React.useLayoutEffect(function()
            if not var2 then
                var5(0)
                return
            end

            local function updateOverlayAvailableHeight() -- Luacid: Inlined by compiler; 1 call site recovered
                var5(var2.AbsoluteSize.Y)
            end

            updateOverlayAvailableHeight()
            local connection = var2:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateOverlayAvailableHeight)

            return function()
                connection:Disconnect()
            end
        end, { var2 })
    end

    local var13 = React.useRef(0)
    local var14 = React.useRef(false)

    local var15, var16 = useAnimatedBinding(1, function()
        if var14.current then
            var1.onClose()
        end
    end)
    local sheetHeightAvailable, setSheetHeightAvailable = React.useBinding(-var6)
    local actionsHeight, setActionsHeight = React.useBinding(0)
    local hasActionsDivider, setHasActionsDivider = React.useBinding(false)
    local hasHeader, setHasHeader = React.useBinding(false)
    local hasFullBleed = childrenHasFullBleed(var1.children)
    local fullBleedHeight, setFullBleedHeight = React.useBinding(0)

    local var28 = React.useRef(0)
    local ref = React.useRef(nil)
    local innerScrollY, var31 = React.useBinding(0)
    local innerScrollingEnabled, var33 = React.useBinding(false)

    local var34 = React.useRef(false)
    local var35 = React.useRef(0)
    local var36 = React.useRef(nil)
    local var37 = React.useRef(false)
    local var38 = React.useRef(0)

    local var39 = React.useCallback(function()
        if var36.current then
            var36.current:Disconnect()
            var36.current = nil
        end
        var35.current = 0
        var37.current = false
    end, {})

    local var40 = React.useCallback(function(y: number)
        var39()
        var37.current = true

        if ref.current then
            ref.current:ResetScrollVelocity()
        end

        var36.current = game:GetService("RunService").Heartbeat:Connect(function(deltaTime: number)
            if not (ref.current and var37.current) then
                var39()
                return
            end

            local y2, current = advanceCriticalDampedSpring(ref.current.CanvasPosition.Y, var38.current, y, deltaTime)

            var38.current = current
            ref.current.CanvasPosition = Vector2.new(0, y2)
            local var40 = y - ref.current.CanvasPosition.Y

            if math.abs(var40) < 0.5 and math.abs(var38.current) < 1 then
                ref.current.CanvasPosition = Vector2.new(0, y)
                var39()
            end
        end)
    end, { var39 })

    local var41 = React.useCallback(function(num4: number): number
        return math.min(var12(num4), num3) + var6
    end, { var6, var12, num3 })

    local var42 = React.useCallback(function(current: number)
        var13.current = current
        var40(var41(var11[current]))
    end, { var41, var11 })

    local var43 = React.useCallback(function(current: number)
        var39()
        var13.current = current
        if ref.current then
            ref.current.CanvasPosition = Vector2.new(0, var41(var11[current]))
        end
    end, { var39, var41, var11 })

    local var44 = React.useRef(0)
    React.useEffect(function()
        if not var2 then
            return
        end

        local current = var44.current
        var44.current = yOffset
        if current <= 0 or current == yOffset then
            return
        end

        local current2 = var13.current
        if current2 <= 0 or #var11 < current2 then
            current2 = var1.defaultSnapPointIndex
        end

        if reducedMotion then
            var43(current2)
            return
        end
        var42(current2)
    end, {
        var2,
        yOffset,
        var42,
        var43,
        reducedMotion,
        var1.defaultSnapPointIndex,
        var11
    })

    local var45 = React.useCallback(function(bool2: boolean?)
        if var14.current then
            return
        end

        if reducedMotion and not bool2 then
            var14.current = true
            var39()
            if ref.current then
                ref.current.CanvasPosition = Vector2.new(0, 0)
            end
            var16((Otter.instant(1)))
        else
            var38.current = -var35.current
            var40(0)
            var16(Otter.ease(1, { duration = var3.Time.Time_100 }))

            var14.current = true
        end
    end, { var40, var39, reducedMotion })

    local var46 = React.useCallback(function()
        local bool2 = innerScrollY:getValue() <= 0
        local current = var28.current
        local bool3 = math.floor(num3 + var6) <= current

        if var35.current > 0 and bool2 and var34.current then
            var33(false)
        elseif var35.current <= 0 and bool3 then
            var33(true)
        end
    end, { num3, var6 })

    local var47 = React.useCallback(function()
        local current = var35.current
        local var47 = var28.current - current / 2.35

        local tbl2 = {{ index = 0, position = 0 }}

        for index, value2 in var11 do
            table.insert(tbl2, { index = index, position = var41(value2) })
        end

        table.sort(tbl2, function(arg3, arg4): boolean
            return math.abs(arg3.position - var47) < math.abs(arg4.position - var47)
        end)
        local var48 = tbl2[1]

        if var34.current then
            return
        end

        var38.current = -current
        if var48.index == 0 then
            var45(true)
            return
        end
        var42(var48.index)
    end, {
        var11,
        var42,
        var41,
        var45
    })
    React.useEffect(function()
        if var2 then
            if reducedMotion then
                var43(var1.defaultSnapPointIndex)
                var16(Otter.instant(0))
            else
                var42(var1.defaultSnapPointIndex)
                var16(Otter.ease(0, { duration = var3.Time.Time_100 }))
            end

            if math.min(var12(var11[var1.defaultSnapPointIndex]), num3) == num3 then
                var33(true)
            end
        end
        return function()
            var39()
        end
    end, {
        var2,
        var11,
        var1.defaultSnapPointIndex,
        var42,
        var12,
        var43,
        reducedMotion
    })

    React.useEffect(function()
        local connection = game:GetService("UserInputService").TouchPan:Connect(function(_: {Vector2}, _vector2: Vector2, velocity: Vector2, _userInputState: Enum.UserInputState)
            var35.current = velocity.Y
            var46()
        end)
        local connection2 = game:GetService("UserInputService").InputBegan:Connect(function()
            var34.current = true
            var35.current = 0
            var39()
        end)
        local connection3 = game:GetService("UserInputService").InputEnded:Connect(function()
            if var34.current == false then
                return
            end

            var34.current = false

            var35.current = if ref.current then ref.current:GetScrollVelocity().Y else 0

            local current = var28.current

            if math.floor(num3 + var6) <= current or var14.current then
                var33(true)
                return
            end

            var47()
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, {
        var2,
        var47,
        var46,
        var39
    })
    local closeAffordanceRef = React.useRef(nil)
    local contentStartRef, setContentStartRef = React.useState(nil)

    local innerSurface, var52 = React.useState(nil)
    local var4 = ReactUtils.useComposedRef(arg2, var52)

    React.useImperativeHandle(var1.sheetRef, function()
        return { close = var45 }
    end, {})

    local var17 = React.useMemo(function()
        return {
            actionsHeight = actionsHeight,
            setActionsHeight = setActionsHeight,
            hasActionsDivider = hasActionsDivider,
            setHasActionsDivider = setHasActionsDivider,
            sheetHeightAvailable = sheetHeightAvailable,
            setSheetHeightAvailable = setSheetHeightAvailable,
            safeAreaPadding = var6,
            bottomPadding = 200,
            innerScrollingEnabled = innerScrollingEnabled,
            innerScrollY = innerScrollY,
            setInnerScrollY = function(num4: number)
                var31(num4)
                var46()
            end,
            hasHeader = hasHeader,
            setHasHeader = setHasHeader,
            hasFullBleed = hasFullBleed,
            fullBleedHeight = fullBleedHeight,
            setFullBleedHeight = setFullBleedHeight,
            closeSheet = var45,
            hasRadius = true,
            sheetType = SheetType.Bottom,
            innerSurface = innerSurface,
            testId = var1.testId,
            closeAffordanceRef = closeAffordanceRef,
            contentStartRef = contentStartRef,
            setContentStartRef = setContentStartRef
        }
    end, {
        var1.testId,
        var45,
        var6,
        var46,
        innerSurface,
        closeAffordanceRef,
        contentStartRef,
        hasFullBleed
    })

    local createElement = React.createElement
    local var55 = View
    local tbl2 = {
        ZIndex = 3,
        backgroundStyle = var3.Color.Content.Muted,
        Position = UDim2.new(0.5, 0, 0, if hasFullBleed then var3.Padding.Small else -var3.Padding.XSmall),
        AnchorPoint = Vector2.new(0.5, 0),
        tag = "align-y-center size-1000-100 padding-y-small radius-small",
        testId = `{var1.testId}--gripper`
    }

    local gripper = createElement(var55, tbl2, {
        TouchTarget = React.createElement(View, {
            tag = "size-1000-600",
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = function()
                var34.current = false
                if not (#var11 > 1) then
                    var45()
                    return
                end

                local var56 = var13.current % #var11 + 1
                if reducedMotion then
                    var43(var56)
                else
                    var42(var56)
                end
                if math.min(var12(var11[var56]), num3) == num3 then
                    var33(true)
                end
            end
        })
    })

    local var56

    if var2 then
        local createPortal = ReactRoblox.createPortal
        local createElement2 = React.createElement
        local var57 = View
        local tbl3 = {
            ZIndex = owner.zIndex,
            ref = var4,
            selection = Types.nonSelectable,
            selectionGroup = Types.isolatedSelectionGroup,
            Size = if bool1 then UDim2.new(1, 0, 0, yOffset) else nil,
            tag = if bool1 then nil else "size-full",
            testId = `{var1.testId}--surface`
        }
        local createElement3 = React.createElement
        local str1 = "ScrollingFrame"
        local tbl4 = {
            Size = if bool1 then UDim2.new(1, 0, 0, yOffset) else UDim2.fromScale(1, 1),
            CanvasSize = UDim2.new(1, 0, 1, num3 + var6),
            ClipsDescendants = false,
            BackgroundTransparency = 1,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollBarThickness = 0,
            ref = ref
        }

        tbl4[React.Change.CanvasPosition] = function(arg3)
            var28.current = arg3.CanvasPosition.Y
            setSheetHeightAvailable(var28.current - var6 - var3.Margin.Small)
            var46()
            if var28.current <= 0 then
                var45()
            end
        end
        local tbl5 = { SheetContainer = 0, Shadow = 0, Backdrop = 0 }
        local createElement4 = React.createElement
        local var58 = View
        local tbl6 = {
            Size = UDim2.new(1, 0, 1, 200 - num3 - var6),
            Position = UDim2.new(0, 0, 1, -num3),
            ZIndex = 3
        }
        local tbl7 = { Sheet = 0 }
        local createElement5 = React.createElement
        local var59 = View

        local tbl8 = {
            Size = if var1.snapPoints == nil then UDim2.fromScale(1, 0) else UDim2.new(1, 0, 0, num3 + 200),
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

        tbl7.Sheet = createElement5(var59, tbl8, {
            GripperContainer = React.createElement("Folder", nil, { Gripper = gripper }),
            Content = React.createElement(
                SheetContext.Provider,
                { value = var17 },
                React.createElement(ElevationOwnerScope, { owner = owner }, var1.children)
            )
        })
        tbl5.SheetContainer = createElement4(var58, tbl6, tbl7)

        tbl5.Shadow = React.createElement(Image, {
            Image = SHADOW_IMAGE,
            Size = UDim2.new(1, SHADOW_SIZE * 2, 0, num3 + 200 + SHADOW_SIZE * 2),
            Position = UDim2.new(-SHADOW_SIZE, 0, 1, -num3 - SHADOW_SIZE),
            ZIndex = 2,
            slice = {
                center = Rect.new(SHADOW_SIZE, SHADOW_SIZE, SHADOW_SIZE + 1, SHADOW_SIZE + 1),
                scale = 2
            },
            imageStyle = var3.Color.Extended.Black.Black_10
        })
        tbl5.Backdrop = React.createElement(View, {
            Size = UDim2.fromScale(1, 2),
            Position = UDim2.fromScale(0, -0.5),
            ZIndex = 1,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            backgroundStyle = var15:map(function(num4: number)
                return {
                    Color3 = var3.Color.Common.Backdrop.Color3,
                    Transparency = math.lerp(var3.Color.Common.Backdrop.Transparency, 1, num4)
                }
            end),
            onActivated = function()
                var45()
            end,
            testId = `{var1.testId}--backdrop`
        })

        var56 = createPortal(createElement2(var57, tbl3, createElement3(str1, tbl4, tbl5)), var2)
    else
        var56 = var2
    end

    return var56
end))
