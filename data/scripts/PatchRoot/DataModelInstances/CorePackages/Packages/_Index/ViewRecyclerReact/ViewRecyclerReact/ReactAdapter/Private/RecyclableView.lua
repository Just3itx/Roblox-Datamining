-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact08
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local _ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)

local Destination = require(script.Parent.Destination)
local ViewRecyclerRoblox = require(ViewRecyclerReact.Parent.ViewRecyclerRoblox)
local HostPresentationPhase = ViewRecyclerRoblox.HostPresentationPhase

local PlacementKind = require(script.Parent.PlacementKind)
local React = require(ViewRecyclerReact.Parent.React)
local RecyclableViewReadiness = require(ViewRecyclerReact.ReactAdapter.RecyclableViewReadiness)
local RecyclableViewRegistry = require(script.Parent.RecyclableViewRegistry)

local ReparentableHost = nil
if not FFlagViewRecyclerReact084 then
    ReparentableHost = nil
    if not FFlagViewRecyclerReact08 then
        ReparentableHost = ViewRecyclerRoblox.ReparentableHost
    end
end
local Signals = require(ViewRecyclerReact.Parent.Signals)
local SignalsExperimental = require(ViewRecyclerReact.Parent.SignalsExperimental)
local SignalsScheduler = require(ViewRecyclerReact.Parent.SignalsScheduler)

