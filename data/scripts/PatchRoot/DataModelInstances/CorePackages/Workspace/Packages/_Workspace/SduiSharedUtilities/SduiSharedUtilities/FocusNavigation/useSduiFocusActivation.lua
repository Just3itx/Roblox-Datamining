-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent

local React = require(SduiSharedUtilitiesParent.React)

local getSduiFocusActivationStore = require(script.Parent.getSduiFocusActivationStore)

local function useSduiFocusActivation(str1: string?, func1: ((...any) -> (...any))?)
    React.useEffect(function()
        if str1 ~= nil and func1 ~= nil then
            return getSduiFocusActivationStore().register(str1, func1)
        end
    end, { str1, func1 })
end

return useSduiFocusActivation
