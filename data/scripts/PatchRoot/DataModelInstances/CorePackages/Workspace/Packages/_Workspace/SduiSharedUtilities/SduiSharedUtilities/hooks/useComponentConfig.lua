-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local React = require(SduiSharedUtilitiesParent.React)
local SignalsReact = require(SduiSharedUtilitiesParent.SignalsReact)
local _SduiCoreSystem = require(SduiSharedUtilitiesParent.SduiCoreSystem)
local getSduiApiStore = require(SduiSharedUtilities.getSduiApiStore)

local function useComponentConfig(str1: string, str2: string?)
    local var1 = React.useCallback(function(arg1)
        local var1 = if str2 then `{str1}_{str2}` else nil
        return getSduiApiStore().getRootConfig(str1, arg1, var1)
    end, { str1, str2 })

    return SignalsReact.useSignalState(var1)
end

return useComponentConfig
