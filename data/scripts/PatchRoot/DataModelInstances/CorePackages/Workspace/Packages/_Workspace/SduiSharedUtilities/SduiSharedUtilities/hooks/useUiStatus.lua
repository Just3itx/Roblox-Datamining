-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local DataHydration = require(SduiSharedUtilitiesParent.DataHydration)
local SignalsReact = require(SduiSharedUtilitiesParent.SignalsReact)

local getSduiApiStore = require(SduiSharedUtilities.getSduiApiStore)
local UiStatus = require(SduiSharedUtilities.SduiIntegrationTypes).UiStatus

local DataHydrationTypes = DataHydration.DataHydrationTypes

local function useUiStatus(str1: string)
    local var1 = SignalsReact.useSignalState(getSduiApiStore().getData(str1).status)

    if var1 == DataHydrationTypes.DataStatus.NotReady then
        return UiStatus.Loading
    end

    if var1 == DataHydrationTypes.DataStatus.Failed then
        return UiStatus.Error
    end

    return UiStatus.Resolved
end

return useUiStatus
