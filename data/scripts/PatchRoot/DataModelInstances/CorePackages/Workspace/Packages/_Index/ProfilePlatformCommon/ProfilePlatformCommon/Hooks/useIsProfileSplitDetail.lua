-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformCommonParent = script:FindFirstAncestor("ProfilePlatformCommon").Parent

local useSignalState = require(ProfilePlatformCommonParent.SignalsReact).useSignalState

local FFlagEnableSplitPane = require(ProfilePlatformCommonParent.SharedFlags).FFlagEnableSplitPane
local SplitPane = if FFlagEnableSplitPane then require(ProfilePlatformCommonParent.SplitPane) else nil

return function(): boolean
    if not FFlagEnableSplitPane then
        return false
    end

    local store = SplitPane.SplitPaneStore.getStore()
    local var1 = useSignalState(store.getSupportPaneModeIfActive)

    return not (var1 == nil) and SplitPane.SplitPaneVariant.getProfileSplitPaneEligibility(var1) ~= nil
end
