-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact08
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local ScrollHostLifecyclePhase = require(ViewRecyclerRoblox.RobloxAdapter.ScrollHostLifecyclePhase)
local axisMap = require(ViewRecyclerRoblox.RobloxAdapter.axisMap)

local module = {}

local function normalizeScrollOffset(num1: number, viewportLength: number, contentLength: number): number -- Luacid: Inlined by compiler; 10 call sites recovered
    return math.clamp(num1, 0, math.max(0, contentLength - viewportLength))
end

function module.new(tbl1)
    local getCurrent = tbl1.getCurrent
    local configuration = tbl1.getConfiguration()
    local axis = configuration.axis
    local disconnected = ScrollHostLifecyclePhase.Disconnected
    local num1 = 0
    local currentInstance = nil
    local canvasSize

    if FFlagViewRecyclerReact084 then
        canvasSize = nil
    else
        canvasSize = nil
        if FFlagViewRecyclerReact08 then
            canvasSize = nil
        end
    end
    local tbl2 = {}
    local num2 = 0
    local scrollOffset = nil
    local var1 = nil

    local var2 = if FFlagViewRecyclerReact084 then nil else nil

    local var3 = nil
    local getCanvasOriginOffset = 0
    local num4 = 0
    local connection = nil
    local tbl3 = ({})
    local bool1 = false
    local num5 = 0
    local connection2 = nil
    local var4 = nil
    local axis2 = nil
    local var5 = nil

    local viewportLength = nil
    local connection3 = nil
    if FFlagViewRecyclerReact084 then
        viewportLength = nil

        connection3 = nil
    end

    local function sampleConfiguration() -- Luacid: Inlined by compiler; 1 call site recovered
        configuration = tbl1.getConfiguration()
        return configuration
    end

    local function resolveInstance(bool2: boolean) -- Luacid: Inlined by compiler; 9 call sites recovered
        return bool2 or tbl1.getInstance()
    end

    local function getViewportState(arg1)
        local var6 = arg1 or resolveInstance(false)

        if var6 == nil then
            return nil
        end
        local axis3 = configuration.axis
        return {
            scrollOffset = axisMap.mainOf(var6.CanvasPosition, axis3),
            viewportLength = axisMap.mainOf(var6.AbsoluteWindowSize, axis3),
            crossAxisLength = axisMap.crossOf(var6.AbsoluteWindowSize, axis3)
        }
    end

    local function setHostScrollOffset(num6: number): boolean
        local var6 = resolveInstance(false)

        if var6 == nil then
            return false
        end
        local canvasPosition = var6.CanvasPosition
        var6.CanvasPosition = if configuration.axis == ViewRecycler.Axis.X then Vector2.new(num6, canvasPosition.Y) else Vector2.new(canvasPosition.X, num6)

        return true
    end

    local function observeHostOffset(kind, offset: number) -- Luacid: Inlined by compiler; 7 call sites recovered
        tbl1.observeScrollOffset({ kind = kind, offset = offset })
    end

    local function getLogicalScrollOffset(tbl4): number -- Luacid: Inlined by compiler; 9 call sites recovered
        return normalizeScrollOffset(tbl4.scrollOffset - getCanvasOriginOffset, tbl4.viewportLength, getCurrent().contentLength)
    end

    local function notifyLogicalScrollOffset(num6: number) -- Luacid: Inlined by compiler; 9 call sites recovered
        local onScrollOffsetChanged = configuration.onScrollOffsetChanged
        if onScrollOffsetChanged ~= nil and num6 ~= var3 then
            onScrollOffsetChanged(num6)
            var3 = num6
        end
    end

    local function setCanvasOriginOffset(num6: number, bool2: boolean?) -- Luacid: unused: defined but never referenced
        if getCanvasOriginOffset == num6 then
            return
        end
        getCanvasOriginOffset = num6
        local onCanvasOriginMoved = tbl1.onCanvasOriginMoved
        if onCanvasOriginMoved ~= nil and bool2 ~= false then
            onCanvasOriginMoved()
        end
    end

    local function reportHostWrite(tbl4) -- Luacid: unused: defined but never referenced
        local num6 = getLogicalScrollOffset(tbl4)

        observeHostOffset(ViewRecycler.ScrollObservationKind.Programmatic, num6)

        scrollOffset = tbl4.scrollOffset
        var1 = num6

        if FFlagViewRecyclerReact084 then
            var2 = tbl4.scrollOffset
            notifyLogicalScrollOffset(num6)
        end
    end

    local function publishCanvas()
        local num6 = math.max(0, getCurrent().contentLength + getCanvasOriginOffset)
        local instance = tbl1.getInstance()
        if instance ~= nil then
            local var6 = if var4 == instance and axis2 == configuration.axis then var5 else nil

            if var6 == num6 then
                return num6
            end

            if disconnected ~= ScrollHostLifecyclePhase.Synchronized or var6 == nil then
                instance.CanvasSize = axisMap.canvasSizeFor(num6, configuration.axis)
            elseif var6 <= num6 then
                num2 += 1
                instance.CanvasSize = axisMap.canvasSizeFor(num6, configuration.axis)
                num2 -= 1
            else
                local viewportState = getViewportState(instance)
                num2 += 1
                instance.CanvasSize = axisMap.canvasSizeFor(num6, configuration.axis)
                if viewportState ~= nil then
                    local num3 = math.clamp(viewportState.scrollOffset, 0, math.max(0, num6 - viewportState.viewportLength))
                    if num3 ~= viewportState.scrollOffset then
                        setHostScrollOffset(num3)
                        local tbl4 = {
                            scrollOffset = num3,
                            viewportLength = viewportState.viewportLength,
                            crossAxisLength = viewportState.crossAxisLength
                        }
                        local num8 = getLogicalScrollOffset(tbl4)

                        observeHostOffset(ViewRecycler.ScrollObservationKind.Programmatic, num8)

                        scrollOffset = tbl4.scrollOffset
                        var1 = num8

                        if FFlagViewRecyclerReact084 then
                            var2 = tbl4.scrollOffset
                            notifyLogicalScrollOffset(num8)
                        end
                    end
                end
                num2 -= 1
            end
            var4 = instance
            axis2 = configuration.axis
            var5 = num6
        end
        return num6
    end

    local var6 = nil
    var6 = FFlagViewRecyclerReact084 and function(tbl4) -- name: publishViewportSize
        viewportLength = tbl4.viewportLength
        tbl1.setViewportSize(tbl4.viewportLength, tbl4.crossAxisLength)
    end or var6

    local function applyProgrammaticScrollOffset(num6: number)
        if disconnected ~= ScrollHostLifecyclePhase.Synchronized then
            return
        end
        assert(num6 == num6 and num6 ~= math.huge and num6 ~= -math.huge, "ScrollHost: invalid offset")
        num2 += 1
        setHostScrollOffset(num6)
        local var7 = resolveInstance(false)

        local viewportState = getViewportState(var7)

        if viewportState ~= nil then
            local num7 = getLogicalScrollOffset(viewportState)

            observeHostOffset(ViewRecycler.ScrollObservationKind.Programmatic, num7)

            scrollOffset = viewportState.scrollOffset
            var1 = num7

            if FFlagViewRecyclerReact084 then
                var2 = viewportState.scrollOffset
                notifyLogicalScrollOffset(num7)
            end
        end
        num2 -= 1
    end

    local function stopIdleObservation() -- Luacid: Inlined by compiler; 3 call sites recovered
        if connection ~= nil then
            connection:Disconnect()
            connection = nil
        end
        num4 = 0
    end

    local function stopRecentHostScroll() -- Luacid: Inlined by compiler; 3 call sites recovered
        bool1 = false
        if connection2 ~= nil then
            connection2:Disconnect()
            connection2 = nil
        end
    end

    local stopAnimationClock = nil
    local syncAnimationClock = nil
    local stopAnimation = nil
    if FFlagViewRecyclerReact084 then
        stopAnimationClock = function()
            if connection3 ~= nil then
                connection3:Disconnect()
                connection3 = nil
            end
        end

        syncAnimationClock = function(arg1)
            if arg1.animatedScrollTarget == nil or disconnected ~= ScrollHostLifecyclePhase.Synchronized then
                stopAnimationClock()
            elseif connection3 == nil then
                connection3 = RunService.Heartbeat:Connect(function(deltaTime: number)
                    tbl1.stepAnimatedScroll(deltaTime)
                end)
            end
        end

        stopAnimation = function()
            if connection3 ~= nil then
                tbl1.stopAnimatedScroll()
            end
        end
    end

    local function markRecentHostScroll() -- Luacid: Inlined by compiler; 1 call site recovered
        bool1 = true
        num5 = 0
        if connection2 ~= nil then
            return
        end

        connection2 = RunService.Heartbeat:Connect(function()
            num5 += 1
            if num5 >= 2 then
                stopRecentHostScroll()
            end
        end)
    end

    local function getScrollVelocity(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
        return axisMap.mainOf(arg1:GetScrollVelocity(), configuration.axis)
    end

    local function isHostScrolling() -- Luacid: Inlined by compiler; 3 call sites recovered
        if next(tbl3) ~= nil then
            return true
        end

        local var7 = resolveInstance(false)

        if var7 == nil then
            return false
        end

        return math.abs((getScrollVelocity(var7))) >= 0.5 or bool1
    end

    local function isAtLeadingScrollBoundary(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        local var7 = resolveInstance(false)

        return not (var7 == nil) and axisMap.mainOf(var7.CanvasPosition, configuration.axis) <= 0.5
    end

    local function settleCanvasOriginOffset(num6: number?)
        if getCanvasOriginOffset == 0 then
            stopIdleObservation()
            return
        end
        local viewportState = getViewportState(nil)
        if viewportState == nil then
            return
        end

        local num7 = num6 or getLogicalScrollOffset(viewportState)

        local bool2 = getCanvasOriginOffset > 0

        if getCanvasOriginOffset ~= 0 then
            getCanvasOriginOffset = 0
            local onCanvasOriginMoved = tbl1.onCanvasOriginMoved
            if onCanvasOriginMoved ~= nil then
                onCanvasOriginMoved()
            end
        end

        if bool2 then
            applyProgrammaticScrollOffset(num7)
            publishCanvas()
        else
            publishCanvas()
            applyProgrammaticScrollOffset(num7)
        end

        notifyLogicalScrollOffset(num7)
        stopIdleObservation()
    end

    local function observeUntilIdle() -- Luacid: Inlined by compiler; 1 call site recovered
        if connection ~= nil or getCanvasOriginOffset == 0 then
            return
        end
        connection = RunService.Heartbeat:Connect(function()
            if isHostScrolling() then
                num4 = 0
                return
            end
            num4 += 1
            if num4 >= 2 then
                settleCanvasOriginOffset(nil)
            end
        end)
    end

    local function disconnectHost()
        if FFlagViewRecyclerReact084 then
            stopAnimation()
        end

        stopIdleObservation()
        stopRecentHostScroll()

        for _, value in tbl2 do
            value:Disconnect()
        end
        table.clear(tbl2)
        table.clear(tbl3)
        local var7, var8

        if FFlagViewRecyclerReact084 then
            var7 = currentInstance
            var8 = canvasSize
        else
            var7 = nil
            var8 = nil
        end

        if if FFlagViewRecyclerReact084 then not (var7 == nil) and var8 ~= nil else FFlagViewRecyclerReact08 then
            if FFlagViewRecyclerReact084 then
                var7.CanvasSize = var8
            else
                local var9 = currentInstance
                local var10 = canvasSize
                if var9 ~= nil and var10 ~= nil then
                    var9.CanvasSize = var10
                end
                canvasSize = nil
            end
        end

        if FFlagViewRecyclerReact084 then
            canvasSize = nil
        end
        currentInstance = nil
        var4 = nil
        axis2 = nil
        var5 = nil

        if FFlagViewRecyclerReact084 then
            viewportLength = nil
        end
        scrollOffset = nil
        var1 = nil

        if FFlagViewRecyclerReact084 then
            var2 = nil
        end
        var3 = nil

        if getCanvasOriginOffset == 0 then
            return
        end
        getCanvasOriginOffset = 0
        local onCanvasOriginMoved = tbl1.onCanvasOriginMoved
        if onCanvasOriginMoved ~= nil then
            onCanvasOriginMoved()
        end
    end

    local function synchronizeViewport(instance)
        if disconnected ~= ScrollHostLifecyclePhase.Synchronized then
            return
        end
        local viewportState = getViewportState(instance)
        if viewportState == nil then
            return
        end

        if FFlagViewRecyclerReact084 then
            var6(viewportState)
        else
            tbl1.setViewportSize(viewportState.viewportLength, viewportState.crossAxisLength)
            local viewportState2 = if FFlagViewRecyclerReact08 then nil else getViewportState(instance)

            if if FFlagViewRecyclerReact08 then num2 == 0 else viewportState2 ~= nil then
                if FFlagViewRecyclerReact08 then
                    local viewportState3 = getViewportState(instance)
                    if viewportState3 == nil then
                        viewportState3 = viewportState
                    end

                    viewportState = viewportState3
                    local num6 = getLogicalScrollOffset(viewportState)

                    observeHostOffset(ViewRecycler.ScrollObservationKind.Programmatic, num6)

                    scrollOffset = viewportState.scrollOffset
                    var1 = num6

                    if FFlagViewRecyclerReact084 then
                        var2 = viewportState.scrollOffset
                        notifyLogicalScrollOffset(num6)
                    end
                else
                    viewportState = viewportState2
                end
            end
        end

        if if FFlagViewRecyclerReact084 then num2 == 0 else not FFlagViewRecyclerReact08 then
            if FFlagViewRecyclerReact084 then
                local viewportState2 = getViewportState(instance)
                if viewportState2 ~= nil then
                    viewportState = viewportState2
                end
            end

            local num6 = getLogicalScrollOffset(viewportState)

            observeHostOffset(ViewRecycler.ScrollObservationKind.Programmatic, num6)

            scrollOffset = viewportState.scrollOffset
            var1 = num6

            if FFlagViewRecyclerReact084 then
                var2 = viewportState.scrollOffset
                notifyLogicalScrollOffset(num6)
            end
        end

        local onViewportChanged = configuration.onViewportChanged
        if onViewportChanged ~= nil then
            onViewportChanged(instance.AbsoluteWindowSize)
        end
    end

    local function synchronizeScrollOffset(instance, bool2: boolean?)
        if disconnected ~= ScrollHostLifecyclePhase.Synchronized then
            return
        end
        local viewportState = getViewportState(instance)
        if viewportState == nil then
            return
        end

        local num6 = getLogicalScrollOffset(viewportState)

        if FFlagViewRecyclerReact084 then
            var2 = viewportState.scrollOffset
        end
        local bool3 = num2 == 0
        if bool3 and scrollOffset ~= nil then
            if math.abs(viewportState.scrollOffset - scrollOffset) < 0.5 then
                bool3 = false
            else
                scrollOffset = nil
            end
        end

        if FFlagViewRecyclerReact084 then
            local var7 = viewportLength
            if bool3 and var7 ~= nil and viewportState.viewportLength ~= var7 then
                local num7 = math.max(0, axisMap.mainOf(instance.AbsoluteCanvasSize, configuration.axis) - viewportState.viewportLength)
                local bool4 = var7 < viewportState.viewportLength and math.abs(viewportState.scrollOffset - num7) < 0.5
                local var8 = viewportState.scrollOffset - getCanvasOriginOffset
                var6(viewportState)
                viewportState = getViewportState(instance) or viewportState
                if bool4 then
                    local num8 = getLogicalScrollOffset(viewportState)

                    observeHostOffset(ViewRecycler.ScrollObservationKind.Programmatic, num8)

                    scrollOffset = viewportState.scrollOffset
                    var1 = num8

                    if FFlagViewRecyclerReact084 then
                        var2 = viewportState.scrollOffset
                        notifyLogicalScrollOffset(num8)
                        bool3 = false
                    else
                        bool3 = false
                    end
                elseif viewportState.scrollOffset ~= var8 + getCanvasOriginOffset then
                    num2 += 1
                    setHostScrollOffset(var8 + getCanvasOriginOffset)
                    num2 -= 1
                    viewportState = getViewportState(instance) or viewportState
                    scrollOffset = viewportState.scrollOffset
                end

                num6 = getLogicalScrollOffset(viewportState)
            end
        end

        if bool3 and bool2 == true then
            markRecentHostScroll()
        end

        if bool3 and num6 ~= var1 then
            observeHostOffset(ViewRecycler.ScrollObservationKind.User, num6)
            var1 = num6
        end
        if bool3 and getCanvasOriginOffset ~= 0 then
            num4 = 0
            if viewportState.scrollOffset <= 0.5 then
                settleCanvasOriginOffset(nil)
            end
        end

        notifyLogicalScrollOffset(num6)
    end

    local function isPointerInput(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return arg1.UserInputType == Enum.UserInputType.Touch or arg1.UserInputType == Enum.UserInputType.MouseButton1
    end

    local function connectHost(instance)
        if currentInstance == instance then
            return
        end
        disconnectHost()
        currentInstance = instance
        if instance == nil or typeof(instance) ~= "Instance" then
            return
        end

        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            canvasSize = instance.CanvasSize
        end

        local tbl4 = tbl2
        local absoluteWindowSizeChanged = instance:GetPropertyChangedSignal("AbsoluteWindowSize")

        table.insert(tbl4, absoluteWindowSizeChanged:Connect(function()
            configuration = tbl1.getConfiguration()

            publishCanvas()
            synchronizeViewport(instance)
        end))

        local tbl5 = tbl2
        local canvasPositionChanged = instance:GetPropertyChangedSignal("CanvasPosition")

        table.insert(tbl5, canvasPositionChanged:Connect(function()
            configuration = tbl1.getConfiguration()

            synchronizeScrollOffset(instance, true)
        end))

        local tbl6 = tbl2
        local var7 = if FFlagViewRecyclerReact084 then RunService.RenderStepped else instance.InputBegan

        table.insert(tbl6, var7:Connect(FFlagViewRecyclerReact084 and function()
            if disconnected == ScrollHostLifecyclePhase.Synchronized
                and axisMap.mainOf(instance.CanvasPosition, configuration.axis) ~= var2
            then
                configuration = tbl1.getConfiguration()

                synchronizeScrollOffset(instance, true)
            end
        end or function(arg1)
            if isPointerInput(arg1) then
                tbl3[arg1] = true
            end
        end))

        if FFlagViewRecyclerReact084 then
            local tbl7 = tbl2
            local inputBegan = instance.InputBegan

            table.insert(tbl7, inputBegan:Connect(function(input: InputObject)
                if isPointerInput(input) then
                    tbl3[input] = true
                    stopAnimation()
                end
            end))

            local tbl8 = tbl2
            local inputChanged = instance.InputChanged

            table.insert(tbl8, inputChanged:Connect(function(input: InputObject)
                if input.UserInputType == Enum.UserInputType.MouseWheel then
                    stopAnimation()
                end
            end))
        end

        local tbl7 = tbl2
        local inputEnded = instance.InputEnded

        table.insert(tbl7, inputEnded:Connect(function(input: InputObject)
            tbl3[input] = nil
        end))

        local tbl8 = tbl2
        local inputEnded2 = UserInputService.InputEnded

        table.insert(tbl8, inputEnded2:Connect(function(input: InputObject)
            tbl3[input] = nil
        end))
    end

    return {
        connect = function()
            assert(disconnected == ScrollHostLifecyclePhase.Disconnected, "ScrollHost: already connected")
            num1 += 1
            local num6 = num1
            configuration = tbl1.getConfiguration()

            axis = configuration.axis
            disconnected = ScrollHostLifecyclePhase.Priming
            connectHost(tbl1.getInstance())
            local success, result = pcall(function()
                disconnected = ScrollHostLifecyclePhase.Synchronized
                publishCanvas()
                local instance = tbl1.getInstance()
                if instance ~= nil then
                    synchronizeViewport(instance)
                    synchronizeScrollOffset(instance)
                end
            end)
            if not success then
                disconnected = ScrollHostLifecyclePhase.Disconnected
                disconnectHost()
                error(result, 0)
            end
            local bool2 = false
            return function()
                if bool2 then
                    return
                end
                bool2 = true
                if disconnected ~= ScrollHostLifecyclePhase.Disconnected and num1 == num6 then
                    disconnected = ScrollHostLifecyclePhase.Disconnected
                    disconnectHost()
                end
            end
        end,
        scrollingFrameChanged = function()
            if disconnected == ScrollHostLifecyclePhase.Disconnected then
                return
            end

            configuration = tbl1.getConfiguration()

            local instance = tbl1.getInstance()
            connectHost(instance)
            if instance ~= nil then
                publishCanvas()
                synchronizeViewport(instance)
                synchronizeScrollOffset(instance)
            end
        end,
        configurationChanged = function()
            local var7 = sampleConfiguration()
            local bool2 = var7.axis ~= axis
            axis = var7.axis
            if disconnected == ScrollHostLifecyclePhase.Disconnected or not bool2 then
                return
            end

            local instance = tbl1.getInstance()
            if instance ~= nil then
                publishCanvas()
                synchronizeViewport(instance)
                synchronizeScrollOffset(instance)
            end
        end,
        applyRecord = function(arg1, callback: (...any) -> (...any))
            if FFlagViewRecyclerReact084 then
                syncAnimationClock(arg1)
            end
            if disconnected == ScrollHostLifecyclePhase.Disconnected then
                callback()
                return
            end

            configuration = tbl1.getConfiguration()

            local scrollCorrection = arg1.scrollCorrection
            local scrollOffset2 = if arg1.scrollPositionChanged then arg1.scrollState.scrollOffset else nil
            local bool2 = not (scrollCorrection == 0 and getCanvasOriginOffset == 0) and isHostScrolling()
            local scrollPositionFollowsCorrection

            if scrollCorrection == 0 then
                scrollPositionFollowsCorrection = false
            else
                scrollPositionFollowsCorrection = arg1.scrollPositionFollowsCorrection

                if scrollPositionFollowsCorrection then
                    if bool2 then
                        scrollPositionFollowsCorrection = not isAtLeadingScrollBoundary()
                    else
                        scrollPositionFollowsCorrection = bool2
                    end
                end
            end

            if scrollPositionFollowsCorrection then
                local var7 = getCanvasOriginOffset - scrollCorrection

                if getCanvasOriginOffset ~= var7 then
                    getCanvasOriginOffset = var7
                    if tbl1.onCanvasOriginMoved == nil then
                    end
                end

                callback()

                if tbl1.onCanvasOriginMoved ~= nil then
                    tbl1.onCanvasOriginMoved()
                end
                publishCanvas()
                num4 = 0
                observeUntilIdle()

                if scrollOffset2 ~= nil then
                    var1 = scrollOffset2
                    notifyLogicalScrollOffset(scrollOffset2)
                end
            else
                callback()

                if getCanvasOriginOffset ~= 0 and (scrollOffset2 ~= nil or not bool2) then
                    settleCanvasOriginOffset(scrollOffset2)
                else
                    if arg1.scrollPositionChanged or arg1.contentLengthChanged then
                        publishCanvas()
                    end
                    if scrollOffset2 ~= nil then
                        applyProgrammaticScrollOffset(scrollOffset2)
                    end
                end
            end
            if arg1.contentLengthChanged then
                local onContentLengthChanged = configuration.onContentLengthChanged
                if onContentLengthChanged ~= nil then
                    onContentLengthChanged(arg1.contentLength)
                end
            end

            if arg1.startReached and configuration.onStartReached ~= nil then
                configuration.onStartReached()
            end
            if arg1.endReached and configuration.onEndReached ~= nil then
                configuration.onEndReached()
            end
        end,
        getCanvasOriginOffset = function()
            return getCanvasOriginOffset
        end,
        isReady = function(): boolean
            configuration = tbl1.getConfiguration()

            return getViewportState(nil) ~= nil
        end
    }
end

return module
