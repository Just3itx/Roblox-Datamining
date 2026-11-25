-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local useSelector = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useSelector
local FormFactor = require(ProfilePlatformParent.FormFactor).Enums.FormFactor
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local FFlagAXEnableProfileTab = require(ProfilePlatformParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagEnableSplitPane = require(ProfilePlatformParent.SharedFlags).FFlagEnableSplitPane
local SplitPaneStore = if FFlagEnableSplitPane then require(ProfilePlatformParent.SplitPane).SplitPaneStore else nil
local useSignalState = require(ProfilePlatformParent.SignalsReact).useSignalState

local Enums = require(ProfilePlatform.Common.Enums)

return function()
    local var1 = useSelector(function(arg1)
        return arg1.FormFactor
    end)

    local var2 = if FFlagEnableSplitPane then useSignalState(SplitPaneStore.getStore().getIsSplitPaneActive) else false
    local var3 = useProfileWrapperContext()
    local bool1 = var3.profileType == Enums.ProfileTypes.Community
    local bool2 = var3.sourceInfo.source == Enums.Sources.HomepageAd

    local isFullView = (if FFlagAXEnableProfileTab then var3.forceFullView == true else nil) or bool1 and bool2

    return (React.useMemo(function()
        return if var1 == FormFactor.WIDE or var2 then {
            formFactor = Enums.ProfileFormFactor.Wide,
            isFullView = isFullView
        } else {
            formFactor = Enums.ProfileFormFactor.PeekView,
            isFullView = isFullView
        }
    end, { var1, isFullView, var2 }))
end
