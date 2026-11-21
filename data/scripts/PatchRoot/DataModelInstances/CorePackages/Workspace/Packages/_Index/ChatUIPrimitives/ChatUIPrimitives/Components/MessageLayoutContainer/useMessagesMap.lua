-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent

local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)

local function useMessagesMap<T>(arg1: T, func1: ((...any) -> (...any))?)
    return React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local result = ({})

            for _, value in (arg1(arg2)) do
                local var1 = if func1 then func1(value) else value.messageId
                result[var1] = value
            end
            return result
        end)
    end, { arg1, func1 })
end

return useMessagesMap
