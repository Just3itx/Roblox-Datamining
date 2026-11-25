-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local React = require(SduiSharedUtilitiesParent.React)
local SignalsReact = require(SduiSharedUtilitiesParent.SignalsReact)

local getSduiApiStore = require(SduiSharedUtilities.getSduiApiStore)

local function useEntrySurfacing(str1: string, str2: string?, str3: string)
    local var1 = React.useCallback(function(arg1)
        local var1 = if str2 then `{str1}_{str2}` else nil
        local var2 = getSduiApiStore().getEntrySurfacing(str1, var1, arg1)
        return var2 and var2[str3]
    end, { str1, str2, str3 })

    return SignalsReact.useSignalState(var1)
end

return useEntrySurfacing
