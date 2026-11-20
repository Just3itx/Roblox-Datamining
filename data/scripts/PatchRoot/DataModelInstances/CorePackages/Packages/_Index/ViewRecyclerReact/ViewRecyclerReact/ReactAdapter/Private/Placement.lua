-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)
local Destination = require(script.Parent.Destination)
local _RecyclableView = require(script.Parent.RecyclableView)
local _RecyclableViewRegistry = require(script.Parent.RecyclableViewRegistry)
local SignalsExperimental = require(ViewRecyclerReact.Parent.SignalsExperimental)

local module = {}

function module.new(recyclingScope, tbl1)
    local name = tbl1.name
    local namespace = tbl1.namespace
    local slotBinder = ViewRecycler.Adapter.createSlotBinder({
        recyclingScope = recyclingScope,
        name = name,
        prepareDesiredAssignment = function(arg1)
            return {
                key = arg1.assignmentKey or namespace .. ":" .. arg1.key,
                value = arg1.value
            }
        end
    })
    local tbl2 = ({})
    local bool1 = false
    local bool2 = false
    local bool3 = false

    local function publish(departed, tbl3)
        for _, value in departed do
            value.transition(nil)
        end
        for _, value in tbl3 do
            local key = value.key
            local var1 = slotBinder.get(key)
            local view = var1.view
            local tbl4 = tbl2[key]
            if tbl4 == nil or tbl4.view ~= view or tbl4.assignment ~= var1.assignment or tbl4.destination ~= value.destination then
                tbl4 = {
                    view = view,
                    assignment = var1.assignment,
                    destination = value.destination
                }
                tbl2[key] = tbl4
                view.transition(table.freeze({ assignment = var1.assignment, index = nil, destination = value.destination }))
            end

            local geometry = value.geometry
            local var2 = view.portalFrame(false)
            if geometry == nil or var2 == nil then
                continue
            end

            assert(value.destination.kind == Destination.Kind.Rect, "Placement: geometry requires a Rect Destination")

            local position = geometry.position
            local size = geometry.size
            if tbl4.position ~= position then
                tbl4.position = position
                var2.Position = UDim2.fromOffset(position.X, position.Y)
            end
            if tbl4.size ~= size then
                tbl4.size = size
                var2.Size = UDim2.fromOffset(size.X, size.Y)
            end
            if tbl4.zIndex ~= geometry.zIndex then
                tbl4.zIndex = geometry.zIndex
                var2.ZIndex = geometry.zIndex
            end
        end
    end

    local function apply(tbl3, tbl4)
        local var1 = table.create(#tbl4)
        for value, value2 in tbl4 do
            local key = value2.key
            local assignmentKey = value2.assignmentKey
            local bool4 = value2.changed == true
            if assignmentKey ~= nil then
                local var2 = tbl2[key]
                if not bool4 then
                    if var2 == nil then
                        bool4 = false
                    else
                        bool4 = var2.assignment.key ~= assignmentKey
                    end
                end
            end

            local tbl5 = {
                key = key,
                value = value2.value,
                viewType = value2.viewType,
                changed = bool4,
                assignmentKey = assignmentKey
            }
            var1[value] = tbl5
        end

        local var2

        if tbl3 == nil then
            var2 = slotBinder.sync(var1)
            for value in tbl2 do
                if slotBinder.get(value) == nil then
                    tbl2[value] = nil
                end
            end
        else
            var2 = slotBinder.apply(tbl3, var1)
            for _, value in tbl3 do
                if slotBinder.get(value) == nil then
                    tbl2[value] = nil
                end
            end
        end
        bool2 = true

        if #var2.departed + #tbl4 > 1 or tbl4[1] ~= nil and tbl4[1].geometry ~= nil then
            SignalsExperimental.batch(function()
                publish(var2.departed, tbl4)
            end)
        else
            publish(var2.departed, tbl4)
        end
        bool2 = false
    end

    local function exchange(tbl3, tbl4)
        if bool3 then
            error(`{name}: cannot place views after destruction`)
        elseif bool1 then
            error(`{name}: cannot place views reentrantly`)
        elseif bool2 then
            error(`{name}: cannot place views after a publication failure`)
        end
        bool1 = true
        local success, result = pcall(apply, tbl3, tbl4)
        bool1 = false
        if not success then
            error(result, 0)
        end
    end

    local function releaseAll()
        assert(not bool1, `{name}: cannot release views during placement`)
        table.clear(tbl2)
        local var1 = slotBinder.releaseAll()
        SignalsExperimental.batch(function()
            for _, value in var1 do
                value.transition(nil)
            end
        end)
    end

    return {
        exchange = exchange,
        sync = function(arg1)
            exchange(nil, arg1)
        end,
        releaseAll = function()
            if not bool3 then
                releaseAll()
            end
        end,
        hasDestroyedView = function()
            for _, value in tbl2 do
                if value.view.isHostDestroyed() then
                    return true
                end
            end
            return false
        end,
        destroy = function()
            if bool3 then
                return
            end
            releaseAll()
            slotBinder.destroy()
            bool3 = true
        end
    }
end

return module
