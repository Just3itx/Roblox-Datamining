-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local _LayoutRuntime = require(ViewRecycler.Core.Layout.LayoutRuntime)
local _Types = require(ViewRecycler.Core.Types)

local module = {}

function module.expandItemRange(arg1, num1: number, num2: number, num3: number)
    return {
        firstIndex = math.max(1, arg1.firstIndex - num1),
        lastIndex = math.min(num3, arg1.lastIndex + num2)
    }
end

function module.updateItemMeasurementNoop(_)
    return { accepted = false, geometryChanged = false }
end

function module.requiresItemMeasurementFalse(): boolean
    return false
end

function module.geometryUnchanged(): boolean
    return false
end

function module.noop() end

return module
