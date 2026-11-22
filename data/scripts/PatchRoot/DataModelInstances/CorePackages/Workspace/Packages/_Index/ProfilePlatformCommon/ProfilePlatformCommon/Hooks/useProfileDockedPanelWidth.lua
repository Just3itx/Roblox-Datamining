-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformCommonParent = script:FindFirstAncestor("ProfilePlatformCommon").Parent

local useSelector = require(ProfilePlatformCommonParent.RoactUtils).Hooks.RoactRodux.useSelector
local FormFactor = require(ProfilePlatformCommonParent.FormFactor).Enums.FormFactor
local useSignalState = require(ProfilePlatformCommonParent.SignalsReact).useSignalState

local useProfileCardWidth = require(script.Parent.useProfileCardWidth)

local FFlagEnableSplitPane = require(ProfilePlatformCommonParent.SharedFlags).FFlagEnableSplitPane
local SplitPane = if FFlagEnableSplitPane then require(ProfilePlatformCommonParent.SplitPane) else nil

return function(bool1: boolean?)
    local var1 = useSelector(function(arg1)
        return arg1.FormFactor
    end)

    local bool2

    if FFlagEnableSplitPane then
        local store = SplitPane.SplitPaneStore.getStore()
        local var2 = useSignalState(store.getSupportPaneModeIfActive)
        if var2 == nil then
            bool2 = false
        else
            bool2 = SplitPane.SplitPaneVariant.getProfileSplitPaneEligibility(var2) ~= nil
        end
    else
        bool2 = false
    end
    local var2 = useProfileCardWidth()

    return if bool1 and var1 == FormFactor.WIDE and not bool2 then var2 else nil
end
