-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)

local function useGetAndSetRef(arg1)
    local var1 = React.useRef(arg1)
    return React.useCallback(function()
        return var1.current
    end, {}), (React.useCallback(function(current)
        if typeof(current) == "function" then
            var1.current = current(var1.current)
            return
        end
        var1.current = current
    end, {}))
end
return useGetAndSetRef
