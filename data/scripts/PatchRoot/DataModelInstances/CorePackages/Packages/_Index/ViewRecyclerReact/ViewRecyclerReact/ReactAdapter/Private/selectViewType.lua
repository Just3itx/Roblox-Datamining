-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local _CompositionPlacement = require(ViewRecyclerReact.ReactAdapter.Private.CompositionPlacement)
local _RecyclableViewRegistry = require(ViewRecyclerReact.ReactAdapter.Private.RecyclableViewRegistry)
local Signals = require(ViewRecyclerReact.Parent.Signals)

local function selectViewType(arg1, func1: (...any) -> (...any))
    if type(arg1) == "function" then
        return Signals.createComputed(function(arg2)
            return func1(arg1(arg2))
        end)
    end

    local var1 = func1(arg1)
    return function(_)
        return var1
    end
end

return selectViewType
