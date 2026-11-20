-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local React = require(ViewRecyclerReact.Parent.React)
local RecyclableViewReadiness = require(ViewRecyclerReact.ReactAdapter.RecyclableViewReadiness)
local SignalsReact = require(ViewRecyclerReact.Parent.SignalsReact)
local createRecyclableView = require(ViewRecyclerReact.ReactAdapter.createRecyclableView)

local function createRecyclableComponent(func1: (...any) -> (...any), arg1)
    local bool1 = type(func1) == "function"

    local function OrdinaryPropsAdapter(arg2)
        local var1 = SignalsReact.useSignalState(arg2.itemSignal)
        assert(
            type(var1) == "table",
            "createRecyclableComponent: the item must be a props table; use createRecyclableView for other item values"
        )

        local var2 = table.clone(var1)
        var2.pending = arg2.pending

        if bool1 then
            return func1(var2)
        end
        return React.createElement(func1, var2)
    end

    local var1 = table.clone(arg1 or {})
    if var1.readiness == nil then
        var1.readiness = RecyclableViewReadiness.ReadyOnCommit
    end
    return createRecyclableView(OrdinaryPropsAdapter, var1)
end

return createRecyclableComponent
