-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local React = require(AppChatParent.React)

return function(arg1)
    local var1 = useDispatch()

    return React.useMemo(function()
        return arg1(var1)
    end, { var1, arg1 })
end
