-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local Signals = require(SocialCarouselParent.Signals)

local marqueeEligibility = require(script.Parent.marqueeEligibility)
local scrollPause = require(script.Parent.scrollPause)
local tileVisibility = require(script.Parent.tileVisibility)
local Enums = require(SocialCarousel.Common.Enums)

local function defaultPointerPosition() -- Luacid: Inlined by compiler; 1 call site recovered
    return UserInputService:GetMouseLocation() - GuiService:GetGuiInset()
end

local function tileIdUnderPointer(vector2: Vector2, func1: (...any) -> (...any))
    for _, value in ipairs(func1(vector2.X, vector2.Y)) do
        local var1 = value

        while var1 ~= nil do
            local var2 = var1:GetAttribute(Enums.MarqueeFriendIdAttribute)
            if typeof(var2) == "string" then
                return var2
            end
            var1 = var1.Parent
        end
    end
    return nil
end

local function drawsOnTop(arg1): boolean
    if not (arg1:IsA("GuiObject") and arg1.Visible) then
        return false
    end
    if arg1.BackgroundTransparency < 0.95 then
        return true
    end
    if not (arg1:IsA("ImageLabel") or arg1:IsA("ImageButton")) then
        return false
    end

    return not (arg1.Image == "") and arg1.ImageTransparency < 0.95
end

local function isCoveredAt(current, func1: (...any) -> (...any), num1: number, num2: number)
    for _, value in func1(num1, num2) do
        if value == current or value:IsDescendantOf(current) then
            return false
        end
        if not current:IsDescendantOf(value) and drawsOnTop(value) then
            return true
        end
    end
    return false
end

local function indexOfTileId(tbl1, id: string) -- Luacid: Inlined by compiler; 8 call sites recovered
    for i, value in ipairs(tbl1) do
        if value.id == id then
            return i
        end
    end
    return nil
end

local function lastLocationFor(tbl1, id: string)
    for _, value in ipairs(tbl1) do
        if value.id == id then
            local presence = value.presence
            local lastLocation = if presence == nil then nil else presence.lastLocation
            return if lastLocation == nil or lastLocation == "" then nil else lastLocation
        end
    end
    return nil
end

