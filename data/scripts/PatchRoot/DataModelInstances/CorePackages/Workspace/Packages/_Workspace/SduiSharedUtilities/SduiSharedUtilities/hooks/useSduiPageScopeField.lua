-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent
local SignalsReact = require(SduiSharedUtilitiesParent.SignalsReact)
local getSduiClientPageScope = require(SduiSharedUtilitiesParent.SduiCoreSystem).getSduiClientPageScope

local function func1()
    return nil
end

local function useSduiPageScopeField(arg1, str1: string)
    local var1 = if arg1 and arg1.configKey then getSduiClientPageScope(arg1.configKey).getSignal(str1) else func1
    return SignalsReact.useSignalState(var1)
end

return useSduiPageScopeField
