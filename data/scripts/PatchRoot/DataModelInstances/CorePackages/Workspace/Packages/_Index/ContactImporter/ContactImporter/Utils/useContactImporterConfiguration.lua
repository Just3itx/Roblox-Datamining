-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local scriptParentParentParent = scriptParentParent.Parent

local useSelector = dependencies.useSelector
local useSignalState = require(scriptParentParentParent.SignalsReact).useSignalState
local getContactImporterParams = require(script.Parent.getContactImporterParams)
local useUiModeInfo = require(scriptParentParentParent.RobloxAppHooks).useUiModeInfo
local UiMode = require(scriptParentParentParent.RobloxAppEnums).UiMode
local FFlagUseSignalsForIsLocalUserSoothsayer = require(scriptParentParentParent.SharedFlags).FFlagUseSignalsForIsLocalUserSoothsayer
local GetIsLocalUserSoothsayerStore = if FFlagUseSignalsForIsLocalUserSoothsayer then require(scriptParentParentParent.IsLocalUserSoothsayerStore).GetIsLocalUserSoothsayerStore else nil

return function(tbl1)
    local var1 = if FFlagUseSignalsForIsLocalUserSoothsayer then useSignalState(GetIsLocalUserSoothsayerStore(false).getIsLocalUserSoothsayer) else useSelector(function(arg1)
        return arg1.IsLocalUserSoothsayer
    end)
    local var2 = useSelector(getContactImporterParams)
    local policyIsEnabled, shouldShowContactImporterFeature

    if useUiModeInfo().uiMode ~= UiMode.TenFoot and var1 then
        policyIsEnabled = true
        shouldShowContactImporterFeature = true
    else
        policyIsEnabled = tbl1.policyIsEnabled
        shouldShowContactImporterFeature = var2.shouldShowContactImporterFeature
    end

    local shouldShowContactImporter = policyIsEnabled and shouldShowContactImporterFeature
    return {
        shouldFetchContactImporterData = policyIsEnabled or false,
        shouldShowContactImporter = shouldShowContactImporter or false,
        shouldShowContactImporterModal = shouldShowContactImporter and var2.shouldShowContactImporterUpsellModal or false
    }
end
