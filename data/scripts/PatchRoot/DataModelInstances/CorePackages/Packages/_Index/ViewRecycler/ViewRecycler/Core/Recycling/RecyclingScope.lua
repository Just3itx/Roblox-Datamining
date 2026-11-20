-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact08
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")
local Diagnostics = require(ViewRecycler.Core.Diagnostics)
local acquired = table.freeze({})

local function validCapacity(capacity: number?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return capacity == nil or capacity >= 0 and capacity % 1 == 0
end

local function appendChange<T>(tbl1, arg1: T, viewType: T, arg2: T, arg3: T, num1: T) -- Luacid: Inlined by compiler; 12 call sites recovered
    table.insert(tbl1, { arg1, viewType, arg2, arg3, num1 })
end

local function createRecyclingScope(tbl1)
    local adapter = tbl1.adapter
    local tbl2 = ({})
    local tbl3 = ({})
    local bool1 = false
    local bool2 = false
    local var2 = adapter.batch or function(callback)
        callback()
    end

    local function poolFor(viewType)
        local tbl4 = tbl2[viewType]
        if tbl4 == nil then
            tbl4 = {
                viewType = viewType,
                items = {},
                first = 1,
                last = 0
            }
            tbl2[viewType] = tbl4
        end
        return tbl4
    end

    local function forget(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
        tbl3[arg1] = nil
    end

    local function notify(action, viewType, occupiedDelta, vacantDelta, totalDelta)
        if tbl1.onPoolChanged == nil then
            return
        end

        tbl1.onPoolChanged({
            action = action,
            viewType = viewType,
            occupiedDelta = occupiedDelta,
            vacantDelta = vacantDelta,
            totalDelta = totalDelta
        })
    end

    local function finalize(tbl4, tbl5, tbl6, bool3: boolean?)
        if (tbl4 == nil or #tbl4 == 0) and #tbl5 == 0 and (tbl6 == nil or #tbl6 == 0 or adapter.onCreated == nil) then
            return true, nil
        end
        local var3 = nil
        local function captureFailure(bool4: boolean, arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
            if not bool4 and var3 == nil then
                var3 = arg1
            end
        end
        local tbl7 = table.pack(pcall(var2, function()
            if tbl4 ~= nil then
                for _, value in tbl4 do
                    local success, result = pcall(notify, value[1], value[2], value[3], value[4], value[5])
                    captureFailure(success, result)
                end
            end
            if bool3 ~= false and #tbl5 > 0 and adapter.onEvicted ~= nil then
                local success, result = pcall(adapter.onEvicted, tbl5)
                captureFailure(success, result)
            end
            for _, value in tbl5 do
                local success, result = pcall(adapter.destroy, value)
                captureFailure(success, result)
            end
            if tbl6 ~= nil and #tbl6 > 0 and adapter.onCreated ~= nil then
                local success, result = pcall(adapter.onCreated, tbl6)
                captureFailure(success, result)
            end
            if var3 ~= nil then
                error(var3, 0)
            end
        end))
        return tbl7[1], tbl7[2]
    end

    local function trimPoolExcess(tbl4, capacity: number, tbl5, tbl6)
        while capacity < tbl4.last - tbl4.first + 1 do
            local item = tbl4.items[tbl4.first]
            tbl4.items[tbl4.first] = nil
            tbl4.first += 1
            forget(item)
            table.insert(tbl5, item)
            if tbl6 ~= nil then
                appendChange(tbl6, Diagnostics.PoolAction.Evict, tbl4.viewType, 0, -1, -1)
            end
        end
    end

    local function uniformDirectReuse(releases, requests)
        local releasesLen = #releases
        if releasesLen == 0 or releasesLen ~= #requests then
            return nil
        end
        local viewType = requests[1].viewType
        for i = 2, releasesLen do
            if requests[i].viewType ~= viewType then
                return nil
            end
        end
        for value, value2 in releases do
            local var3 = tbl3[value2]
            if var3 == nil or not var3.active then
                error("RecyclingScope: can only release an active view", 3)
            end
            if var3.viewType ~= viewType then
                return nil
            end
            for i = 1, value - 1 do
                if releases[i] == value2 then
                    error("RecyclingScope: cannot release one view more than once", 3)
                end
            end
        end

        local var1 = table.create(releasesLen)
        for i = 1, releasesLen do
            var1[i] = releases[releasesLen - i + 1]
        end
        return { acquired = var1, releasedCount = 0 }
    end

    local var3 = nil
    var3 = FFlagViewRecyclerReact084 and function(tbl4) -- name: evictDestroyedVacancies
        local isDestroyed = adapter.isDestroyed
        if isDestroyed == nil or #tbl4 == 0 then
            return
        end
        local tbl5 = {}
        local var4 = tbl1.onPoolChanged ~= nil and {} or nil
        local tbl6 = {}
        for _, value in tbl4 do
            local var5 = tbl2[value.viewType]
            if var5 == nil or tbl6[value.viewType] then
                continue
            end

            tbl6[value.viewType] = true
            local first = var5.first
            for i = var5.first, var5.last do
                local item = var5.items[i]
                var5.items[i] = nil
                if isDestroyed(item) then
                    forget(item)
                    table.insert(tbl5, item)
                    if var4 ~= nil then
                        appendChange(var4, Diagnostics.PoolAction.Evict, var5.viewType, 0, -1, -1)
                    end
                else
                    var5.items[first] = item
                    first += 1
                end
            end
            var5.last = first - 1
        end
        if not (#tbl5 > 0) then
            return
        end

        bool2 = true
        local bool3, var5 = finalize(var4, tbl5, nil)
        bool2 = false
        if not bool3 then
            error(var5, 0)
        end
    end or var3

    local tbl4 = ({})
    local tbl5 = ({})

    local function exchangeWithoutCreation(releases, requests, tbl6)
        if #requests == 0 then
            for _, value in releases do
                local var4 = tbl3[value]
                if var4 == nil or not var4.active then
                    table.clear(tbl4)
                    error("RecyclingScope: can only release an active view", 3)
                end
                if tbl4[value] then
                    table.clear(tbl4)
                    error("RecyclingScope: cannot release one view more than once", 3)
                end
                tbl4[value] = true
            end
            table.clear(tbl4)
            for _, value in releases do
                local var4 = tbl3[value]
                var4.active = false
                local pool = var4.pool
                pool.last += 1
                pool.items[pool.last] = value
                if tbl6 ~= nil then
                    appendChange(tbl6, Diagnostics.PoolAction.Release, var4.viewType, -1, 1, 0)
                end
            end
            return {
                acquired = acquired,
                releasedCount = #releases
            }
        end
        if #releases ~= 0 then
            return nil
        end
        local bool3 = true
        for _, request in requests do
            local viewType = request.viewType
            local var4 = tbl5[viewType]
            if var4 == nil then
                local var5 = tbl2[viewType]
                var4 = if var5 == nil then 0 else var5.last - var5.first + 1
            end
            if var4 == 0 then
                bool3 = false
                break
            end

            tbl5[viewType] = var4 - 1
        end
        table.clear(tbl5)
        if not bool3 then
            return nil
        end
        local var1 = table.create(#requests)
        for k, request in requests do
            local var5 = tbl2[request.viewType]
            local item = var5.items[var5.last]
            var5.items[var5.last] = nil
            var5.last -= 1
            tbl3[item].active = true
            var1[k] = item
            if tbl6 ~= nil then
                appendChange(tbl6, Diagnostics.PoolAction.Acquire, request.viewType, 1, -1, 0)
            end
        end
        return { acquired = var1, releasedCount = 0 }
    end

    return {
        bind = function(tbl6)
            assert(not bool1, "RecyclingScope: cannot bind after disposal")
            assert(not bool2, "RecyclingScope: cannot bind reentrantly")
            assert(validCapacity(tbl6.capacity), "RecyclingScope: capacity must be a non-negative integer")
            local releases = tbl6.releases
            local requests = tbl6.requests
            local var4, var5

            if FFlagViewRecyclerReact084 then
                var4 = nil
                if adapter.isDestroyed ~= nil then
                    for _, value in releases do
                        if adapter.isDestroyed(value) then
                            var4 = var4 or {}
                            var4[value] = true
                        end
                    end
                end

                if var4 == nil then
                    var5 = uniformDirectReuse(releases, requests)
                else
                    var5 = nil
                end
            else
                var4 = nil
                if FFlagViewRecyclerReact08 then
                    var4 = nil
                    if adapter.isDestroyed ~= nil then
                        for _, value in releases do
                            if adapter.isDestroyed(value) then
                                var4 = var4 or {}
                                var4[value] = true
                            end
                        end
                    end

                    if var4 == nil then
                        var5 = uniformDirectReuse(releases, requests)
                    else
                        var5 = nil
                    end
                else
                    var5 = uniformDirectReuse(releases, requests)
                end
            end
            if var5 ~= nil then
                local capacity = tbl6.capacity
                if capacity ~= nil then
                    local tbl7 = {}
                    local var6 = tbl1.onPoolChanged ~= nil and {} or nil
                    for _, value in tbl2 do
                        trimPoolExcess(value, capacity, tbl7, var6)
                    end
                    if #tbl7 > 0 then
                        bool2 = true
                        local bool3, var7 = finalize(var6, tbl7, nil)
                        bool2 = false
                        if not bool3 then
                            error(var7, 0)
                        end
                    end
                end
                return var5
            end

            if FFlagViewRecyclerReact084 then
                var3(requests)
            end
            local var6 = tbl1.onPoolChanged ~= nil and {} or nil
            local var7 = if FFlagViewRecyclerReact084 then if var4 == nil then exchangeWithoutCreation(releases, requests, var6) else nil elseif FFlagViewRecyclerReact08 then if var4 == nil then exchangeWithoutCreation(releases, requests, var6) else nil else exchangeWithoutCreation(releases, requests, var6)

            if var7 ~= nil then
                local tbl7 = acquired
                local capacity = tbl6.capacity
                if capacity ~= nil then
                    tbl7 = {}
                    for _, value in tbl2 do
                        trimPoolExcess(value, capacity, tbl7, var6)
                    end
                end
                bool2 = true
                local bool3, var8 = finalize(var6, tbl7, nil)
                bool2 = false
                if not bool3 then
                    error(var8, 0)
                end
                return var7
            end
            bool2 = true
            local tbl7 = {}
            local tbl8 = ({})
            for _, value in releases do
                local var8 = tbl3[value]
                if var8 == nil or not var8.active then
                    bool2 = false
                    error("RecyclingScope: can only release an active view", 2)
                end
                if tbl8[value] then
                    bool2 = false
                    error("RecyclingScope: cannot release one view more than once", 2)
                end
                tbl8[value] = true
                local var9 = if FFlagViewRecyclerReact084 then not (var4 == nil) and var4[value] else FFlagViewRecyclerReact08
                local tbl9

                if var9 and (FFlagViewRecyclerReact084 or var4 ~= nil and var4[value]) then
                    continue
                end

                tbl9 = tbl7[var8.viewType]
                if tbl9 == nil then
                    tbl9 = {}
                    tbl7[var8.viewType] = tbl9
                end
                table.insert(tbl9, value)
            end

            local tbl9 = {}
            local tbl10 = ({})
            local tbl11 = ({})
            local tbl12 = ({})
            local tbl13 = ({})
            local tbl14 = ({})
            local success, result = pcall(function()
                for k, request in requests do
                    local var8 = tbl7[request.viewType]
                    local var9 = if var8 == nil then nil else table.remove(var8)

                    if var9 ~= nil then
                        tbl10[k] = var9
                        tbl12[var9] = true
                    else
                        local var10 = tbl9[request.viewType]
                        if var10 == nil then
                            local var11 = tbl2[request.viewType]
                            var10 = if var11 == nil then 0 else var11.last - var11.first + 1
                        end
                        if var10 > 0 then
                            tbl9[request.viewType] = var10 - 1
                            tbl11[k] = true
                        else
                            tbl9[request.viewType] = 0
                            local var11 = adapter.create(request.viewType)
                            assert(tbl3[var11] == nil and not tbl14[var11], "RecyclingScope: create must return a new view")

                            tbl14[var11] = true
                            tbl13[k] = var11
                        end
                    end
                end
            end)

            if not success then
                finalize(nil, tbl13, nil, false)
                bool2 = false
                error(result, 0)
            end

            local tbl15 = {
                acquired = if #requests == 0 then acquired else table.create(#requests),
                releasedCount = 0
            }

            local var8 = tbl1.onPoolChanged ~= nil and {} or nil
            local tbl16 = {}

            for _, value in releases do
                if FFlagViewRecyclerReact084 then
                    if var4 ~= nil and var4[value] then
                        local var9 = tbl3[value]
                        forget(value)
                        table.insert(tbl16, value)
                        if var8 ~= nil then
                            appendChange(var8, Diagnostics.PoolAction.Evict, var9.viewType, -1, 0, -1)
                        end
                    elseif not tbl12[value] then
                        local var9 = tbl3[value]
                        var9.active = false
                        local pool = var9.pool
                        pool.last += 1
                        pool.items[pool.last] = value
                        tbl15.releasedCount += 1
                        if var8 ~= nil then
                            appendChange(var8, Diagnostics.PoolAction.Release, var9.viewType, -1, 1, 0)
                        end
                    end
                elseif FFlagViewRecyclerReact08 then
                    if var4 ~= nil and var4[value] then
                        local var9 = tbl3[value]
                        forget(value)
                        table.insert(tbl16, value)
                        if var8 ~= nil then
                            appendChange(var8, Diagnostics.PoolAction.Evict, var9.viewType, -1, 0, -1)
                        end
                    elseif not tbl12[value] then
                        local var9 = tbl3[value]
                        var9.active = false
                        local pool = var9.pool
                        pool.last += 1
                        pool.items[pool.last] = value
                        tbl15.releasedCount += 1
                        if var8 ~= nil then
                            appendChange(var8, Diagnostics.PoolAction.Release, var9.viewType, -1, 1, 0)
                        end
                    end
                elseif not tbl12[value] then
                    local var9 = tbl3[value]
                    var9.active = false
                    local pool = var9.pool
                    pool.last += 1
                    pool.items[pool.last] = value
                    tbl15.releasedCount += 1
                    if var8 ~= nil then
                        appendChange(var8, Diagnostics.PoolAction.Release, var9.viewType, -1, 1, 0)
                    end
                end
            end

            for k, request in requests do
                local var9 = tbl10[k]
                if var9 == nil and tbl11[k] then
                    local var10 = tbl2[request.viewType]
                    var9 = var10.items[var10.last]
                    var10.items[var10.last] = nil
                    var10.last -= 1
                    tbl3[var9].active = true
                    if var8 ~= nil then
                        appendChange(var8, Diagnostics.PoolAction.Acquire, request.viewType, 1, -1, 0)
                    end
                elseif var9 == nil then
                    var9 = tbl13[k]
                    local tbl17 = tbl3
                    local tbl18 = {
                        viewType = request.viewType,
                        pool = poolFor(request.viewType),
                        active = true
                    }
                    tbl17[var9] = tbl18

                    if var8 ~= nil then
                        appendChange(var8, Diagnostics.PoolAction.Create, request.viewType, 1, 0, 1)
                    end
                end
                table.insert(tbl15.acquired, var9)
            end

            local capacity = tbl6.capacity
            if capacity ~= nil then
                for _, value in tbl2 do
                    trimPoolExcess(value, capacity, tbl16, var8)
                end
            end

            local tbl17 = {}
            for _, value in tbl13 do
                table.insert(tbl17, value)
            end
            local bool3, var9 = finalize(var8, tbl16, tbl17)
            bool2 = false
            if not bool3 then
                error(var9, 0)
            end
            return tbl15
        end,
        dispose = function()
            if bool1 then
                return
            end
            assert(not bool2, "RecyclingScope: cannot dispose during bind")
            bool1 = true
            local tbl6 = {}
            local var4 = tbl1.onPoolChanged ~= nil and {} or nil

            for value, value2 in tbl3 do
                table.insert(tbl6, value)
                if var4 ~= nil then
                    table.insert(var4, { viewType = value2.viewType, occupied = value2.active })
                end
            end

            table.clear(tbl3)
            table.clear(tbl2)
            local var5 = if var4 == nil then nil else table.create(#tbl6)

            if var5 ~= nil then
                for _, value in var4 do
                    appendChange(
                        var5,
                        Diagnostics.PoolAction.Evict,
                        value.viewType,
                        if value.occupied then -1 else 0,
                        if value.occupied then 0 else -1,
                        -1
                    )
                end
            end

            local bool3, var6 = finalize(var5, tbl6, nil)
            if not bool3 then
                error(var6, 0)
            end
        end
    }
end

return createRecyclingScope
