-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent

local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)

local function useStableSignal(arg1)
    local var1 = React.useRef(nil)
    if var1.current == nil then
        local get, set = Signals.createSignal(arg1)
        var1.current = { get = get, set = set }
    end
    local current = var1.current
    return current.get, current.set
end

return useStableSignal
