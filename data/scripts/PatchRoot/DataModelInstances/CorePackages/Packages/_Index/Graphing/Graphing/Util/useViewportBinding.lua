-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)
local Signals = require(GraphingParent.Signals)
local SignalsReact = require(GraphingParent.SignalsReact)

local CanvasContext = require(Graphing.CanvasContext)
local _Types = require(Graphing.Types)

return {
    useViewportBinding = function(func1: (...any) -> (...any), tbl1)
        local var1 = React.useContext(CanvasContext)
        local viewportRectGetter = var1.viewportRectGetter

        local tbl2 = { viewportRectGetter }
        if tbl1 then
            for _, value in tbl1 do
                table.insert(tbl2, value)
            end
        end

        local var2 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                viewportRectGetter(arg1)
                return func1(var1)
            end)
        end, tbl2)

        return SignalsReact.useSignalBinding(var2)
    end,
    useViewportVisibility = function(func1: (...any) -> (...any), tbl1)
        local var1 = React.useContext(CanvasContext)
        local viewportRectGetter = var1.viewportRectGetter

        local tbl2 = { viewportRectGetter }
        if tbl1 then
            for _, value in tbl1 do
                table.insert(tbl2, value)
            end
        end

        local var2 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                viewportRectGetter(arg1)
                return func1(var1)
            end)
        end, tbl2)

        return SignalsReact.useSignalState(var2)
    end
}
