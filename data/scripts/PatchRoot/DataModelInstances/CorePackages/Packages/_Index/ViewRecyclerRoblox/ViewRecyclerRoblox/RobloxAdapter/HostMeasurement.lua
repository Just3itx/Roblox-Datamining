-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact08
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local _ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local MeasurementBatcher = require(ViewRecyclerRoblox.RobloxAdapter.MeasurementBatcher)
local Measurer = require(ViewRecyclerRoblox.RobloxAdapter.Measurer)

local axisMap = require(ViewRecyclerRoblox.RobloxAdapter.axisMap)

local RunService = game:GetService("RunService")

local module = {}

function module.new(tbl1)
    local axis = tbl1.axis
    local tbl2 = ({})
    local num1 = 0
    local bool1 = false

    local bool2 = true
    local connection = nil
    local getPassReadCount = 0

    local measurementBatcher = nil
    local var1, deliver, queue, reportedState, publish, measureNow, scheduleRead, disconnect

    if FFlagViewRecyclerReact084 then
        var1 = nil

        deliver = function()
            local var2 = var1
            if bool1 or var2 == nil then
                return nil
            end
            var1 = nil
            tbl1.onItemMeasurements(var2)
            return var2
        end

        queue = function(arg1)
            local tbl3 = var1
            if tbl3 == nil then
                tbl3 = {}
                var1 = tbl3
                task.defer(function()
                    if var1 == tbl3 then
                        deliver()
                    end
                end)
            end
            table.insert(tbl3, arg1)
        end

        reportedState = function(tbl3)
            return if tbl2[tbl3.itemView] == tbl3 and not tbl3.paused then tbl3.state else nil
        end

        publish = function(tbl3, lastPublishedState): boolean
            if lastPublishedState.assignment ~= tbl3.renderedAssignment then
                return false
            end
            local host = tbl3.host
            if axisMap.crossOf(host.AbsoluteSize, axis) <= 0 then
                return true
            end

            local var2 = axisMap.mainOf(host.AbsoluteSize, axis)
            if tbl3.lastPublishedState ~= lastPublishedState or tbl3.lastPublishedLength ~= var2 then
                tbl3.lastPublishedState = lastPublishedState
                tbl3.lastPublishedLength = var2
                queue({ itemView = tbl3.itemView, state = lastPublishedState, length = var2 })
            end

            return true
        end

        measureNow = function(tbl3)
            local var2 = reportedState(tbl3)
            if var2 ~= nil then
                publish(tbl3, var2)
            end
        end

        scheduleRead = function(tbl3)
            local var2 = reportedState(tbl3)
            if var2 == nil or tbl3.pendingReads[var2] ~= nil then
                return
            end
            tbl3.pendingReads[var2] = RunService.Heartbeat:Once(function()
                tbl3.pendingReads[var2] = nil
                if reportedState(tbl3) == var2 and not publish(tbl3, var2) then
                    scheduleRead(tbl3)
                end
            end)
        end

        disconnect = function(tbl3)
            tbl3.sizeConnection:Disconnect()
            for _, pendingRead in tbl3.pendingReads do
                pendingRead:Disconnect()
            end
            table.clear(tbl3.pendingReads)
        end
    else
        var1 = nil
        deliver = nil
        queue = nil
        reportedState = nil
        publish = nil
        measureNow = nil
        scheduleRead = nil
        disconnect = nil
        measurementBatcher = nil
        if FFlagViewRecyclerReact08 then
            var1 = nil

            deliver = function()
                local var2 = var1
                if bool1 or var2 == nil then
                    return nil
                end
                var1 = nil
                tbl1.onItemMeasurements(var2)
                return var2
            end

            queue = function(arg1)
                local tbl3 = var1
                if tbl3 == nil then
                    tbl3 = {}
                    var1 = tbl3
                    task.defer(function()
                        if var1 == tbl3 then
                            deliver()
                        end
                    end)
                end
                table.insert(tbl3, arg1)
            end

            reportedState = function(tbl3)
                return if tbl2[tbl3.itemView] == tbl3 and not tbl3.paused then tbl3.state else nil
            end

            publish = function(tbl3, lastPublishedState): boolean
                if lastPublishedState.assignment ~= tbl3.renderedAssignment then
                    return false
                end
                local host = tbl3.host
                if axisMap.crossOf(host.AbsoluteSize, axis) <= 0 then
                    return true
                end

                local var2 = axisMap.mainOf(host.AbsoluteSize, axis)
                if tbl3.lastPublishedState ~= lastPublishedState or tbl3.lastPublishedLength ~= var2 then
                    tbl3.lastPublishedState = lastPublishedState
                    tbl3.lastPublishedLength = var2
                    queue({ itemView = tbl3.itemView, state = lastPublishedState, length = var2 })
                end

                return true
            end

            measureNow = function(tbl3)
                local var2 = reportedState(tbl3)
                if var2 ~= nil then
                    publish(tbl3, var2)
                end
            end

            scheduleRead = function(tbl3)
                local var2 = reportedState(tbl3)
                if var2 == nil or tbl3.pendingReads[var2] ~= nil then
                    return
                end
                tbl3.pendingReads[var2] = RunService.Heartbeat:Once(function()
                    tbl3.pendingReads[var2] = nil
                    if reportedState(tbl3) == var2 and not publish(tbl3, var2) then
                        scheduleRead(tbl3)
                    end
                end)
            end

            disconnect = function(tbl3)
                tbl3.sizeConnection:Disconnect()
                for _, pendingRead in tbl3.pendingReads do
                    pendingRead:Disconnect()
                end
                table.clear(tbl3.pendingReads)
            end
        else
            measurementBatcher = MeasurementBatcher.new(tbl1.onItemMeasurements)
        end
    end

    local function measureRounds()
        for _ = 1, 4 do
            if bool1 then
                return
            end
            if tbl1.isUnchanged() and not bool2 then
                return
            end
            bool2 = false
            for _, value in tbl2 do
                getPassReadCount += 1

                if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                    measureNow(value)
                else
                    value.measurer.measureNow()
                end
            end

            local var2 = if FFlagViewRecyclerReact084 then deliver elseif FFlagViewRecyclerReact08 then deliver else measurementBatcher.flush
            local bool3 = false

            for _, value in var2() or {} do
                if value.length ~= value.state.itemLayout.length then
                    bool3 = true
                    break
                end
            end

            if not bool3 then
                return
            end
        end
    end

    local function measureBeforePaint()
        measureRounds()
        if bool1 then
            return
        end

        for _, value in tbl2 do
            local assignment = value.state.assignment
            if value.renderedAssignment ~= assignment then
                value.renderedAssignment = assignment
                bool2 = true
            end
        end
    end

    local function syncConnection() -- Luacid: Inlined by compiler; 5 call sites recovered
        local bool3 = not bool1 and num1 > 0
        if bool3 and connection == nil then
            bool2 = true
            connection = RunService.PreRender:Connect(measureBeforePaint)
        elseif not bool3 and connection ~= nil then
            connection:Disconnect()
            connection = nil
        end
    end

    local function stop(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var2 = tbl2[arg1]
        if var2 == nil then
            return
        end

        tbl2[arg1] = nil
        num1 -= 1

        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            disconnect(var2)
        else
            var2.measurer.disconnect()
        end

        syncConnection()
    end
    local function setState(tbl3, state) -- Luacid: Inlined by compiler; 2 call sites recovered
        tbl3.state = state

        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            scheduleRead(tbl3)
        else
            tbl3.measurer.scheduleSettle()
        end
    end

    local function measure(itemView, host, state)
        if bool1 then
            return
        end
        local var2 = tbl2[itemView]
        if var2 ~= nil and (host == nil or state == nil or var2.host ~= host) then
            stop(itemView)
            var2 = nil
        end

        if host == nil or state == nil then
            return
        end

        if var2 ~= nil then
            if var2.paused then
                var2.paused = false
                bool2 = true
                setState(var2, state)
            elseif var2.state ~= state then
                setState(var2, state)
            end

            return
        end

        local tbl3 = {
            itemView = if FFlagViewRecyclerReact084 then itemView elseif FFlagViewRecyclerReact08 then itemView else nil,
            host = host,
            state = state,
            paused = false,
            renderedAssignment = nil,
            sizeConnection = nil,
            pendingReads = FFlagViewRecyclerReact084 and {} or FFlagViewRecyclerReact08 and {} or nil,
            lastPublishedState = nil,
            lastPublishedLength = nil,
            measurer = nil
        }

        if FFlagViewRecyclerReact084 then
            tbl3.sizeConnection = host:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                scheduleRead(tbl3)
            end)
        elseif FFlagViewRecyclerReact08 then
            tbl3.sizeConnection = host:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                scheduleRead(tbl3)
            end)
        else
            tbl3.measurer = Measurer.attach({
                instance = host,
                axis = axis,
                getState = function(): number?
                    return if tbl2[itemView] == tbl3 and not tbl3.paused then tbl3.state else nil
                end,
                isRendered = function(): boolean
                    return tbl3.state.assignment == tbl3.renderedAssignment
                end,
                onItemMeasured = function(state2, length)
                    measurementBatcher.add({ itemView = itemView, state = state2, length = length })
                end
            })
        end

        tbl2[itemView] = tbl3
        num1 += 1
        bool2 = true
        syncConnection()

        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            scheduleRead(tbl3)
        else
            tbl3.measurer.scheduleSettle()
        end
    end

    return {
        measure = measure,
        pause = function(itemView, host)
            local var2 = tbl2[itemView]
            if not bool1 and var2 ~= nil and var2.host == host then
                var2.paused = true
                return
            end
            measure(itemView, host, nil)
        end,
        setAxis = function(arg1)
            if arg1 == axis then
                return
            end
            axis = arg1
            local tbl3 = {}
            for value in tbl2 do
                table.insert(tbl3, value)
            end
            for _, value in tbl3 do
                stop(value)
            end
        end,
        cancelPending = function()
            if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                var1 = nil
            else
                measurementBatcher.cancelPending()
            end
        end,
        isPassConnected = function(): boolean
            return connection ~= nil
        end,
        getPassReadCount = function()
            return getPassReadCount
        end,
        getPendingReadCount = FFlagViewRecyclerReact084 and function(): number
            local num3 = 0
            for _, value in tbl2 do
                for _ in value.pendingReads do
                    num3 += 1
                end
            end
            return num3
        end or FFlagViewRecyclerReact08 and function(): number
            local num3 = 0
            for _, value in tbl2 do
                for _ in value.pendingReads do
                    num3 += 1
                end
            end
            return num3
        end or nil,
        destroy = function()
            if bool1 then
                return
            end
            bool1 = true

            if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                var1 = nil
            else
                measurementBatcher.destroy()
            end

            for _, value in tbl2 do
                if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                    disconnect(value)
                else
                    value.measurer.disconnect()
                end
            end

            table.clear(tbl2)
            num1 = 0
            syncConnection()
        end
    }
end

return module
