-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact08
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)
local Destination = require(script.Parent.Destination)
local Placement = require(script.Parent.Placement)

local PlacementKind = require(script.Parent.PlacementKind)
local _React = require(ViewRecyclerReact.Parent.React)
local _RecyclableView = require(script.Parent.RecyclableView)
local _RecyclableViewRegistry = require(script.Parent.RecyclableViewRegistry)
local Signals = require(ViewRecyclerReact.Parent.Signals)

local VacantHosts = if FFlagViewRecyclerReact084 then require(ViewRecyclerReact.Parent.ViewRecyclerRoblox).Internal.VacantHosts else nil

local module = {}

local function compositeKey(key: string, num1: number): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return `{#key}:{key}:{num1}`
end

function module.new(recyclingScope)
    local var1 = nil
    local slotBinder = nil
    local placement

    if FFlagViewRecyclerReact084 then
        placement = Placement.new(recyclingScope, { name = "CompositionPlacement", namespace = "composition" })

        var1 = VacantHosts.forScope(recyclingScope)
    else
        placement = nil
        slotBinder = nil
        if FFlagViewRecyclerReact08 then
            placement = Placement.new(recyclingScope, { name = "CompositionPlacement", namespace = "composition" })
        else
            slotBinder = ViewRecycler.Adapter.createSlotBinder({
                recyclingScope = recyclingScope,
                prepareDesiredAssignment = function(arg1)
                    local value = arg1.value
                    local tbl1 = { key = 0, value = 0 }
                    local key = value.parentAssignment.key
                    local key2 = arg1.key
                    tbl1.key = compositeKey(key, tonumber(key2))
                    tbl1.value = value.itemSignal
                    return tbl1
                end
            })
        end
    end

    local tbl1 = ({})

    local var2 = nil
    local var3, var4

    if FFlagViewRecyclerReact084 then
        var3 = {}

        var4 = {}
    else
        var3 = nil
        var4 = nil
        var2 = nil
        if FFlagViewRecyclerReact08 then
            var3 = {}

            var4 = {}
        else
            var2 = {}
        end
    end
    local var5 = (setmetatable({}, { __mode = "k" }))
    local num1 = 1
    local tbl2 = ({})
    local bool1 = false
    local num2 = 0

    local bool2 = nil
    if not FFlagViewRecyclerReact084 then
        bool2 = nil
        if not FFlagViewRecyclerReact08 then
            bool2 = false
        end
    end
    local bool3 = false

    local var6 = nil

    local desiredFor = nil
    local makeState = nil
    local slotFor

    if FFlagViewRecyclerReact084 then
        slotFor = function(placementId: number)
            local var7 = tbl1[placementId]
            if var7 == nil then
                return nil
            end
            local var8 = var7.parentSignal(false)
            local viewType = var7.viewType(false)
            local placeholder = var7.placeholder
            if viewType == nil or var8 == nil or placeholder == nil then
                return nil
            end
            local var10 = var3[placementId]
            if var10 == nil or var10.placeholder ~= placeholder then
                var10 = table.freeze({
                    kind = Destination.Kind.Composition,
                    placementId = placementId,
                    placeholder = placeholder,
                    automaticSize = Enum.AutomaticSize.XY,
                    vacantHosts = var1
                })
                var3[placementId] = var10
            end
            local var11 = var4[placementId]
            return {
                key = tostring(placementId),
                viewType = viewType,
                value = var7.itemSignal,
                assignmentKey = compositeKey(var8.key, placementId),
                changed = not (var11 == nil) and var11 ~= var8,
                destination = var10
            }, var8
        end
    else
        slotFor = nil
        desiredFor = nil
        makeState = nil
        if FFlagViewRecyclerReact08 then
            slotFor = function(placementId: number)
                local var7 = tbl1[placementId]
                if var7 == nil then
                    return nil
                end
                local var8 = var7.parentSignal(false)
                local viewType = var7.viewType(false)
                local placeholder = var7.placeholder
                if viewType == nil or var8 == nil or placeholder == nil then
                    return nil
                end
                local var10 = var3[placementId]
                if var10 == nil or var10.placeholder ~= placeholder then
                    var10 = table.freeze({
                        kind = Destination.Kind.Composition,
                        placementId = placementId,
                        placeholder = placeholder,
                        automaticSize = Enum.AutomaticSize.XY
                    })
                    var3[placementId] = var10
                end
                local var11 = var4[placementId]
                return {
                    key = tostring(placementId),
                    viewType = viewType,
                    value = var7.itemSignal,
                    assignmentKey = compositeKey(var8.key, placementId),
                    changed = not (var11 == nil) and var11 ~= var8,
                    destination = var10
                }, var8
            end
        else
            desiredFor = function(placementId: number)
                local var7 = tbl1[placementId]
                if var7 == nil then
                    return nil
                end
                local parentAssignment = var7.parentSignal(false)
                local active = var7.active
                if active == nil then
                    active = true
                elseif type(active) == "function" then
                    active = active(false)
                end

                return if active and parentAssignment ~= nil and var7.placeholder ~= nil then {
                    placementId = placementId,
                    placement = var7,
                    parentAssignment = parentAssignment,
                    placeholder = var7.placeholder
                } else nil
            end

            makeState = function(tbl3, assignment)
                local destination = table.freeze({
                    kind = PlacementKind.Composition,
                    placementId = tbl3.placementId,
                    placeholder = tbl3.placeholder,
                    automaticSize = Enum.AutomaticSize.XY,
                    compositionPlacement = var6
                })
                return table.freeze({ assignment = assignment, index = nil, destination = destination })
            end
        end
    end

    local function reconcileDirty()
        local tbl3 = {}
        for value in tbl2 do
            table.insert(tbl3, value)
        end
        table.sort(tbl3)

        local var7 = not (FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08) and {} or nil

        local tbl4 = {}
        local tbl5 = {}

        local var8 = FFlagViewRecyclerReact084 and {} or FFlagViewRecyclerReact08 and {} or nil

        for _, placementId in tbl3 do
            local var9, var10

            if FFlagViewRecyclerReact084 then
                var9, var10 = slotFor(placementId)
            else
                var9 = nil
                var10 = nil
            end

            if if FFlagViewRecyclerReact084 then var9 ~= nil else FFlagViewRecyclerReact08 then
                if FFlagViewRecyclerReact084 then
                    table.insert(tbl5, var9)
                    var8[placementId] = var10
                else
                    local var11, var12 = slotFor(placementId)
                    if var11 ~= nil then
                        table.insert(tbl5, var11)
                        var8[placementId] = var12
                    else
                        var3[placementId] = nil
                        table.insert(tbl4, tostring(placementId))
                    end
                end
            elseif FFlagViewRecyclerReact084 then
                var3[placementId] = nil
                table.insert(tbl4, tostring(placementId))
            else
                local var11 = desiredFor(placementId)
                local var12 = var2[placementId]
                if var11 ~= nil then
                    var7[placementId] = var11
                    local source

                    if var12 ~= nil
                        and var12.source.parentAssignment == var11.parentAssignment
                        and var12.source.itemSignal == var11.placement.itemSignal
                    then
                        source = var12.source
                    else
                        source = table.freeze({ parentAssignment = var11.parentAssignment, itemSignal = var11.placement.itemSignal })
                    end
                    table.insert(
                        tbl5,
                        {
                            key = tostring(placementId),
                            value = source,
                            viewType = var11.placement.viewType,
                            placementId = placementId
                        }
                    )
                elseif var12 ~= nil then
                    table.insert(tbl4, tostring(placementId))
                end
            end
        end

        table.clear(tbl2)

        local success = nil
        local result = nil
        local success2, result2

        if FFlagViewRecyclerReact084 then
            success2, result2 = pcall(placement.exchange, tbl4, tbl5)
        else
            success2 = nil
            result2 = nil
            success = nil
            result = nil
            if FFlagViewRecyclerReact08 then
                success2, result2 = pcall(placement.exchange, tbl4, tbl5)
            else
                success, result = pcall(slotBinder.apply, tbl4, tbl5)
            end
        end
        if not (FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08) then
            success2 = success
        end

        if not success2 then
            for _, value in tbl3 do
                tbl2[value] = true
            end
            local error = error
            if not (FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08) then
                result2 = result
            end

            error(result2, 0)
        end

        for _, value in tbl3 do
            if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                var4[value] = var8[value]
            elseif var7[value] == nil then
                var2[value] = nil
            end
        end

        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            return
        end

        local tbl6 = {}
        for _, value in result.entered do
            local var9 = var2
            local placementId = value.placementId
            var9[placementId] = {
                view = value.view,
                source = value.value,
                state = nil
            }

            tbl6[value.view] = true
        end
        for _, value in result.updated do
            var2[value.placementId].source = value.value
        end

        bool2 = true
        for _, value in result.departed do
            value.transition(nil)
        end
        for _, value in tbl3 do
            local var9 = var7[value]
            local var10 = var2[value]
            if var9 == nil or var10 == nil then
                continue
            end

            local assignment = slotBinder.get(tostring(value)).assignment
            local state = var10.state

            if tbl6[var10.view] or state == nil or state.assignment ~= assignment or state.destination.placeholder ~= var9.placeholder then
                local state2 = makeState(var9, assignment)
                var10.state = state2
                var10.view.transition(state2)
            end
        end

        bool2 = false
    end

    local function func1()
        if bool3 or bool1 then
            return
        end

        if not (FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08) then
            assert(not bool2, "CompositionPlacement: cannot flush after a publication failure")
        end

        bool1 = true
        local success, result = pcall(function()
            while next(tbl2) ~= nil do
                reconcileDirty()
            end
        end)
        bool1 = false
        if not success then
            error(result, 0)
        end
    end

    local function func2()
        if not bool3 and next(tbl2) ~= nil and num2 == 0 and not bool1 then
            func1()
        end
    end

    local function markDirty(num3: number) -- Luacid: Inlined by compiler; 19 call sites recovered
        if not bool3 then
            tbl2[num3] = true
            func2()
        end
    end

    local var7

    if FFlagViewRecyclerReact084 then
        var7 = function(num3: number, arg1) -- name: markDirtyOnChange
            local var8 = nil
            local bool4 = false
            return Signals.createEffect(function(arg2)
                local var9 = arg1(arg2)
                if not bool4 or var8 ~= var9 then
                    bool4 = true
                    var8 = var9
                    markDirty(num3)
                end
            end)
        end
    else
        var7 = nil
        var7 = FFlagViewRecyclerReact08 and function(num3: number, arg1) -- name: markDirtyOnChange
            local var8 = nil
            local bool4 = false
            return Signals.createEffect(function(arg2)
                local var9 = arg1(arg2)
                if not bool4 or var8 ~= var9 then
                    bool4 = true
                    var8 = var9
                    markDirty(num3)
                end
            end)
        end or var7
    end

    local function func3(callback)
        num2 += 1
        local tbl3 = table.pack(pcall(callback))
        num2 -= 1
        if not tbl3[1] then
            error(tbl3[2], 0)
        end
        func2()
        return table.unpack(tbl3, 2, tbl3.n)
    end

    var6 = {
        register = FFlagViewRecyclerReact084 and function(viewType, arg1, parentSignal, itemSignal, placeholder)
            return func3(function()
                assert(not bool3, "CompositionPlacement: cannot register after destroy")
                local var8 = var5[arg1]
                if var8 == nil then
                    var8 = num1
                    num1 += 1
                    var5[arg1] = var8
                end
                assert(tbl1[var8] == nil, "CompositionPlacement: placement is already registered")
                local tbl3 = {
                    viewType = viewType,
                    parentSignal = parentSignal,
                    itemSignal = itemSignal,
                    placeholder = placeholder,
                    disposeViewTypeEffect = nil,
                    disposeParentAssignmentEffect = nil
                }

                tbl1[var8] = tbl3
                tbl3.disposeViewTypeEffect = var7(var8, viewType)
                tbl3.disposeParentAssignmentEffect = var7(var8, parentSignal)
                markDirty(var8)

                local bool4 = true
                return {
                    setViewType = function(viewType2)
                        func3(function()
                            if not bool4 or bool3 or tbl3.viewType == viewType2 then
                                return
                            end
                            if tbl3.disposeViewTypeEffect ~= nil then
                                tbl3.disposeViewTypeEffect()
                            end
                            tbl3.viewType = viewType2
                            tbl3.disposeViewTypeEffect = var7(var8, viewType2)
                        end)
                    end,
                    setPlaceholder = function(placeholder2)
                        func3(function()
                            if bool4 and not bool3 and tbl3.placeholder ~= placeholder2 then
                                tbl3.placeholder = placeholder2
                                markDirty(var8)
                            end
                        end)
                    end,
                    setItemSignal = function(itemSignal2)
                        func3(function()
                            if bool4 and not bool3 and tbl3.itemSignal ~= itemSignal2 then
                                tbl3.itemSignal = itemSignal2
                                markDirty(var8)
                            end
                        end)
                    end,
                    unregister = function()
                        func3(function()
                            if not bool4 then
                                return
                            end
                            bool4 = false
                            if bool3 then
                                return
                            end
                            if tbl3.disposeViewTypeEffect ~= nil then
                                tbl3.disposeViewTypeEffect()
                            end
                            if tbl3.disposeParentAssignmentEffect ~= nil then
                                tbl3.disposeParentAssignmentEffect()
                            end
                            tbl1[var8] = nil
                            markDirty(var8)
                        end)
                    end
                }
            end)
        end or FFlagViewRecyclerReact08 and function(viewType, arg1, parentSignal, itemSignal, placeholder)
            return func3(function()
                assert(not bool3, "CompositionPlacement: cannot register after destroy")
                local var8 = var5[arg1]
                if var8 == nil then
                    var8 = num1
                    num1 += 1
                    var5[arg1] = var8
                end
                assert(tbl1[var8] == nil, "CompositionPlacement: placement is already registered")

                local tbl3 = {
                    viewType = viewType,
                    parentSignal = parentSignal,
                    itemSignal = itemSignal,
                    placeholder = placeholder,
                    disposeViewTypeEffect = nil,
                    disposeParentAssignmentEffect = nil
                }

                tbl1[var8] = tbl3
                tbl3.disposeViewTypeEffect = var7(var8, viewType)
                tbl3.disposeParentAssignmentEffect = var7(var8, parentSignal)
                markDirty(var8)

                local bool4 = true
                return {
                    setViewType = function(viewType2)
                        func3(function()
                            if not bool4 or bool3 or tbl3.viewType == viewType2 then
                                return
                            end
                            if tbl3.disposeViewTypeEffect ~= nil then
                                tbl3.disposeViewTypeEffect()
                            end
                            tbl3.viewType = viewType2
                            tbl3.disposeViewTypeEffect = var7(var8, viewType2)
                        end)
                    end,
                    setPlaceholder = function(placeholder2)
                        func3(function()
                            if bool4 and not bool3 and tbl3.placeholder ~= placeholder2 then
                                tbl3.placeholder = placeholder2
                                markDirty(var8)
                            end
                        end)
                    end,
                    setItemSignal = function(itemSignal2)
                        func3(function()
                            if bool4 and not bool3 and tbl3.itemSignal ~= itemSignal2 then
                                tbl3.itemSignal = itemSignal2
                                markDirty(var8)
                            end
                        end)
                    end,
                    unregister = function()
                        func3(function()
                            if not bool4 then
                                return
                            end
                            bool4 = false
                            if bool3 then
                                return
                            end
                            if tbl3.disposeViewTypeEffect ~= nil then
                                tbl3.disposeViewTypeEffect()
                            end
                            if tbl3.disposeParentAssignmentEffect ~= nil then
                                tbl3.disposeParentAssignmentEffect()
                            end
                            tbl1[var8] = nil
                            markDirty(var8)
                        end)
                    end
                }
            end)
        end or function(viewType, arg1, parentSignal, itemSignal, placeholder, active)
            return func3(function()
                assert(not bool3, "CompositionPlacement: cannot register after destroy")
                local var8 = var5[arg1]
                if var8 == nil then
                    var8 = num1
                    num1 += 1
                    var5[arg1] = var8
                end
                assert(tbl1[var8] == nil, "CompositionPlacement: placement is already registered")

                local tbl3 = {
                    viewType = viewType,
                    parentSignal = parentSignal,
                    itemSignal = itemSignal,
                    placeholder = placeholder,
                    active = active,
                    disposeActiveEffect = nil,
                    disposeParentAssignmentEffect = nil
                }

                tbl1[var8] = tbl3
                local function subscribeActive() -- Luacid: Inlined by compiler; 2 call sites recovered
                    if type(tbl3.active) == "function" then
                        tbl3.disposeActiveEffect = Signals.createEffect(function(arg2)
                            tbl3.active(arg2)
                            markDirty(var8)
                        end)
                    end
                end

                subscribeActive()
                local var9 = nil
                local bool4 = false
                tbl3.disposeParentAssignmentEffect = Signals.createEffect(function(arg2)
                    local var10 = parentSignal(arg2)
                    if not bool4 or var9 ~= var10 then
                        bool4 = true
                        var9 = var10
                        markDirty(var8)
                    end
                end)
                markDirty(var8)

                local bool5 = true
                return {
                    setActive = function(active2)
                        func3(function()
                            if not bool5 or bool3 or tbl3.active == active2 then
                                return
                            end
                            if tbl3.disposeActiveEffect ~= nil then
                                tbl3.disposeActiveEffect()
                                tbl3.disposeActiveEffect = nil
                            end
                            tbl3.active = active2
                            subscribeActive()
                            markDirty(var8)
                        end)
                    end,
                    setPlaceholder = function(placeholder2)
                        func3(function()
                            if bool5 and not bool3 and tbl3.placeholder ~= placeholder2 then
                                tbl3.placeholder = placeholder2
                                markDirty(var8)
                            end
                        end)
                    end,
                    setItemSignal = function(itemSignal2)
                        func3(function()
                            if bool5 and not bool3 and tbl3.itemSignal ~= itemSignal2 then
                                tbl3.itemSignal = itemSignal2
                                markDirty(var8)
                            end
                        end)
                    end,
                    unregister = function()
                        func3(function()
                            if not bool5 then
                                return
                            end
                            bool5 = false
                            if bool3 then
                                return
                            end
                            if tbl3.disposeActiveEffect ~= nil then
                                tbl3.disposeActiveEffect()
                            end
                            if tbl3.disposeParentAssignmentEffect ~= nil then
                                tbl3.disposeParentAssignmentEffect()
                            end
                            tbl1[var8] = nil
                            markDirty(var8)
                        end)
                    end
                }
            end)
        end,
        destroy = function()
            if bool3 then
                return
            end
            bool3 = true
            table.clear(tbl2)

            if FFlagViewRecyclerReact084 then
                for _, value in tbl1 do
                    if value.disposeViewTypeEffect ~= nil then
                        value.disposeViewTypeEffect()
                    end
                    if value.disposeParentAssignmentEffect ~= nil then
                        value.disposeParentAssignmentEffect()
                    end
                end
                placement.destroy()
            elseif FFlagViewRecyclerReact08 then
                for _, value in tbl1 do
                    if value.disposeViewTypeEffect ~= nil then
                        value.disposeViewTypeEffect()
                    end
                    if value.disposeParentAssignmentEffect ~= nil then
                        value.disposeParentAssignmentEffect()
                    end
                end
                placement.destroy()
            else
                for _, value in tbl1 do
                    if value.disposeActiveEffect ~= nil then
                        value.disposeActiveEffect()
                    end
                    if value.disposeParentAssignmentEffect ~= nil then
                        value.disposeParentAssignmentEffect()
                    end
                end
                for _, value in var2 do
                    value.view.transition(nil)
                end
                slotBinder.destroy()
            end

            table.clear(tbl1)
            table.clear(if FFlagViewRecyclerReact084 then var3 elseif FFlagViewRecyclerReact08 then var3 else var2)

            if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                table.clear(var4)
            end
        end,
        flush = if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then nil else func1
    }
    return var6
end

return module
