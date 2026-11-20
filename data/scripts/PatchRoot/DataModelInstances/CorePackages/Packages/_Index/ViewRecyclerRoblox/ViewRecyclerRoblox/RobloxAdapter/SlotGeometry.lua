-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local Axis = require(ViewRecyclerRoblox.Parent.ViewRecycler).Axis
local axisMap = require(ViewRecyclerRoblox.RobloxAdapter.axisMap)

local module = {}

function module.get(arg1, arg2, bool1: boolean, num1: number?)
    if arg1 == nil then
        if not bool1 then
            return UDim2.new(), UDim2.new()
        end
        return UDim2.new(), module.getHostSize(module.getAutomaticSize(arg2, true))
    end
    return axisMap.positionFor(arg1, arg2, num1), axisMap.sizeFor(arg1, arg2, bool1)
end

function module.getAutomaticSize(arg1, bool1: boolean)
    if bool1 then
        if arg1 == Axis.Y then
            return Enum.AutomaticSize.Y
        end

        return Enum.AutomaticSize.X
    end

    return Enum.AutomaticSize.None
end

function module.getHostSize(automaticSize): UDim2
    if automaticSize == Enum.AutomaticSize.None then
        return UDim2.fromScale(1, 1)
    elseif automaticSize == Enum.AutomaticSize.X then
        return UDim2.fromScale(0, 1)
    elseif automaticSize == Enum.AutomaticSize.Y then
        return UDim2.fromScale(1, 0)
    end
    return UDim2.new()
end

return module