return {
    useMarqueeActiveTiles = function(tbl1, current, tbl2, tbl3, func1: ((...any) -> (...any))?, func2: ((...any) -> (...any))?)
        local var1 = if current.restoredTileId == nil or current.tiles == nil then nil else indexOfTileId(current.tiles, current.restoredTileId)
        local activeByIndex, var3 = React.useState(var1 == nil and {} or { [var1] = true })

        local isPaused, var5 = React.useState(var1 ~= nil)
        local var6 = React.useRef(scrollPause.initialState())

        local loopsRemainingRef = React.useRef({})
        if current.loopsRemainingStore ~= nil then
            loopsRemainingRef.current = current.loopsRemainingStore.getLoopsRemaining(false)
        end
        local var8 = React.useRef(current.restoredTileId)

        local var9 = React.useRef(var1)
        local marqueeRunId, var11 = React.useState(0)
        local var12 = React.useRef(0)
        local var13 = React.useRef(current)
        var13.current = current

        local var14 = React.useRef(function() end)

        local var15 = React.useRef(if current.restoredTileId == nil then 0 else 1)

        local var16 = React.useRef(current.restoredTileId ~= nil)

        local var17 = React.useRef(current.restoredTileId ~= nil)

        local var18 = React.useRef(nil)

        local var19 = React.useRef(false)

        local function refUserId(tbl4) -- Luacid: Inlined by compiler; 20 call sites recovered
            return if tbl4 == nil then nil else tbl4.current
        end

        local function joinCardUserId(current2) -- Luacid: Inlined by compiler; 9 call sites recovered
            if current2.joinPopoverUserId ~= nil then
                return current2.joinPopoverUserId
            end
            local var20 = refUserId(current2.joinSheetUserIdRef)
            if var20 ~= nil then
                return var20
            end
            return refUserId(current2.joinPopoverUserIdRef)
        end

        local function joinCardIsOpen(current2): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
            return current2.homeBlurredOrJoinCardOpen == true or joinCardUserId(current2) ~= nil
        end

        local function cardHoldsTile(current2, current3: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
            if not joinCardIsOpen(current2) then
                return false
            end

            local var20 = joinCardUserId(current2)
            return var20 == nil or var20 == current3
        end

        local function loopsRemainingMap() -- Luacid: Inlined by compiler; 5 call sites recovered
            local loopsRemainingStore = var13.current.loopsRemainingStore
            if loopsRemainingStore ~= nil then
                return loopsRemainingStore.getLoopsRemaining(false)
            end
            return loopsRemainingRef.current
        end

        local function publishIndex(current2: number?) -- Luacid: Inlined by compiler; 8 call sites recovered
            if var9.current == current2 then
                return
            end
            var9.current = current2
            if current2 == nil then
                var3({})
                return
            end
            var3({ [current2] = true })
        end

        local function clearActiveTile() -- Luacid: Inlined by compiler; 7 call sites recovered
            var8.current = nil
            publishIndex(nil)
        end

        local onMarqueeFinished = React.useCallback(function(id: string)
            var17.current = false
            local current2 = var13.current
            if current2.idleSequenceEnabled ~= true then
                return
            end

            local tiles = current2.tiles or {}
            local var20 = lastLocationFor(tiles, id)
            if var20 == nil then
                return
            end
            marqueeEligibility.recordFinishedLoop(loopsRemainingMap(), id, var20)

            local tbl4 = {
                direction = current2.direction or Enum.TextDirection.LeftToRight,
                reducedMotion = current2.reducedMotion == true,
                interacting = false,
                loopsRemaining = loopsRemainingMap(),
                canvasX = var6.current.canvasX or 0,
                containerWidth = current2.containerWidth,
                tileWidth = current2.tileWidth,
                gap = current2.columnGap
            }

            local var21 = marqueeEligibility.resolveActiveTileId(tiles, tbl4, id)
            if var21 ~= id then
                var21 = marqueeEligibility.nextEligibleAfter(tiles, id, tbl4)
            end
            var8.current = var21
            publishIndex(if var21 == nil then nil else indexOfTileId(tiles, var21))

            if var21 == nil then
                return
            end
            local var22 = lastLocationFor(tiles, var21)
            if var22 == nil then
                return
            end
            local var23 = loopsRemainingMap()[marqueeEligibility.loopKey(var21, var22)]
            if var23 ~= nil and var23 < marqueeEligibility.DEFAULT_LOOPS then
                local var24 = var12
                var24.current += 1
                var11(var12.current)
            end
        end, {})

        local function tileById(tbl4, id: string) -- Luacid: Inlined by compiler; 3 call sites recovered
            for _, value in ipairs(tbl4) do
                if value.id == id then
                    return value
                end
            end
            return nil
        end

        local onManualMarqueeStart = React.useCallback(function(current2: string)
            local current3 = var13.current
            if current3.manualMarqueeEnabled ~= true or current3.reducedMotion == true then
                return
            end

            local tiles = current3.tiles or {}
            local var21 = tileById(tiles, current2)

            if var21 == nil or not marqueeEligibility.isHoverEligible(var21) then
                return
            end

            var18.current = nil

            if var8.current == current2 and var9.current ~= nil then
                return
            end

            var8.current = current2
            publishIndex((indexOfTileId(tiles, current2)))

            local var22 = var12
            var22.current += 1
            var11(var12.current)
        end, {})

        local onManualMarqueeEnd = React.useCallback(function(current2: string)
            local current3 = var13.current

            if joinCardIsOpen(current3) then
                if var8.current == current2 then
                    var18.current = current2
                end
            elseif current3.manualMarqueeEnabled == true and var8.current == current2 then
                clearActiveTile()
            end
        end, {})

        local var23 = React.useRef({})

        React.useEffect(function()
            if current.marqueeEnabled == false then
                return
            end
            local current2 = tbl1.current
            if current2 == nil then
                return
            end

            local var24 = tbl2 or RunService.Heartbeat
            local var25 = tbl3 or UserInputService

            local var26 = func1 or function(x: number, y: number)
                local basePlayerGui = current2:FindFirstAncestorWhichIsA("BasePlayerGui")
                if basePlayerGui == nil then
                    return {}
                end
                return basePlayerGui:GetGuiObjectsAtPosition(x, y)
            end
            local connection = nil
            local current3 = var23.current
            local tbl4 = {
                current = next(current3) ~= nil
            }
            local apply = nil

            local function stopHeartbeat() -- Luacid: Inlined by compiler; 4 call sites recovered
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
            end

            local function scrollRange(scrollingFrame: ScrollingFrame): number -- Luacid: Inlined by compiler; 1 call site recovered
                return math.max(
                    scrollingFrame.CanvasSize.Y.Offset + scrollingFrame.CanvasSize.Y.Scale * scrollingFrame.AbsoluteSize.Y,
                    scrollingFrame.AbsoluteCanvasSize.Y
                ) - scrollingFrame.AbsoluteSize.Y
            end

            local function verticalPage()
                local current2Parent = current2.Parent
                local var27 = nil
                local num1 = 0

                while current2Parent ~= nil do
                    if current2Parent:IsA("ScrollingFrame") then
                        local num2 = scrollRange(current2Parent)

                        if num1 < num2 then
                            num1 = num2
                            var27 = current2Parent
                        end
                    end

                    current2Parent = current2Parent.Parent
                end
                return var27
            end

            local function verticalCanvasY() -- Luacid: Inlined by compiler; 1 call site recovered
                local var27 = verticalPage()
                return if var27 == nil then nil else var27.CanvasPosition.Y
            end

            local function rowIsInsidePage() -- Luacid: Inlined by compiler; 1 call site recovered
                local var27 = verticalPage()
                if var27 == nil then
                    return true
                end
                return tileVisibility.isAtLeast70PercentVerticallyVisible(
                    current2.AbsolutePosition.Y,
                    current2.AbsoluteSize.Y,
                    var27.AbsolutePosition.Y,
                    var27.AbsoluteSize.Y
                )
            end

            local function rowIsVerticallyEligible(): boolean
                if not rowIsInsidePage() then
                    return false
                end
                local var27 = verticalPage()
                if var27 == nil then
                    return true
                end
                local absolutePositionY = current2.AbsolutePosition.Y
                local absoluteSizeY = current2.AbsoluteSize.Y
                local absolutePositionY2 = var27.AbsolutePosition.Y
                local absoluteSizeY2 = var27.AbsoluteSize.Y

                local var28 = current2.AbsolutePosition.X + current2.AbsoluteSize.X / 2
                local num1 = 0
                for i = 1, 20 do
                    local var29 = absolutePositionY + (i - 0.5) * absoluteSizeY / 20
                    local bool1 = absolutePositionY2 <= var29 and var29 <= absolutePositionY2 + absoluteSizeY2

                    if bool1 and not isCoveredAt(current2, var26, var28, var29) then
                        num1 += 1
                    end
                end
                return num1 / 20 >= tileVisibility.MIN_VISIBLE_FRACTION
            end

            local function publish(canvasX: number, bool1: boolean?)
                local current4 = var13.current
                local bool2 = joinCardIsOpen(current4)
                local var27 = var19.current and not bool2
                var19.current = bool2
                local restoredTileId = current4.restoredTileId
                if var17.current and restoredTileId ~= nil then
                    local tiles = current4.tiles or {}
                    local var28 = tileById(tiles, restoredTileId)
                    local var29 = if var28 == nil then nil else indexOfTileId(tiles, restoredTileId)

                    if var29 ~= nil and marqueeEligibility.isHoverEligible(var28) then
                        var8.current = restoredTileId
                        if current4.homeBlurredOrJoinCardOpen == true then
                            var5(true)
                        end
                        publishIndex(var29)
                        return
                    end
                    var17.current = false
                end

                if current4.manualMarqueeEnabled == true then
                    if var27 then
                        var18.current = nil

                        if current4.isDesktop == true then
                            local var28 = if func2 ~= nil then func2() else defaultPointerPosition()
                            local var29 = tileIdUnderPointer(var28, var26)
                            if var29 == nil then
                                clearActiveTile()
                                return
                            end
                            onManualMarqueeStart(var29)
                            if var8.current ~= var29 then
                                clearActiveTile()
                                return
                            end

                            return
                        end
                    end

                    local tiles = current4.tiles or {}
                    local current5 = var8.current
                    local var28 = if current5 == nil then nil else tileById(tiles, current5)

                    if var28 == nil or current4.reducedMotion == true or not marqueeEligibility.isHoverEligible(var28) then
                        clearActiveTile()
                    else
                        publishIndex((indexOfTileId(tiles, current5)))
                    end

                    return
                end

                if current4.idleSequenceEnabled ~= true then
                    local current5 = var8.current
                    if current5 ~= nil then
                        local bool3 = cardHoldsTile(current4, current5)

                        if bool3 then
                            local var28 = indexOfTileId(current4.tiles or {}, current5)

                            if var28 ~= nil then
                                publishIndex(var28)
                                return
                            end
                        end
                    end

                    var18.current = nil
                    var5(false)
                    clearActiveTile()
                else
                    local tiles = current4.tiles or {}
                    local tbl5 = {
                        direction = current4.direction or Enum.TextDirection.LeftToRight,
                        reducedMotion = current4.reducedMotion == true,
                        interacting = false,
                        loopsRemaining = loopsRemainingMap(),
                        canvasX = canvasX,
                        containerWidth = current4.containerWidth,
                        tileWidth = current4.tileWidth,
                        gap = current4.columnGap
                    }
                    local var2 = if bool1 then marqueeEligibility.resolveActiveTileId(tiles, tbl5, var8.current) else marqueeEligibility.leadingEligible(tiles, tbl5)
                    var8.current = var2
                    local var29 = if var2 == nil then nil else indexOfTileId(tiles, var2)
                    publishIndex(var29)
                end
            end
            local function startHeartbeat()
                if connection then
                    return
                end
                connection = var24:Connect(function(num1: number)
                    local canvasX = var6.current.canvasX
                    if canvasX == nil then
                        return
                    end
                    local var27 = var15
                    var27.current = math.max(0, var15.current - math.max(num1, 0))
                    apply(canvasX, num1)
                end)
            end

            apply = function(num1: number, num2: number, bool1: boolean?, bool2: boolean?)
                local current4 = var6.current
                local var2 = scrollPause.advance(current4, num1, num2, tbl4.current, (verticalCanvasY()))
                var6.current = var2
                if var2.interacting then
                    var5(true)
                    startHeartbeat()
                    return
                end

                if rowIsVerticallyEligible() then
                    local current5 = var16.current
                    var16.current = false
                    var15.current = 0
                    stopHeartbeat()

                    if current4.interacting or bool1 or var9.current == nil or current5 then
                        if current4.interacting then
                            var17.current = false
                        end
                        var5(false)
                        local func3 = publish

                        if bool2 == true or current5 then
                            current5 = not current4.interacting
                        end

                        func3(num1, current5)
                    end

                    return
                end

                local current5 = var8.current

                if current5 ~= nil then
                    local current6 = var13.current
                    local bool3 = cardHoldsTile(current6, current5)

                    if bool3 or var15.current > 0 then
                        var16.current = true
                        var5(true)
                        local tiles = var13.current.tiles or {}
                        publishIndex((indexOfTileId(tiles, current5)))

                        if var15.current > 0 then
                            startHeartbeat()
                            return
                        end

                        stopHeartbeat()
                        return
                    end
                end

                var16.current = false
                var5(false)
                clearActiveTile()

                if var15.current > 0 then
                    startHeartbeat()
                    return
                end

                stopHeartbeat()
            end

            local function onInputBegan(tbl5)
                if not scrollPause.isPointerHold(tbl5.UserInputType) then
                    return
                end

                local var27 = verticalPage()
                local absolutePosition = if var27 ~= nil then var27.AbsolutePosition else current2.AbsolutePosition
                local absoluteSize = if var27 ~= nil then var27.AbsoluteSize else current2.AbsoluteSize

                if not scrollPause.pointerIsInside(absolutePosition, absoluteSize, Vector2.new(tbl5.Position.X, tbl5.Position.Y)) then
                    return
                end
                current3[tbl5] = true
                tbl4.current = true
                apply(current2.CanvasPosition.X, 0)
            end

            local function releaseHold(tbl5) -- Luacid: Inlined by compiler; 2 call sites recovered
                if tbl5 ~= nil then
                    if current3[tbl5] == nil then
                        return
                    end
                    current3[tbl5] = nil
                else
                    table.clear(current3)
                end
                tbl4.current = next(current3) ~= nil
                apply(current2.CanvasPosition.X, 0)
            end

            local function onCanvasPositionChanged()
                apply(current2.CanvasPosition.X, 0)
            end

            function var14.current()
                var15.current = 1
                apply(current2.CanvasPosition.X, 0, true)
            end
            local current4 = var13.current
            if current4.idleSequenceEnabled == true then
                marqueeEligibility.reconcilePresence(loopsRemainingMap(), current4.tiles or {})
            end

            apply(current2.CanvasPosition.X, 0, true, true)

            if var6.current.interacting then
                startHeartbeat()
            end

            local var27 = nil
            local connection2 = nil

            local function bindVerticalScroller() -- Luacid: Inlined by compiler; 2 call sites recovered
                local var28 = verticalPage()
                if var28 == var27 then
                    return
                end
                if connection2 then
                    connection2:Disconnect()
                    connection2 = nil
                end
                var27 = var28
                if var28 ~= nil then
                    connection2 = var28:GetPropertyChangedSignal("CanvasPosition"):Connect(onCanvasPositionChanged)
                end
            end

            bindVerticalScroller()
            local current2Parent = current2.Parent
            local tbl5 = {}

            while current2Parent ~= nil do
                if current2Parent:IsA("ScrollingFrame") then
                    local absoluteCanvasSizeChanged = current2Parent:GetPropertyChangedSignal("AbsoluteCanvasSize")

                    table.insert(tbl5, absoluteCanvasSizeChanged:Connect(function()
                        local var28 = var27
                        bindVerticalScroller()

                        if var27 ~= var28 then
                            apply(current2.CanvasPosition.X, 0)
                        end
                    end))
                end

                current2Parent = current2Parent.Parent
            end

            local connection3 = current2:GetPropertyChangedSignal("CanvasPosition"):Connect(onCanvasPositionChanged)
            local connection4 = var25.InputBegan:Connect(onInputBegan)
            local connection5 = var25.InputEnded:Connect(function(tbl6)
                releaseHold(tbl6)
            end)

            local connection6 = if var25.WindowFocusReleased then var25.WindowFocusReleased:Connect(function()
                releaseHold(nil)
            end) else nil

            return function()
                function var14.current() end

                stopHeartbeat()
                connection3:Disconnect()
                if connection2 then
                    connection2:Disconnect()
                end
                for _, value in tbl5 do
                    value:Disconnect()
                end
                connection4:Disconnect()
                connection5:Disconnect()
                if connection6 then
                    connection6:Disconnect()
                end
            end
        end, {
            tbl1,
            tbl2,
            tbl3,
            func1,
            func2,
            current.tileCount,
            current.containerWidth,
            current.tileWidth,
            current.columnGap,
            current.tiles,
            current.direction,
            current.reducedMotion,
            current.idleSequenceEnabled,
            current.manualMarqueeEnabled,
            current.joinPopoverUserId,
            current.loopsRemainingStore,
            current.marqueeEnabled
        })

        React.useEffect(function()
            if current.marqueeEnabled == false then
                return
            end
            local loopsRemainingStore = current.loopsRemainingStore
            local getHomeFocusVersion = if loopsRemainingStore == nil then nil else loopsRemainingStore.getHomeFocusVersion

            if getHomeFocusVersion == nil then
                return
            end

            local var24 = nil
            return Signals.createEffect(function(arg1)
                local homeFocusVersion = getHomeFocusVersion(arg1)
                if var24 == homeFocusVersion then
                    return
                end
                local bool1 = var24 == nil
                var24 = homeFocusVersion
                if bool1 then
                    return
                end
                var14.current()
            end)
        end, { current.loopsRemainingStore, current.marqueeEnabled })

        return {
            activeByIndex = activeByIndex,
            isPaused = isPaused,
            loopsRemainingRef = loopsRemainingRef,
            onMarqueeFinished = onMarqueeFinished,
            onManualMarqueeStart = onManualMarqueeStart,
            onManualMarqueeEnd = onManualMarqueeEnd,
            marqueeRunId = marqueeRunId
        }
    end
}
