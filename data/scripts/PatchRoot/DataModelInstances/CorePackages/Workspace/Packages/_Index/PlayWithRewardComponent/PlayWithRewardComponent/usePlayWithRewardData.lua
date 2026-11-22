-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdService = game:GetService("AdService")
local ExperienceService = game:GetService("ExperienceService")

local PlayWithRewardComponent = script:FindFirstAncestor("PlayWithRewardComponent")
local FetchPlayWithRewardState = require(PlayWithRewardComponent.FetchPlayWithRewardState)
local shouldRenderPlayWithRewardBanner = require(PlayWithRewardComponent.shouldRenderPlayWithRewardBanner)

local PlayWithRewardComponentParent = PlayWithRewardComponent.Parent
local PlayWithRewardState = require(PlayWithRewardComponentParent.PlayWithRewardState)
local React = require(PlayWithRewardComponentParent.React)
local RoactUtils = require(PlayWithRewardComponentParent.RoactUtils)
local FFlagPlayWithRewardClearOnExperienceLeave = require(PlayWithRewardComponentParent.SharedFlags).FFlagPlayWithRewardClearOnExperienceLeave
local SetPlayWithRewardState = PlayWithRewardState.SetPlayWithRewardState
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local function usePlayWithRewardData(tbl1)
    local universeId = tbl1.universeId
    local shouldFetch = tbl1.shouldFetch

    local playWithRewardData = useSelector(function(arg1)
        return if arg1.PlayWithRewardState and arg1.PlayWithRewardState.universeId == universeId then arg1.PlayWithRewardState else nil
    end)
    local var2 = useSelector(function(arg1)
        return arg1.LocalUserId
    end)
    local var3 = useDispatch()

    local var4 = if FFlagPlayWithRewardClearOnExperienceLeave then React.useRef(false) else nil

    local onFetchDispatched = tbl1.onFetchDispatched
    React.useEffect(function()
        if FFlagPlayWithRewardClearOnExperienceLeave then
            if not (shouldFetch or var4.current) then
                return
            end
            if var4.current then
                var4.current = false
            end
        elseif not shouldFetch then
            return
        end

        local var5 = tonumber(var2)
        if not var5 or playWithRewardData and playWithRewardData.universeId == universeId then
            return
        end

        if onFetchDispatched then
            onFetchDispatched()
        end
        var3(FetchPlayWithRewardState(AdService, universeId, var5)):catch(function() end)
    end, {
        shouldFetch,
        universeId,
        var2,
        playWithRewardData,
        var3,
        onFetchDispatched
    })
    React.useEffect(function()
        local var5 = if FFlagPlayWithRewardClearOnExperienceLeave then ExperienceService:RegisterForExperienceLeave(function()
            var4.current = true
            var3(SetPlayWithRewardState("", "", false, nil))
        end) else nil

        return function()
            var3(SetPlayWithRewardState("", "", false, nil))
            if var5 then
                var5:Disconnect()
            end
        end
    end, { var3 })

    local var5

    if playWithRewardData then
        local flowId = playWithRewardData.flowId
        local universeId2 = playWithRewardData.universeId
        local adData = playWithRewardData.adData

        var5 = not (flowId == "") and playWithRewardData.isAdDataExpected
            or shouldRenderPlayWithRewardBanner(universeId, flowId, universeId2, adData)
    else
        var5 = false
    end

    return { playWithRewardData = playWithRewardData, showPlayWithReward = var5 }
end

return usePlayWithRewardData
