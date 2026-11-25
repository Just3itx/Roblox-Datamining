-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent
local React = require(SduiSharedUtilitiesParent.React)

local function useStatefulRef(arg1)
    local var1, var2 = React.useState(nil)
    return var1, (React.useCallback(function(current)
        if typeof(arg1) == "function" then
            arg1(current)
        elseif typeof(arg1) == "table" then
            arg1.current = current
        end
        var2(current)
    end, { arg1 }))
end
return useStatefulRef
