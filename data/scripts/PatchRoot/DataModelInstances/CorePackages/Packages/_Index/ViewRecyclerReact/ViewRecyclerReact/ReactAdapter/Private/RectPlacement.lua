-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local _ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)
local Destination = require(script.Parent.Destination)
local Placement = require(script.Parent.Placement)
local _RecyclableView = require(script.Parent.RecyclableView)
local _RecyclableViewRegistry = require(script.Parent.RecyclableViewRegistry)

local VacantHosts = if FFlagViewRecyclerReact084 then require(ViewRecyclerReact.Parent.ViewRecyclerRoblox).Internal.VacantHosts else nil

local module = {}

local num1 = 1

function module.new(arg1, func1: (...any) -> (...any))
    local num2 = num1
    num1 += 1
    local placement = Placement.new(arg1, { name = "RectPlacement", namespace = `rect:{num2}` })

    local rectPlacement = {}
    local var1 = nil

    local var2 = nil
    local evacuate = nil
    if FFlagViewRecyclerReact084 then
        var2 = VacantHosts.forScope(arg1)

        evacuate = function()
            local var3 = var1
            if var3 ~= nil then
                var2.evacuate(function(container): boolean
                    return container == var3.container
                end)
            end
        end
    end

    return {
        sync = function(arg2)
            local current = func1().current
            assert(current ~= nil, "RectPlacement: cannot sync without a container")
            if var1 == nil or var1.container ~= current then
                if var1 ~= nil and placement.hasDestroyedView() then
                    placement.releaseAll()
                end

                if FFlagViewRecyclerReact084 then
                    evacuate()
                end
                var1 = table.freeze({
                    kind = Destination.Kind.Rect,
                    rectPlacement = rectPlacement,
                    container = current,
                    vacantHosts = if FFlagViewRecyclerReact084 then var2 else nil
                })
            end
            local var3 = table.create(#arg2)
            for value, value2 in arg2 do
                assert(typeof(value2.position) == "Vector2", "RectPlacement: slot position must be a Vector2")
                assert(typeof(value2.size) == "Vector2", "RectPlacement: slot size must be a Vector2")
                local tbl2 = {
                    key = value2.key,
                    viewType = value2.viewType,
                    value = value2.item,
                    destination = var1,
                    geometry = {
                        position = value2.position,
                        size = value2.size,
                        zIndex = value2.zIndex or 1
                    }
                }
                var3[value] = tbl2
            end

            placement.sync(var3)
        end,
        releaseAll = FFlagViewRecyclerReact084 and function()
            placement.releaseAll()
            evacuate()
        end or placement.releaseAll
    }
end

return module
