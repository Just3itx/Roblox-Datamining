-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local React = require(SduiSharedUtilitiesParent.React)
local SignalsReact = require(SduiSharedUtilitiesParent.SignalsReact)

local getSduiApiStore = require(SduiSharedUtilities.getSduiApiStore)

local function useInputData(str1: string, str2: string?)
    local var1 = React.useCallback(function(arg1)
        local sduiApiStore = getSduiApiStore()
        sduiApiStore.getData(str1).status(arg1)

        local getInputData = sduiApiStore.getInputData
        if not getInputData then
            return nil
        end

        if str2 then
            local inputData = getInputData(str1, str2, arg1)
            if inputData ~= nil then
                return inputData
            end
        end

        return getInputData(str1, nil, arg1)
    end, { str1, str2 })

    return SignalsReact.useSignalState(var1)
end

return useInputData
