-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)

local function useEventLifecycleRef<T>(callback: (...any) -> (...any), callback2: ((...any) -> (...any))?)
    local var1 = React.useRef(nil)
    return (React.useCallback(function(current)
        if var1.current and callback2 then
            callback2(var1.current)
        end
        if current then
            callback(current)
        end
        var1.current = current
    end, { callback, callback2 }))
end

return useEventLifecycleRef
