-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local Players = game:GetService("Players")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local RoactUtils = require(ServerDrivenUiParent.RoactUtils)

local Game = require(ServerDrivenUiParent.DataHydration).Game
local VotesUtils = Game.VotesUtils

local SduiSharedContent = require(ServerDrivenUiParent.SduiSharedContent)
local ToastRodux = require(ServerDrivenUiParent.ToastRodux)
local DiscoveryAnalytics = require(ServerDrivenUiParent.DiscoveryAnalytics)
local UniversalAppPolicy = require(ServerDrivenUiParent.UniversalAppPolicy)
local SharedFlags = require(ServerDrivenUiParent.SharedFlags)

local IconVariant = Foundation.Enums.IconVariant
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local SduiDualActionChip = SduiSharedContent.SduiDualActionChip
local ToastType = ToastRodux.Enums.ToastType
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage
local useAppPolicy = UniversalAppPolicy.useAppPolicy
local gameVote = DiscoveryAnalytics.Events.gameVote
local useOptimisticUpdateStatus = require(script.Parent.Hooks.useOptimisticUpdateStatus)

local GetFFlagEdpPlayerFeedbackEnabled = SharedFlags.GetFFlagEdpPlayerFeedbackEnabled
local FFlagLuaAppAddUniverseIdToEngagementEvents = SharedFlags.FFlagLuaAppAddUniverseIdToEngagementEvents

local function convertBooleanToVoteForAnalytics(bool1: boolean?): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return if bool1 == true then "UpVoted" elseif bool1 == false then "DownVoted" else "NotVoted"
end

return React.memo(function(tbl1) -- name: ExperienceDetailsVoteChip
    local layoutOrder = tbl1.layoutOrder
    local universeId = tbl1.universeId
    local var1 = useDispatch()

    local var2 = SignalsReact.useSignalState(Game.getVotesStore(false).getAndFetchVote(universeId).data)
    local var3 = SignalsReact.useSignalState(Game.getVotesStore(false).getAndFetchUserVote(universeId).data)

    local gameInfoStore = Game.getGameInfoStore(false)
    local var4 = SignalsReact.useSignalState(gameInfoStore.getAndFetchGameInfo(universeId).data)
    local rootPlaceId = var4 and var4.rootPlaceId

    local var5 = React.useCallback(function(bool1: boolean?)
        return Game.getVotesStore(false).updateUserVote(universeId, bool1)
    end, { universeId })

    local var6 = React.useCallback(function(arg1)
        if arg1 == nil then
            return
        end

        if arg1.type ~= "error" then
            if arg1.type == "success" then
                local userVote = arg1.userVote

                if GetFFlagEdpPlayerFeedbackEnabled() and userVote ~= nil and rootPlaceId then
                    Game.getUserVoteFeedbackMetadataStore(false).getAndFetchUserVoteFeedbackMetadata(rootPlaceId)
                end
            end

            return
        end

        local str1 = "Feature.Toast.VoteError.Default"
        local reasonForNotVoteable = arg1.reasonForNotVoteable
        if reasonForNotVoteable == "PlayGame" then
            str1 = "Feature.Toast.VoteError.PlayGame"
        elseif reasonForNotVoteable == "FloodCheckThresholdMet" then
            str1 = "Feature.Toast.VoteError.FloodCheckThresholdMet"
        elseif reasonForNotVoteable == "AssetNotVoteable" then
            str1 = "Feature.Toast.VoteError.AssetNotVoteable"
        end

        var1(SetCurrentToastMessage({ toastType = ToastType.NetworkingError, toastMessage = str1 }))
    end, { rootPlaceId, var1 })

    local var7 = useOptimisticUpdateStatus(var5, var6)

    local var8 = React.useCallback(function(bool1: boolean?)
        local userVote = var3 and var3.userVote

        if userVote == bool1 then
            bool1 = nil
        end

        if rootPlaceId then
            local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
            gameVote({
                uid = tostring(userId),
                placeId = rootPlaceId,
                vote = convertBooleanToVoteForAnalytics(bool1),
                prevVote = convertBooleanToVoteForAnalytics(userVote),
                targetId = if FFlagLuaAppAddUniverseIdToEngagementEvents then universeId else nil
            }, "ExperienceDetailsVoteChip")
        end

        if GetFFlagEdpPlayerFeedbackEnabled() and rootPlaceId then
            Game.getUserVoteFeedbackMetadataStore(false).clearItem(rootPlaceId)
        end

        var7(bool1)
    end, {
        universeId,
        var3,
        rootPlaceId,
        var7,
        var1
    })

    local leadingOnActivated = React.useCallback(function()
        var8(true)
    end, { var8 })

    local trailingOnActivated = React.useCallback(function()
        var8(false)
    end, { var8 })

    local text = React.useMemo(function()
        return VotesUtils.getRatingDisplayText(var2)
    end, { var2 })

    local leadingIconVariant = React.useMemo(function()
        return if var3 and var3.userVote == true then IconVariant.Filled else IconVariant.Regular
    end, { var3 })

    local trailingIconVariant = React.useMemo(function()
        return if var3 and var3.userVote == false then IconVariant.Filled else IconVariant.Regular
    end, { var3 })

    if not useAppPolicy(function(arg1)
        return arg1.getGamePlaysAndRatings()
    end) then
        return nil
    end

    return React.createElement(SduiDualActionChip, {
        text = text,
        leadingIconName = Foundation.Enums.IconName.ThumbUp,
        leadingIconVariant = leadingIconVariant,
        leadingOnActivated = leadingOnActivated,
        trailingIconName = Foundation.Enums.IconName.ThumbDown,
        trailingIconVariant = trailingIconVariant,
        trailingOnActivated = trailingOnActivated,
        layoutOrder = layoutOrder
    })
end)
