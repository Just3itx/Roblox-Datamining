-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact08
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local _ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local AbsolutePlacement = require(ViewRecyclerRoblox.RobloxAdapter.AbsolutePlacement)
local CanvasItemPlacer = require(ViewRecyclerRoblox.RobloxAdapter.CanvasItemPlacer)
local HostMeasurement = require(ViewRecyclerRoblox.RobloxAdapter.HostMeasurement)
local HostPresentationPhase = require(ViewRecyclerRoblox.RobloxAdapter.HostPresentationPhase)
local ReparentableHost = require(ViewRecyclerRoblox.RobloxAdapter.ReparentableHost)
local StackPlacement = require(ViewRecyclerRoblox.RobloxAdapter.StackPlacement)

local _VacantHosts = require(ViewRecyclerRoblox.RobloxAdapter.VacantHosts)

local module = {}

local function zero(): number
    return 0
end

function module.new(tbl1)
    local tbl2 = {
        container = tbl1.container,
        viewportContainer = tbl1.viewportContainer,
        axis = tbl1.axis,
        selfSizing = tbl1.selfSizing,
        stackedSpacing = tbl1.stackedSpacing
    }
    local tbl3 = ({})
    local var1 = nil
    local var2 = nil
    local bool1 = false
    local getTrackedItemViewCount = 0
    local bool2 = false
    local var3 = tbl1.getCanvasOriginOffset or zero

    local vacantHosts = if FFlagViewRecyclerReact084 then tbl1.vacantHosts else nil

    local absolutePlacement = AbsolutePlacement.new(tbl2.axis, tbl2.selfSizing, var3)

    local function commitStack() -- Luacid: Inlined by compiler; 2 call sites recovered
        if var1 ~= nil and not bool1 then
            var1.commit()
        end
    end

    local hostMeasurement = HostMeasurement.new({
        axis = tbl2.axis,
        isUnchanged = function(): boolean
            local var4 = var1
            local bool3 = var4 == nil or not var4.takeChanged()
            for _, value in tbl3 do
                local host = value.host
                if not value.measuring or host == nil or var4 ~= nil and var4.isStacked(host) then
                    continue
                end

                local absoluteSize = host.AbsoluteSize
                if value.checkedSize ~= absoluteSize then
                    value.checkedSize = absoluteSize
                    bool3 = false
                end
            end

            return bool3
        end,
        onItemMeasurements = tbl1.onItemMeasurements
    })

    local function stopMeasuring(arg1, tbl4) -- Luacid: Inlined by compiler; 2 call sites recovered
        tbl4.checkedSize = nil
        if tbl4.measuring then
            tbl4.measuring = false
            hostMeasurement.measure(arg1, nil, nil)
        end
    end

    local leaveHost = nil
    local isContainer = nil
    local detachHost = nil
    if FFlagViewRecyclerReact084 then
        leaveHost = function(arg1, tbl4)
            local host = tbl4.host
            if host ~= nil then
                if var1 ~= nil then
                    var1.remove(host)
                end
                CanvasItemPlacer.release(host, tbl4.placerState)
                absolutePlacement.remove(host)
                vacantHosts.leave(host)
                tbl4.host = nil
            end

            stopMeasuring(arg1, tbl4)
        end

        isContainer = function(arg1)
            return arg1 == tbl2.container or arg1 == tbl2.viewportContainer or not (var1 == nil) and var1.isStackFrame(arg1)
        end
    else
        detachHost = function(arg1, tbl4)
            local host = tbl4.host
            if host ~= nil then
                if var1 ~= nil then
                    var1.remove(host)
                end
                ReparentableHost.clearSelection(host)
                CanvasItemPlacer.detachForTransfer(host, tbl4.placerState)
                absolutePlacement.remove(host)
                tbl4.host = nil
            end

            stopMeasuring(arg1, tbl4)
        end
    end

    local function getEntry(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local tbl4 = tbl3[arg1]
        if tbl4 == nil then
            tbl4 = {
                placerState = CanvasItemPlacer.createState(),
                host = nil,
                physicalState = nil,
                presentedAssignment = nil,
                measuring = false,
                checkedSize = nil
            }

            tbl3[arg1] = tbl4
            getTrackedItemViewCount += 1
        end
        return tbl4
    end

    local function reportPresentation(arg1, tbl4, presentedAssignment) -- Luacid: Inlined by compiler; 3 call sites recovered
        if tbl4.presentedAssignment == presentedAssignment then
            return
        end
        tbl4.presentedAssignment = presentedAssignment
        local onItemViewPresentationChanged = tbl1.onItemViewPresentationChanged
        if onItemViewPresentationChanged ~= nil then
            onItemViewPresentationChanged(arg1, presentedAssignment)
        end
    end

    local function applyPhysical(arg1, tbl4)
        local physicalState = tbl4.physicalState
        if physicalState == nil then
            if FFlagViewRecyclerReact084 then
                leaveHost(arg1, tbl4)
            else
                detachHost(arg1, tbl4)
            end

            reportPresentation(arg1, tbl4, nil)
            return
        end
        local state = physicalState.state
        local host = physicalState.host
        if tbl4.host ~= nil and tbl4.host ~= host then
            if FFlagViewRecyclerReact084 then
                leaveHost(arg1, tbl4)
            else
                detachHost(arg1, tbl4)
            end
        end

        local bool3 = if FFlagViewRecyclerReact084 then state.viewportPlacement ~= nil elseif FFlagViewRecyclerReact08 then state.viewportPlacement ~= nil else not (state.viewportPlacement == nil) and tbl2.viewportContainer ~= nil
        local num2 = if bool3 then tbl2.viewportContainer else tbl2.container

        if num2 == nil then
            if FFlagViewRecyclerReact084 then
                leaveHost(arg1, tbl4)
            else
                detachHost(arg1, tbl4)
            end

            reportPresentation(arg1, tbl4, nil)
            return
        end

        if FFlagViewRecyclerReact084 then
            vacantHosts.reclaim(host)
        end
        local var4 = var1
        local var5

        if var4 ~= nil and not bool3 and StackPlacement.isPlacedFromLayoutOffsets(state) then
            var5 = var4.place(host, tbl4.placerState, state, physicalState.phase)
            absolutePlacement.remove(host)
        else
            if var4 ~= nil then
                var4.remove(host)
            end

            var5 = absolutePlacement.place(host, tbl4.placerState, num2, state, not bool3, physicalState.phase)
        end
        if not var5 then
            ReparentableHost.clearSelection(host)
        end
        tbl4.host = host
        local bool4 = physicalState.phase == HostPresentationPhase.Presented
        local num3 = tbl2.selfSizing or state.pinnedPosition ~= nil
        local measuring = bool4 and num3
        tbl4.measuring = measuring
        if num3 and not bool4 then
            hostMeasurement.pause(arg1, host)
        else
            hostMeasurement.measure(arg1, host, if measuring then state else nil)
        end

        local assignment = if bool4 then state.assignment else nil
        reportPresentation(arg1, tbl4, assignment)
    end

    local function syncStack()
        local container = tbl2.container
        local stackedSpacing = tbl2.stackedSpacing
        local var4 = var1
        local bool3 = not (stackedSpacing == nil) and container ~= nil

        if var4 ~= nil and bool3 and var4.matches(container, tbl2.axis, stackedSpacing, tbl2.selfSizing) then
            return
        end
        if var4 ~= nil then
            for value, value2 in tbl3 do
                if value2.host == nil or not var4.isStacked(value2.host) then
                    continue
                end

                if FFlagViewRecyclerReact084 then
                    leaveHost(value, value2)
                else
                    detachHost(value, value2)
                end
            end

            var4.destroy()
            var1 = nil
        end
        if not bool3 then
            return
        end

        local stackPlacement = StackPlacement.new(container, tbl2.axis, stackedSpacing, tbl2.selfSizing)

        if var2 ~= nil then
            stackPlacement.setWindow(var2, var3())
        end
        var1 = stackPlacement
    end

    local function releaseEntryIfVacant(arg1, entry) -- Luacid: Inlined by compiler; 1 call site recovered
        if entry.physicalState == nil and tbl3[arg1] == entry then
            tbl3[arg1] = nil
            getTrackedItemViewCount -= 1
        end
    end

    syncStack()

    return {
        apply = function(arg1, physicalState)
            assert(not bool2, "HostPlacement: cannot apply physical state after destroy")
            local entry = getEntry(arg1)
            entry.physicalState = physicalState
            applyPhysical(arg1, entry)
            releaseEntryIfVacant(arg1, entry)
            commitStack()
        end,
        setConfiguration = function(arg1)
            if bool2 then
                return
            end

            if FFlagViewRecyclerReact084 and (arg1.container ~= tbl2.container or arg1.viewportContainer ~= tbl2.viewportContainer) then
                vacantHosts.evacuate(isContainer)
            end

            tbl2 = arg1
            hostMeasurement.setAxis(tbl2.axis)
            absolutePlacement.setConfiguration(tbl2.axis, tbl2.selfSizing)
            syncStack()
            for value, value2 in tbl3 do
                applyPhysical(value, value2)
            end

            commitStack()
        end,
        reposition = function()
            if bool2 then
                return
            end
            local var4 = var3()
            absolutePlacement.setOriginOffset(var4)
            if var1 ~= nil then
                var1.setOriginOffset(var4)
            end
        end,
        setMountedWindow = function(arg1, callback)
            if bool2 then
                callback()
                return
            end
            var2 = arg1
            local var4 = var1
            if var4 == nil then
                callback()
                return
            end
            var4.setWindow(arg1, var3())
            bool1 = true
            local success, result = pcall(callback)
            bool1 = false
            if var1 == var4 then
                local tbl4 = ({})
                for _, value in var4.getStaleHosts() do
                    tbl4[value] = true
                end
                for value, value2 in tbl3 do
                    if value2.host ~= nil and tbl4[value2.host] then
                        applyPhysical(value, value2)
                    end
                end
                var4.commit()
            end
            if not success then
                error(result, 0)
            end
        end,
        cancelPendingMeasurements = function()
            hostMeasurement.cancelPending()
        end,
        hasDestroyedHost = FFlagViewRecyclerReact084 and function()
            for _, value in tbl3 do
                if value.host ~= nil and value.host.Parent == nil then
                    return true
                end
            end
            return false
        end or FFlagViewRecyclerReact08 and function()
            for _, value in tbl3 do
                if value.host ~= nil and value.host.Parent == nil then
                    return true
                end
            end
            return false
        end or nil,
        getTrackedItemViewCount = function()
            return getTrackedItemViewCount
        end,
        isPrePaintPassConnected = function()
            return hostMeasurement.isPassConnected()
        end,
        getPrePaintReadCount = function()
            return hostMeasurement.getPassReadCount()
        end,
        destroy = function()
            if bool2 then
                return
            end
            bool2 = true
            hostMeasurement.destroy()
            for value, value2 in tbl3 do
                if FFlagViewRecyclerReact084 then
                    leaveHost(value, value2)
                else
                    detachHost(value, value2)
                end
            end

            if FFlagViewRecyclerReact084 then
                vacantHosts.evacuate(isContainer)
            end
            absolutePlacement.destroy()
            if var1 ~= nil then
                var1.destroy()
                var1 = nil
            end
            table.clear(tbl3)
            getTrackedItemViewCount = 0
        end
    }
end

return module
