-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:10:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local function useUncontrolledState(bool1: boolean?, callback: (...any) -> (...any))
    local var1, var2 = React.useState(bool1 or false)
    React.useEffect(function()
        if bool1 ~= nil then
            var2(bool1)
        end
    end, { bool1 })

    return var1, (React.useCallback(function(bool2: boolean)
        if bool1 == nil then
            var2(bool2)
        end
        callback(bool2)
    end, { bool1, callback }))
end

return useUncontrolledState
