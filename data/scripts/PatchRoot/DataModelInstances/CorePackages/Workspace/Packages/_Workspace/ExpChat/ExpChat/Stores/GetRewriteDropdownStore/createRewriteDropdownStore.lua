-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local createSignal = require(ExpChatParent.Signals).createSignal

return function()
    local getOpenMessageId, var2 = createSignal(nil)
    local getComponentId, setComponentId = createSignal(nil)

    return {
        getOpenMessageId = getOpenMessageId,
        getComponentId = getComponentId,
        toggleDropdown = function(str1: string)
            var2(function(arg1): string?
                return if arg1 == str1 then nil else str1
            end)
        end,
        setComponentId = setComponentId
    }
end
