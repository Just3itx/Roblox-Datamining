-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local Navigation = require(SduiSharedContentParent.Navigation)
local React = require(SduiSharedContentParent.React)
local PlayWithRewardComponent = require(SduiSharedContentParent.PlayWithRewardComponent)
local GamePlayButton = require(SduiSharedContentParent.GamePlayButton)
local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)

local PlayWithRewardComponent2 = PlayWithRewardComponent.PlayWithRewardComponent
local usePlayWithRewardData = PlayWithRewardComponent.usePlayWithRewardData
local usePlayButtonState = GamePlayButton.usePlayButtonState
local PlayButtonStates = GamePlayButton.PlayButtonStates
local useNavigationFocus = Navigation.useNavigationFocus
local getSduiClientPageScope = SduiCoreSystem.getSduiClientPageScope

return React.memo(function(tbl1) -- name: SduiPlayWithReward
    local var1 = useNavigationFocus()
    local shouldFetch, var3 = React.useState(false)

    local networking = tbl1.sduiContext and tbl1.sduiContext.dependencies and tbl1.sduiContext.dependencies.networking
    local var4 = usePlayButtonState(networking, tbl1.universeId)
    local bool1 = var4.playButtonState == PlayButtonStates.Playable

    React.useEffect(function()
        if var1 then
            var3(true)
        end
    end, { var1 })

    local var5 = usePlayWithRewardData({
        universeId = tbl1.universeId,
        shouldFetch = shouldFetch,
        onFetchDispatched = function()
            var3(false)
        end
    })
    local playWithRewardData = var5.playWithRewardData
    local showPlayWithReward = var5.showPlayWithReward

    local var6 = bool1 and showPlayWithReward and playWithRewardData

    local var7 = var4.playButtonState ~= PlayButtonStates.Loading and playWithRewardData and not var6
    local configKey = tbl1.sduiContext and tbl1.sduiContext.configKey

    React.useEffect(function()
        if not (configKey and var7) then
            return
        end
        getSduiClientPageScope(configKey).set("filterPlayWithReward", true)
    end, { configKey, var7 })

    if not var6 then
        return nil
    end

    return React.createElement(PlayWithRewardComponent2, {
        universeId = tbl1.universeId,
        placeId = tbl1.placeId,
        placeIdOverride = tbl1.placeIdOverride,
        experienceJoinData = tbl1.experienceJoinData,
        flowId = playWithRewardData.flowId,
        fetchedUniverseId = playWithRewardData.universeId,
        isAdDataExpected = playWithRewardData.isAdDataExpected,
        playWithRewardAdData = playWithRewardData.adData,
        useLargerStyles = tbl1.useLargerStyles,
        layoutOrder = tbl1.layoutOrder
    })
end)
