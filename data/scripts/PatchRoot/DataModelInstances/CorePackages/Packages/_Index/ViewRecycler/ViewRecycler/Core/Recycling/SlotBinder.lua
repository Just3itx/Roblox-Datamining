-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact08
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local _RecyclingScope = require(ViewRecycler.Core.Recycling.RecyclingScope)

local var1 = table.freeze({})

local var2 = table.freeze({ entered = var1, updated = var1, departed = var1 })

local function createSlotBinder(tbl1)
    local recyclingScope = tbl1.recyclingScope
    local prepareDesiredAssignment = tbl1.prepareDesiredAssignment
    local name

    if FFlagViewRecyclerReact084 then
        name = tbl1.name or "SlotBinder"
    else
        name = nil
        if FFlagViewRecyclerReact08 then
            name = tbl1.name or "SlotBinder"
        end
    end
    local tbl2 = ({})
    local tbl3 = ({})
    local bool1 = false

    local tbl4 = ({})
    local tbl5 = ({})
    local tbl6 = ({})

    local makeAssignment = FFlagViewRecyclerReact084 and function(tbl7) -- name: makeAssignment
        if prepareDesiredAssignment == nil then
            return table.freeze({ key = tbl7.key, value = tbl7.value })
        end

        local var3 = prepareDesiredAssignment(tbl7)
        return table.freeze({ key = var3.key, value = var3.value })
    end or FFlagViewRecyclerReact08 and function(tbl7) -- name: makeAssignment
        if prepareDesiredAssignment == nil then
            return table.freeze({ key = tbl7.key, value = tbl7.value })
        end

        local var3 = prepareDesiredAssignment(tbl7)
        return table.freeze({ key = var3.key, value = var3.value })
    end or function(key: string, value) -- name: makeAssignment
        if prepareDesiredAssignment == nil then
            return table.freeze({ key = key, value = value })
        end

        local var3 = prepareDesiredAssignment({ key = key, value = value })
        return table.freeze({ key = var3.key, value = var3.value })
    end

    local function requestFor(viewType) -- Luacid: Inlined by compiler; 1 call site recovered
        local var3 = tbl3[viewType]
        if var3 == nil then
            var3 = table.freeze({ viewType = viewType })
            tbl3[viewType] = var3
        end
        return var3
    end

    local function apply(tbl7, tbl8)
        assert(not bool1, "SlotBinder: cannot apply after destruction")
        local releases = {}
        local bool2 = false
        for _, value in tbl7 do
            local var3 = tbl2[value]
            if var3 ~= nil then
                table.insert(releases, var3.view)
                tbl4[value] = true
                bool2 = true
            end
        end

        local requests = {}
        local tbl11 = {}
        local var3 = nil
        local bool3 = #tbl8 > 1
        for _, value in tbl8 do
            local key = value.key
            if bool3 then
                if tbl5[key] then
                    table.clear(tbl5)
                    table.clear(tbl4)
                    error(
                        if FFlagViewRecyclerReact084 then `{name}: duplicate key "{key}"` elseif FFlagViewRecyclerReact08 then `{name}: duplicate key "{key}"` else `Virtualizer: duplicate key "{key}"`,
                        0
                    )
                end
                tbl5[key] = true
            end
            local var4 = tbl2[key]
            local bool4 = not (var4 == nil) and not (bool2 and tbl4[key])

            if bool4 and var4.viewType == value.viewType then
                if value.changed or var4.value ~= value.value then
                    var3 = var3 or {}
                    table.insert(var3, value)
                end
            else
                if bool4 then
                    table.insert(releases, var4.view)
                end
                table.insert(tbl11, value)
                table.insert(requests, (requestFor(value.viewType)))
            end
        end
        if bool3 then
            table.clear(tbl5)
        end

        if #releases == 0 and #requests == 0 and var3 == nil then
            return var2
        end

        local var4 = var1
        if #releases > 0 or #requests > 0 then
            local success, result = pcall(recyclingScope.bind, { releases = releases, requests = requests })
            if not success then
                table.clear(tbl4)
                error(result, 0)
            end
            var4 = result.acquired
        end

        if bool2 then
            for value in tbl4 do
                tbl2[value] = nil
            end
            table.clear(tbl4)
        end

        local bool4 = #releases > 0 and #tbl11 > 0

        for value, value2 in tbl11 do
            local view = var4[value]

            value2.view = view

            if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                value2.assignment = makeAssignment(value2)
            else
                value2.assignment = makeAssignment(value2.key, value2.value)
            end

            tbl2[value2.key] = value2
            if bool4 then
                tbl6[view] = true
            end
        end

        local var5 = var1
        if var3 ~= nil then
            var5 = table.create(#var3)
            for value, value2 in var3 do
                local var6 = tbl2[value2.key]
                var6.value = value2.value

                if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                    var6.assignment = makeAssignment(value2)
                else
                    var6.assignment = makeAssignment(value2.key, value2.value)
                end

                var5[value] = var6
            end
        end

        local tbl12 = var1
        if #releases > 0 then
            if bool4 then
                tbl12 = {}
                for _, value in releases do
                    if not tbl6[value] then
                        table.insert(tbl12, value)
                    end
                end
                table.clear(tbl6)
            else
                tbl12 = releases
            end
        end

        local tbl13 = { entered = 0, updated = 0, departed = 0 }
        if #tbl11 == 0 then
            tbl11 = var1
        end

        tbl13.entered = tbl11
        tbl13.updated = var5
        tbl13.departed = tbl12
        return tbl13
    end

    local function releaseAll()
        local result = {}
        for _, value in tbl2 do
            table.insert(result, value.view)
        end
        table.clear(tbl2)
        if #result > 0 then
            recyclingScope.bind({ releases = result, requests = {} })
        end
        return result
    end

    return {
        apply = apply,
        sync = function(arg1)
            local tbl7 = {}
            for _, value in arg1 do
                tbl7[value.key] = true
            end
            local tbl8 = {}
            for value in tbl2 do
                if not tbl7[value] then
                    table.insert(tbl8, value)
                end
            end
            return (apply(tbl8, arg1))
        end,
        get = function(arg1)
            return tbl2[arg1]
        end,
        releaseAll = function()
            assert(not bool1, "SlotBinder: cannot release after destruction")
            return (releaseAll())
        end,
        destroy = function()
            if bool1 then
                return
            end
            releaseAll()
            bool1 = true
        end
    }
end

return createSlotBinder