return FFlagViewRecyclerReact084 and function(id: number, arg1, tbl1, compositionPlacement) -- name: RecyclableView
    local metadata = RecyclableViewRegistry.getMetadata(arg1)
    assert(metadata ~= nil, "RecyclableView: unknown Recyclable view type")
    local readiness = metadata.readiness
    local hideWhilePending = metadata.hideWhilePending
    local signal, var2 = Signals.createSignal(tbl1)
    local indexSignal, var4 = Signals.createSignal(nil)
    local var5, var6 = Signals.createSignal(tbl1)

    local hasItem, var8 = Signals.createSignal(tbl1 ~= nil)
    local pending, var10 = React.createBinding(false)
    local num2 = if tbl1 == nil then 0 else 1
    local func1, func2

    if readiness == RecyclableViewReadiness.ReadyOnCommit then
        local var11
        func1, var11 = Signals.createSignal(num2)
        func2 = var11
    else
        func1 = function(_)
            return num2
        end
        func2 = function(_) end
    end

    local frame = Instance.new("Frame")
    frame.Name = `ListItemViewFrame{id}`
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.Position = UDim2.new()
    frame.Size = UDim2.new()

    local connection = frame.Destroying:Connect(function() end)

    local var11 = nil
    local var12 = nil

    local list = Destination.Kind.List
    local bool1 = true
    local bool2 = false
    local var13 = nil
    local var14 = nil
    local bool3 = false
    local bool4 = false

    local var15 = nil

    local function detachState(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
        if tbl2 ~= nil then
            local destination = tbl2.destination
            Destination.behaviors[destination.kind].detach(var15, frame, destination)
        end
    end

    local function resolvePhase() -- Luacid: Inlined by compiler; 1 call site recovered
        if var12 == nil then
            return HostPresentationPhase.Hidden
        end

        if not bool2 then
            return HostPresentationPhase.Hidden
        end

        if readiness == RecyclableViewReadiness.ReadyOnAssignment or bool1 then
            return HostPresentationPhase.Presented
        end

        if hideWhilePending then
            return HostPresentationPhase.Hidden
        end

        return HostPresentationPhase.Pending
    end

    local function publish(tbl2, arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
        local destination = tbl2.destination
        Destination.behaviors[destination.kind].present(var15, frame, destination, arg3)
        var13 = tbl2
        var14 = arg3
    end

    local function func3()
        bool4 = false
        local var16 = var12
        if var16 == nil or bool3 then
            return
        end

        local var17 = resolvePhase()

        if var13 == var16 and var14 == var17 then
            return
        end

        publish(var16, var17)
    end

    local function requestPublication() -- Luacid: Inlined by compiler; 2 call sites recovered
        if not bool4 then
            bool4 = true
            SignalsScheduler.schedule(func3)
        end
    end

    local function sameDestinationOwner(arg3, arg4) -- Luacid: unused: defined but never referenced
        return arg3.kind == arg4.kind and Destination.behaviors[arg3.kind].sameOwner(arg3, arg4)
    end

    var15 = {
        id = id,
        viewType = arg1,
        itemViewType = arg1,
        signal = signal,
        indexSignal = indexSignal,
        itemSignal = function(arg3)
            local var16 = var5(arg3)
            assert(var16 ~= nil, "RecyclableView: item read before first Assignment")
            return Destination.behaviors[list].readItem(var16.value, arg3)
        end,
        itemKeySignal = function(arg3)
            local var16 = var5(arg3)
            assert(var16 ~= nil, "RecyclableView: item key read before first Assignment")
            return var16.key
        end,
        hasItem = hasItem,
        transition = function(tbl2)
            if bool3 then
                assert(tbl2 == nil, "RecyclableView: cannot transition an occupied state after destroy")
                return
            end
            local var16 = var12
            local assignment = if var16 == nil then nil else var16.assignment
            local assignment2 = if tbl2 == nil then nil else tbl2.assignment
            local destination = if var16 == nil then nil else var16.destination
            local destination2 = if tbl2 == nil then nil else tbl2.destination

            if destination ~= nil
                and (destination2 == nil
                    or destination.kind ~= destination2.kind
                    or not Destination.behaviors[destination.kind].sameOwner(destination, destination2))
            then
                detachState(var16)
                var13 = nil
                var14 = nil
            end
            if assignment ~= nil and assignment ~= assignment2 then
                local var17 = var11
                if var17 ~= nil then
                    var17.clearSelection()
                end
            end
            var12 = tbl2
            if destination2 ~= nil then
                Destination.behaviors[destination2.kind].attach(frame, destination2)
            end

            if tbl2 ~= nil and var13 == nil then
                publish(tbl2, HostPresentationPhase.Hidden)
            end

            local kind = if tbl2 == nil then nil else tbl2.destination.kind
            local bool5 = not (assignment2 == nil) and (assignment ~= assignment2 or list ~= kind)
            local bool6 = readiness == RecyclableViewReadiness.ReadyOnCommit and assignment2 ~= nil and (assignment ~= assignment2 or not bool1)

            if bool6 then
                num2 += 1
            end
            bool1 = not (assignment2 == nil) and (readiness == RecyclableViewReadiness.ReadyOnAssignment or not bool6 and bool1)

            SignalsExperimental.batch(function()
                if bool5 then
                    list = kind
                    var6(assignment2)
                    if not hasItem(false) then
                        var8(true)
                    end
                end
                if bool6 then
                    func2(num2)
                end
                var4(if tbl2 == nil then nil else tbl2.index)
                var2(assignment2)
                if readiness == RecyclableViewReadiness.ReadyOnCommit and (assignment2 == nil or bool6) then
                    var10(assignment2 ~= nil)
                end
                if tbl2 ~= nil then
                    requestPublication()
                end
            end)
        end,
        pending = pending,
        contentRevision = func1,
        commitContent = function(num3: number): boolean
            if bool3 or readiness ~= RecyclableViewReadiness.ReadyOnCommit or var12 == nil or num3 ~= num2 then
                return false
            end

            bool1 = true
            SignalsExperimental.batch(function()
                var10(false)
                requestPublication()
            end)

            return true
        end,
        setContentMounted = function(bool5: boolean)
            if bool3 or bool2 == bool5 then
                return
            end
            bool2 = bool5
            if bool5 and var12 ~= nil then
                SignalsExperimental.batch(requestPublication)
            end
        end,
        isReadyOnAssignment = function(): boolean
            return not bool3 and bool2 and readiness == RecyclableViewReadiness.ReadyOnAssignment
        end,
        compositionPlacement = function(_)
            return compositionPlacement
        end,
        portalFrame = function(_): Frame?
            return if bool3 then nil else frame
        end,
        bindHost = function(tbl2)
            assert(not bool3, "RecyclableView: cannot bind a destroyed host")
            assert(var11 == nil, "RecyclableView: host is already bound")
            var11 = tbl2
            local bool5 = true
            return function()
                if bool5 and var11 == tbl2 then
                    bool5 = false
                    var11 = nil
                end
            end
        end,
        isHostDestroyed = function(): boolean
            return bool3 or not connection.Connected
        end,
        destroy = function()
            if bool3 then
                return
            end
            bool3 = true
            detachState(var12)
            var12 = nil
            var11 = nil
            var10(false)
            connection:Disconnect()
            frame.Parent = nil
            frame:Destroy()
        end
    }
    return var15
end or FFlagViewRecyclerReact08 and function(id: number, arg1, tbl1, compositionPlacement) -- name: RecyclableView
    local metadata = RecyclableViewRegistry.getMetadata(arg1)
    assert(metadata ~= nil, "RecyclableView: unknown Recyclable view type")
    local readiness = metadata.readiness
    local hideWhilePending = metadata.hideWhilePending
    local signal, var2 = Signals.createSignal(tbl1)
    local indexSignal, var4 = Signals.createSignal(nil)
    local var5, var6 = Signals.createSignal(tbl1)

    local hasItem, var8 = Signals.createSignal(tbl1 ~= nil)
    local pending, var10 = React.createBinding(false)
    local num2 = if tbl1 == nil then 0 else 1
    local func1, func2

    if readiness == RecyclableViewReadiness.ReadyOnCommit then
        local var11
        func1, var11 = Signals.createSignal(num2)
        func2 = var11
    else
        func1 = function(_)
            return num2
        end
        func2 = function(_) end
    end

    local frame = Instance.new("Frame")
    frame.Name = `ListItemViewFrame{id}`
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.Position = UDim2.new()
    frame.Size = UDim2.new()

    local connection = frame.Destroying:Connect(function() end)

    local var11 = nil
    local var12 = nil

    local list = Destination.Kind.List
    local bool1 = true
    local bool2 = false
    local var13 = nil
    local var14 = nil
    local bool3 = false
    local bool4 = false

    local var15 = nil

    local function detachState(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
        if tbl2 ~= nil then
            local destination = tbl2.destination
            Destination.behaviors[destination.kind].detach(var15, frame, destination)
        end
    end

    local function resolvePhase() -- Luacid: Inlined by compiler; 1 call site recovered
        if var12 == nil then
            return HostPresentationPhase.Hidden
        end

        if not bool2 then
            return HostPresentationPhase.Hidden
        end

        if readiness == RecyclableViewReadiness.ReadyOnAssignment or bool1 then
            return HostPresentationPhase.Presented
        end

        if hideWhilePending then
            return HostPresentationPhase.Hidden
        end

        return HostPresentationPhase.Pending
    end

    local function publish(tbl2, arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
        local destination = tbl2.destination
        Destination.behaviors[destination.kind].present(var15, frame, destination, arg3)
        var13 = tbl2
        var14 = arg3
    end

    local function func3()
        bool4 = false
        local var16 = var12
        if var16 == nil or bool3 then
            return
        end

        local var17 = resolvePhase()

        if var13 == var16 and var14 == var17 then
            return
        end

        publish(var16, var17)
    end

    local function requestPublication() -- Luacid: Inlined by compiler; 2 call sites recovered
        if not bool4 then
            bool4 = true
            SignalsScheduler.schedule(func3)
        end
    end

    local function sameDestinationOwner(arg3, arg4) -- Luacid: unused: defined but never referenced
        return arg3.kind == arg4.kind and Destination.behaviors[arg3.kind].sameOwner(arg3, arg4)
    end

    var15 = {
        id = id,
        viewType = arg1,
        itemViewType = arg1,
        signal = signal,
        indexSignal = indexSignal,
        itemSignal = function(arg3)
            local var16 = var5(arg3)
            assert(var16 ~= nil, "RecyclableView: item read before first Assignment")
            return Destination.behaviors[list].readItem(var16.value, arg3)
        end,
        itemKeySignal = function(arg3)
            local var16 = var5(arg3)
            assert(var16 ~= nil, "RecyclableView: item key read before first Assignment")
            return var16.key
        end,
        hasItem = hasItem,
        transition = function(tbl2)
            if bool3 then
                assert(tbl2 == nil, "RecyclableView: cannot transition an occupied state after destroy")
                return
            end
            local var16 = var12
            local assignment = if var16 == nil then nil else var16.assignment
            local assignment2 = if tbl2 == nil then nil else tbl2.assignment
            local destination = if var16 == nil then nil else var16.destination
            local destination2 = if tbl2 == nil then nil else tbl2.destination

            if destination ~= nil
                and (destination2 == nil
                    or destination.kind ~= destination2.kind
                    or not Destination.behaviors[destination.kind].sameOwner(destination, destination2))
            then
                detachState(var16)
                var13 = nil
                var14 = nil
            end
            if assignment ~= nil and assignment ~= assignment2 then
                local var17 = var11
                if var17 ~= nil then
                    var17.clearSelection()
                end
            end
            var12 = tbl2
            if destination2 ~= nil then
                Destination.behaviors[destination2.kind].attach(frame, destination2)
            end

            if tbl2 ~= nil and var13 == nil then
                publish(tbl2, HostPresentationPhase.Hidden)
            end

            local kind = if tbl2 == nil then nil else tbl2.destination.kind
            local bool5 = not (assignment2 == nil) and (assignment ~= assignment2 or list ~= kind)
            local bool6 = readiness == RecyclableViewReadiness.ReadyOnCommit and assignment2 ~= nil and (assignment ~= assignment2 or not bool1)

            if bool6 then
                num2 += 1
            end
            bool1 = not (assignment2 == nil) and (readiness == RecyclableViewReadiness.ReadyOnAssignment or not bool6 and bool1)

            SignalsExperimental.batch(function()
                if bool5 then
                    list = kind
                    var6(assignment2)
                    if not hasItem(false) then
                        var8(true)
                    end
                end
                if bool6 then
                    func2(num2)
                end
                var4(if tbl2 == nil then nil else tbl2.index)
                var2(assignment2)

                if readiness == RecyclableViewReadiness.ReadyOnCommit and (assignment2 == nil or bool6) then
                    var10(assignment2 ~= nil)
                end
                if tbl2 ~= nil then
                    requestPublication()
                end
            end)
        end,
        pending = pending,
        contentRevision = func1,
        commitContent = function(num3: number): boolean
            if bool3 or readiness ~= RecyclableViewReadiness.ReadyOnCommit or var12 == nil or num3 ~= num2 then
                return false
            end

            bool1 = true
            SignalsExperimental.batch(function()
                var10(false)
                requestPublication()
            end)

            return true
        end,
        setContentMounted = function(bool5: boolean)
            if bool3 or bool2 == bool5 then
                return
            end
            bool2 = bool5
            if bool5 and var12 ~= nil then
                SignalsExperimental.batch(requestPublication)
            end
        end,
        compositionPlacement = function(_)
            return compositionPlacement
        end,
        portalFrame = function(_): Frame?
            return if bool3 then nil else frame
        end,
        bindHost = function(tbl2)
            assert(not bool3, "RecyclableView: cannot bind a destroyed host")
            assert(var11 == nil, "RecyclableView: host is already bound")
            var11 = tbl2
            local bool5 = true
            return function()
                if bool5 and var11 == tbl2 then
                    bool5 = false
                    var11 = nil
                end
            end
        end,
        isHostDestroyed = function(): boolean
            return bool3 or not connection.Connected
        end,
        destroy = function()
            if bool3 then
                return
            end
            bool3 = true
            detachState(var12)
            var12 = nil
            var11 = nil
            var10(false)
            connection:Disconnect()
            frame.Parent = nil
            frame:Destroy()
        end
    }
    return var15
end or function(id: number, arg1, tbl1, arg2, hideWhilePending: boolean?) -- name: RecyclableView
    local metadata = RecyclableViewRegistry.getMetadata(arg1)
    assert(metadata ~= nil, "RecyclableView: unknown Recyclable view type")
    local readiness = arg2 or metadata.readiness
    if hideWhilePending == nil then
        hideWhilePending = metadata.hideWhilePending
    end
    local signal, var3 = Signals.createSignal(tbl1)
    local indexSignal, var5 = Signals.createSignal(nil)
    local var6, var7 = Signals.createSignal(tbl1)

    local hasItem, var9 = Signals.createSignal(tbl1 ~= nil)
    local compositionPlacement, var11 = Signals.createSignal(nil)
    local pending, var13 = React.createBinding(false)
    local num2 = if tbl1 == nil then 0 else 1
    local func1, func2

    if readiness == RecyclableViewReadiness.ReadyOnCommit then
        local var14
        func1, var14 = Signals.createSignal(num2)
        func2 = var14
    else
        func1 = function(_)
            return num2
        end
        func2 = function(_) end
    end

    local frame = Instance.new("Frame")
    frame.Name = `ListItemViewFrame{id}`
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.Position = UDim2.new()
    frame.Size = UDim2.new()

    local var14 = nil
    local var15 = nil
    local var16 = nil
    local bool2 = true
    local bool3 = false
    local var17 = nil
    local currentPhase = nil
    local bool4 = false
    local bool5 = false

    local function resetCompositionHost() -- Luacid: Inlined by compiler; 3 call sites recovered
        ReparentableHost.detach(frame)
        frame.AnchorPoint = Vector2.zero
        frame.Position = UDim2.new()
        frame.Size = UDim2.new()
        frame.AutomaticSize = Enum.AutomaticSize.None
    end

    local function detachState(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
        if tbl2 == nil then
            return
        end
        local destination = tbl2.destination
        if destination.kind == PlacementKind.List then
            destination.sink.apply(nil)
            return
        end

        resetCompositionHost()
    end

    local function resolvePhase() -- Luacid: Inlined by compiler; 1 call site recovered
        if var15 == nil then
            return HostPresentationPhase.Hidden
        end

        if not bool3 then
            return HostPresentationPhase.Hidden
        end

        if readiness == RecyclableViewReadiness.ReadyOnAssignment or bool2 then
            return HostPresentationPhase.Presented
        end

        if hideWhilePending then
            return HostPresentationPhase.Hidden
        end

        return HostPresentationPhase.Pending
    end

    local function publish(tbl2, phase)
        local destination = tbl2.destination
        if destination.kind == PlacementKind.List then
            destination.sink.apply({ host = frame, phase = phase, state = destination.state })
        else
            if frame.Parent ~= destination.placeholder or frame.AutomaticSize ~= destination.automaticSize then
                ReparentableHost.place(frame, destination)
            end
            frame.Visible = phase ~= HostPresentationPhase.Hidden
        end
        var17 = tbl2
        currentPhase = phase
    end

    local function func3()
        bool5 = false
        local var18 = var15
        if var18 == nil or bool4 then
            return
        end

        local var19 = resolvePhase()

        if var17 == var18 and currentPhase == var19 then
            return
        end
        publish(var18, var19)
    end

    local function requestPublication() -- Luacid: Inlined by compiler; 2 call sites recovered
        if not bool5 then
            bool5 = true
            SignalsScheduler.schedule(func3)
        end
    end

    return {
        id = id,
        viewType = arg1,
        itemViewType = arg1,
        signal = signal,
        indexSignal = indexSignal,
        itemSignal = function(arg3)
            local var18 = var6(arg3)
            assert(var18 ~= nil, "RecyclableView: item read before first Assignment")
            if var16 == PlacementKind.Composition then
                return (var18.value(arg3))
            end

            return var18.value
        end,
        itemKeySignal = function(arg3)
            local var18 = var6(arg3)
            assert(var18 ~= nil, "RecyclableView: item key read before first Assignment")
            return var18.key
        end,
        hasItem = hasItem,
        transition = function(tbl2)
            if bool4 then
                assert(tbl2 == nil, "RecyclableView: cannot transition an occupied state after destroy")
                return
            end
            local var18 = var15
            local assignment = if var18 == nil then nil else var18.assignment
            local assignment2 = if tbl2 == nil then nil else tbl2.assignment
            local destination = if var18 == nil then nil else var18.destination
            local destination2 = if tbl2 == nil then nil else tbl2.destination

            if destination ~= nil
                and (destination2 == nil
                    or destination.kind ~= destination2.kind
                    or destination.kind == PlacementKind.List and destination.sink ~= destination2.sink
                    or destination.kind == PlacementKind.Composition and destination.placementId ~= destination2.placementId)
            then
                detachState(var18)
                var17 = nil
                currentPhase = nil
            end
            if assignment ~= nil and assignment ~= assignment2 then
                local var19 = var14
                if var19 ~= nil then
                    var19.clearSelection()
                end
            end
            var15 = tbl2

            if tbl2 ~= nil and var17 == nil then
                publish(tbl2, HostPresentationPhase.Hidden)
            end

            local kind = if tbl2 == nil then nil else tbl2.destination.kind
            local bool6 = not (assignment2 == nil) and (assignment ~= assignment2 or var16 ~= kind)
            local bool7 = readiness == RecyclableViewReadiness.ReadyOnCommit and assignment2 ~= nil and (assignment ~= assignment2 or not bool2)

            if bool7 then
                num2 += 1
            end
            bool2 = not (assignment2 == nil) and (readiness == RecyclableViewReadiness.ReadyOnAssignment or not bool7 and bool2)

            SignalsExperimental.batch(function()
                if bool6 then
                    var16 = kind
                    var7(assignment2)
                    if not hasItem(false) then
                        var9(true)
                    end
                end
                if bool7 then
                    func2(num2)
                end
                var5(if tbl2 == nil then nil else tbl2.index)
                var3(assignment2)
                var11(if tbl2 == nil then nil else tbl2.destination.compositionPlacement)

                if readiness == RecyclableViewReadiness.ReadyOnCommit and (assignment2 == nil or bool7) then
                    var13(assignment2 ~= nil)
                end
                if tbl2 ~= nil then
                    requestPublication()
                end
            end)
        end,
        pending = pending,
        contentRevision = func1,
        commitContent = function(num3: number): boolean
            if bool4 or readiness ~= RecyclableViewReadiness.ReadyOnCommit or var15 == nil or num3 ~= num2 then
                return false
            end

            bool2 = true
            SignalsExperimental.batch(function()
                var13(false)
                requestPublication()
            end)

            return true
        end,
        setContentMounted = function(bool6: boolean)
            if bool4 or bool3 == bool6 then
                return
            end
            bool3 = bool6
            if bool6 and var15 ~= nil then
                SignalsExperimental.batch(requestPublication)
            end
        end,
        readiness = readiness,
        hideWhilePending = hideWhilePending,
        compositionPlacement = compositionPlacement,
        portalFrame = function(_): Frame?
            return if bool4 then nil else frame
        end,
        bindHost = function(tbl2)
            assert(not bool4, "RecyclableView: cannot bind a destroyed host")
            assert(var14 == nil, "RecyclableView: host is already bound")
            var14 = tbl2
            local bool6 = true
            return function()
                if bool6 and var14 == tbl2 then
                    bool6 = false
                    var14 = nil
                end
            end
        end,
        clearSelection = function()
            local var18 = var14
            if var18 ~= nil then
                var18.clearSelection()
            end
        end,
        detachFromPlaceholder = function(arg3)
            local var18 = var14
            if var18 ~= nil then
                var18.detachFromPlaceholder(arg3)
            end
        end,
        destroy = function()
            if bool4 then
                return
            end
            bool4 = true
            detachState(var15)
            var15 = nil
            var14 = nil
            var13(false)
            frame.Parent = nil
            frame:Destroy()
        end
    }
end
