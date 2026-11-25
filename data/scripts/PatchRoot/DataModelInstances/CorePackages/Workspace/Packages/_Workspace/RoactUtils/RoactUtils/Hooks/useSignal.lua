-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent
local React = require(RoactUtilsParent.React)

local _AppCommonLib = require(RoactUtilsParent.AppCommonLib)

local function useSignal<T>(arg1: T, func1: (...any) -> (...any))
    React.useEffect(function()
        if not arg1 then
            return
        end

        assert(arg1 ~= nil, "signal is not nil")

        local connection = arg1:connect(func1)
        return function()
            connection:disconnect()
        end
    end, { arg1, func1 })
end

return useSignal
