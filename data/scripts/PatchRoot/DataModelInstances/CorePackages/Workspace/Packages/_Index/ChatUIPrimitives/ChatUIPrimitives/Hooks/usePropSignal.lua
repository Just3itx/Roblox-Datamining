-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent

local React = require(ChatUIPrimitivesParent.React)
local _Signals = require(ChatUIPrimitivesParent.Signals)

local useStableSignal = require(script.Parent.useStableSignal)

local function usePropSignal<T>(arg1: T): T
    local var1, var2 = useStableSignal(arg1)
    React.useEffect(function()
        if var1(false) ~= arg1 then
            var2(arg1)
        end
    end, { arg1, var1, var2 })
    return var1
end

return usePropSignal
