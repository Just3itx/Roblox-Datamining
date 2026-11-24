-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local useEffect = require(scriptParentParentParent.React).useEffect

function usePingLazyRenderResizing(arg1, arg2)
    useEffect(function()
        if arg1.current then
            local _absoluteSize = arg1.current.AbsoluteSize
        end
    end, { arg2 })
end

return usePingLazyRenderResizing
