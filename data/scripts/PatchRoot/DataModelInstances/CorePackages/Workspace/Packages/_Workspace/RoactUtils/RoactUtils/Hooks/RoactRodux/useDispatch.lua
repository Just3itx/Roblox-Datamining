-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent
local React = require(RoactUtilsParent.React)

local useStore = require(script.Parent.useStore)

local function useDispatch()
    local var1 = useStore()

    return (React.useCallback(function(...)
        return var1:dispatch(...)
    end, { var1 }))
end

return useDispatch
