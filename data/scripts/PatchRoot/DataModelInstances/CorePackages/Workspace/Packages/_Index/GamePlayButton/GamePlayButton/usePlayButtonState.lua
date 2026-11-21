-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T21:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local PlayButtonStates = require(GamePlayButton.PlayButtonStates)
local FetchGamePlayButtonData = require(GamePlayButton.FetchGamePlayButtonData)
local ApiPostPreparePurchase = require(GamePlayButton.ApiPostPreparePurchase)
local PlaytestUnlockUpsell = require(GamePlayButton.PlaytestUnlockUpsell)

local GamePlayButtonParent = GamePlayButton.Parent
local FFlagEnableGameJoinEarlyAccess = require(GamePlayButtonParent.SharedFlags).FFlagEnableGameJoinEarlyAccess
local GetFFlagIsSquadEnabled = require(GamePlayButtonParent.SharedFlags).GetFFlagIsSquadEnabled

local React = require(GamePlayButtonParent.React)
local _PlayabilityRodux = require(GamePlayButtonParent.PlayabilityRodux)
local PlayabilityStatusEnum = require(GamePlayButtonParent.DiscoveryTypes).PlayabilityStatusEnum
local RetrievalStatus = require(GamePlayButtonParent.Http).Enum.RetrievalStatus
local RoactUtils = require(GamePlayButtonParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local FetchGamePlayabilityAndProductInfo = require(GamePlayButtonParent.GameDetailRodux).FetchGamePlayabilityAndProductInfo
local GamesProductInfoReducer = require(GamePlayButtonParent.GameProductInfoRodux).GamesProductInfoReducer
local useCurrentSquadSelector = require(GamePlayButtonParent.RoduxSquads).Hooks.useCurrentSquadSelector
local useIsExperienceInvitePending = require(GamePlayButtonParent.Squads.useIsExperienceInvitePending)
local useAppPolicy = require(GamePlayButtonParent.UniversalAppPolicy).useAppPolicy
local useRouteName = require(GamePlayButtonParent.Navigation).useRouteName
local sendPlayButtonLoadingDuration = require(GamePlayButtonParent.DiscoveryAnalytics).Events.sendPlayButtonLoadingDuration

local FFlagLuaAppParentUpsellPolicy = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppParentUpsellPolicy

local FFlagLuaAppEnablePlayableStateWhenLoading = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppEnablePlayableStateWhenLoading

local FFlagLuaAppSupportDisablePlayableWhenLoading = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppSupportDisablePlayableWhenLoading

local FFlagLuaAppDisablePlayableWhenLoadingForce = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppDisablePlayableWhenLoadingForce
local FFlagLuaAppPlayButtonAmpAgeCheckFlow = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonAmpAgeCheckFlow
local FFlagLuaAppParentApprovedExperiences = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppParentApprovedExperiences

local FFlagLuaAppPlayButtonLoadingDurationTelemetry = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonLoadingDurationTelemetry

local FFlagLuaAppPlayButtonPrivatePTEnableSingleButton = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonPrivatePTEnableSingleButton

local FFlagLuaAppPlayButtonPrivatePTEnableDualButton = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonPrivatePTEnableDualButton
local bool1 = game:DefineFastFlag("LuaAppPlaytestSingleBlocksPlayable", false)

local function selectPlayButtonState(done, arg1, arg2, arg3, bool2: boolean?, arg4, bool3: boolean?, bool4: boolean?)
    local var1

    if done == RetrievalStatus.Done and arg1 ~= nil then
        local bool5 = if FFlagLuaAppPlayButtonPrivatePTEnableSingleButton then not (arg1.privatePlaytestInfo == nil)
            and not arg1.privatePlaytestInfo.isPlayable
            and PlaytestUnlockUpsell.getType(arg1.privatePlaytestInfo.playabilityStatus) ~= nil else nil

        if arg1.isPlayable == true and not (bool1 and bool5) then
            var1 = PlayButtonStates.Playable
        elseif FFlagLuaAppPlayButtonPrivatePTEnableSingleButton and bool5 then
            var1 = PlayButtonStates.ActionNeeded
        elseif arg1.playabilityStatus == PlayabilityStatusEnum.PurchaseRequired and arg2 ~= nil and arg2.isForSale == true then
            var1 = PlayButtonStates.PaidAccess
        elseif arg1.playabilityStatus == PlayabilityStatusEnum.FiatPurchaseRequired and arg2 ~= nil and arg2.isForSale == true then
            var1 = PlayButtonStates.FiatPaidAccess
        elseif FFlagLuaAppPlayButtonAmpAgeCheckFlow
            and (arg1.playabilityStatus == PlayabilityStatusEnum.ContextualPlayabilityUnverifiedSeventeenPlusUser
                or (not FFlagLuaAppParentUpsellPolicy or bool3)
                    and (arg1.playabilityStatus == PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls
                        or FFlagLuaAppParentApprovedExperiences
                            and arg1.playabilityStatus == PlayabilityStatusEnum.ContextualPlayabilityRequireParentApproval)
                or arg1.playabilityStatus == PlayabilityStatusEnum.ContextualPlayabilityAgeCheckRequired)
            or not FFlagLuaAppPlayButtonAmpAgeCheckFlow
                and arg1.playabilityStatus == PlayabilityStatusEnum.ContextualPlayabilityUnverifiedSeventeenPlusUser
            or not FFlagLuaAppPlayButtonAmpAgeCheckFlow
                and (not FFlagLuaAppParentUpsellPolicy or bool3)
                and (arg1.playabilityStatus == PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls
                    or FFlagLuaAppParentApprovedExperiences
                        and arg1.playabilityStatus == PlayabilityStatusEnum.ContextualPlayabilityRequireParentApproval)
        then
            var1 = PlayButtonStates.ActionNeeded
        elseif FFlagEnableGameJoinEarlyAccess and bool4 and arg1.playabilityStatus == PlayabilityStatusEnum.PlusSubscriptionRequired then
            var1 = PlayButtonStates.EarlyAccessLocked
        else
            var1 = PlayButtonStates.UnplayableOther
        end
    else
        var1 = PlayButtonStates.Playable
    end

    if GetFFlagIsSquadEnabled()
        and var1 == PlayButtonStates.Playable
        and arg3
        and #arg3.members > 1
        and (not arg4 or not arg4.maxPlayers or arg4.maxPlayers > 1)
    then
        if bool2 then
            return PlayButtonStates.WaitingForParty
        end
        var1 = PlayButtonStates.PlayableWithParty
    end

    return var1
end

local function selectSecondaryPlayButtonState(str1: string, arg1)
    if arg1 == nil then
        return nil
    end

    if FFlagLuaAppPlayButtonPrivatePTEnableDualButton and arg1.privatePlaytestInfo ~= nil then
        local privatePlaytestInfo = arg1.privatePlaytestInfo
        local type = PlaytestUnlockUpsell.getType(privatePlaytestInfo.playabilityStatus)

        if str1 == PlayButtonStates.ActionNeeded then
            return nil
        end

        if privatePlaytestInfo.isPlayable or type ~= nil then
            return PlayButtonStates.Playtest
        end
    end

    return if (str1 == PlayButtonStates.PaidAccess
        or str1 == PlayButtonStates.FiatPaidAccess
        or arg1.playabilityStatus == PlayabilityStatusEnum.FiatPurchaseDeviceRestricted
            and str1 == PlayButtonStates.UnplayableOther
        or arg1.playabilityStatus == PlayabilityStatusEnum.ContextualPlayabilityRegionalAvailability
            and str1 == PlayButtonStates.UnplayableOther)
        and arg1.demoModeAvailable then PlayButtonStates.DemoMode else nil
end

return function(arg1, current: number?, num1: number?, bool2: boolean?, bool3: boolean?, str1: string?, bool4: boolean?)
    local var1 = useDispatch()

    React.useEffect(function()
        local var2 = nil
        if num1 ~= nil and num1 > 0 then
            var2 = task.delay(num1, function()
                var2 = nil
                var1(FetchGamePlayButtonData.Fetch(arg1, current))
            end)
        else
            var1(FetchGamePlayButtonData.Fetch(arg1, current))
        end

        return function()
            if var2 ~= nil then
                task.cancel(var2)
            end
        end
    end, { current, num1 })

    local var2 = if FFlagLuaAppParentUpsellPolicy then useAppPolicy(function(arg2)
        return arg2.getShouldShowVpcPlayButtonUpsells()
    end) else nil

    local var3 = nil
    if FFlagLuaAppSupportDisablePlayableWhenLoading then
        local var4 = useAppPolicy(function(arg2)
            return arg2.getDisablePlayableWhenLoading()
        end)

        var3 = FFlagLuaAppDisablePlayableWhenLoadingForce or var4
    end

    local var4 = if GetFFlagIsSquadEnabled() then useCurrentSquadSelector() else nil
    local var5 = if GetFFlagIsSquadEnabled() then useIsExperienceInvitePending() else nil

    local var6 = useSelector(function(arg2)
        return arg2.PlayabilityStatus and arg2.PlayabilityStatus[current] or nil
    end)

    local var7

    if FFlagEnableGameJoinEarlyAccess then
        var7 = require(GamePlayButton.EarlyAccess.useGameJoinEarlyAccess)(current, var6)
        local bool5 = not (var7 == nil) and var7.isPendingUnlock == true
        local var8 = if var7 == nil then 0 else var7.unlockRefetchTick
        local bool6 = not (var7 == nil) and var7.gainedSubscription == true

        React.useEffect(function()
            if bool5 or bool6 then
                var1(FetchGamePlayButtonData.Fetch(arg1, current, true))
            end
        end, {
            bool5,
            var8,
            bool6,
            current
        })
    else
        var7 = nil
    end

    local var8 = useSelector(function(arg2)
        if FetchGamePlayButtonData.IsLoading(arg2, current) then
            if FFlagLuaAppEnablePlayableStateWhenLoading then
                if bool2 and not (FFlagLuaAppSupportDisablePlayableWhenLoading and var3) then
                    if GetFFlagIsSquadEnabled() and var4 and #var4.members > 1 then
                        if var5 then
                            return PlayButtonStates.WaitingForParty
                        end

                        return PlayButtonStates.PlayableWithParty
                    end

                    return PlayButtonStates.Playable
                end

                return PlayButtonStates.Loading
            end

            return PlayButtonStates.Loading
        elseif ApiPostPreparePurchase.GetFetchingStatus(arg2, current) == RetrievalStatus.Fetching then
            return PlayButtonStates.Loading
        else
            local fetchingStatus = FetchGamePlayabilityAndProductInfo.GetFetchingStatus(arg2, current)
            local var8 = if arg2[GamesProductInfoReducer.key] then arg2[GamesProductInfoReducer.key][current] or nil else nil

            if GetFFlagIsSquadEnabled() then
                local gameDetail = arg2.GameDetails[current]

                return (selectPlayButtonState(
                    fetchingStatus,
                    var6,
                    var8,
                    var4,
                    var5,
                    gameDetail,
                    if FFlagLuaAppParentUpsellPolicy then var2 else nil,
                    if FFlagEnableGameJoinEarlyAccess then bool4 else nil
                ))
            end

            return (selectPlayButtonState(
                fetchingStatus,
                var6,
                var8,
                nil,
                nil,
                nil,
                if FFlagLuaAppParentUpsellPolicy then var2 else nil,
                if FFlagEnableGameJoinEarlyAccess then bool4 else nil
            ))
        end
    end)

    if FFlagLuaAppPlayButtonLoadingDurationTelemetry then
        local var9 = useRouteName()

        local var10 = React.useRef(nil)
        local var11 = React.useRef(nil)
        local var12 = React.useRef(nil)
        local var13 = React.useRef(nil)

        local var14 = React.useRef(var8)
        var14.current = var8

        local var15 = React.useRef(var6)
        var15.current = var6

        local var16 = React.useCallback(function(endReason: string)
            local current2 = var10.current
            local current3 = var11.current
            local current4 = var12.current
            if not (current2 and current3) then
                return
            end

            var10.current = nil
            var11.current = nil

            sendPlayButtonLoadingDuration({
                universeId = current3,
                durationMs = math.floor((os.clock() - current2) * 1000),
                endReason = endReason,
                endPlayButtonState = var14.current,
                endPlayabilityStatus = var15.current and var15.current.playabilityStatus or nil,
                pageName = var13.current
            }, current4)

            var12.current = nil
            var13.current = nil
        end, {})

        React.useEffect(function()
            if var8 ~= PlayButtonStates.Loading then
                var16("stateChanged")
                return
            end

            if not bool3 then
                return
            end

            if not var10.current then
                var10.current = os.clock()
                var11.current = current
                var12.current = str1
                var13.current = var9
                return
            end

            if var11.current == current then
                return
            end

            var16("universeChanged")
            var10.current = os.clock()
            var11.current = current
            var12.current = str1
            var13.current = var9
        end, {
            var8,
            var16,
            current,
            bool3,
            str1,
            var9
        })

        React.useEffect(function()
            return function()
                var16("unmounted")
            end
        end, { var16 })
    end

    return {
        playButtonState = var8,
        secondaryPlayButtonState = selectSecondaryPlayButtonState(var8, var6),
        playabilityStatus = var6,
        earlyAccess = var7
    }
end
