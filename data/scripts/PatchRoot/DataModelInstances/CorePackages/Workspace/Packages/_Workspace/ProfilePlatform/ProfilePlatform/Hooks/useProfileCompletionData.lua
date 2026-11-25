-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local SignalsReact = require(ProfilePlatformParent.SignalsReact)
local SduiSharedUtilities = require(ProfilePlatformParent.SduiSharedUtilities)
local _SduiCoreSystem = require(ProfilePlatformParent.SduiCoreSystem)
local Enums = require(ProfilePlatform.Common.Enums)

local createProfileCompletionPromptsConfig = require(ProfilePlatformParent.ProfilePlatformCommon).Utils.createProfileCompletionPromptsConfig

local ServerTriggeredModals = require(ProfilePlatformParent.ServerTriggeredModals)

local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local fetchPrompts = ServerTriggeredModals.fetchPrompts

local function useProfileCompletionData()
    local var1 = React.useMemo(function()
        return createProfileCompletionPromptsConfig()
    end, {})

    React.useEffect(function()
        fetchPrompts(var1, true)
    end, { var1 })

    local var2 = React.useCallback(function()
        fetchPrompts(createProfileCompletionPromptsConfig(), true)
    end, {})

    local var3 = React.useCallback(function(arg1)
        local var3 = getSduiApiStore().getData(Enums.Components.ProfileCompletion).data(arg1)
        if not var3 then
            return nil
        end

        local config = nil
        local num1 = 0
        for _, value in var3 do
            if not (value and value.config) then
                continue
            end

            local dataUpdatedTimestamp = value.dataUpdatedTimestamp or 0
            if not config or num1 < dataUpdatedTimestamp then
                config = value.config
                num1 = dataUpdatedTimestamp
            end
        end

        return config
    end, {})

    return SignalsReact.useSignalState(var3), var2
end

return useProfileCompletionData
