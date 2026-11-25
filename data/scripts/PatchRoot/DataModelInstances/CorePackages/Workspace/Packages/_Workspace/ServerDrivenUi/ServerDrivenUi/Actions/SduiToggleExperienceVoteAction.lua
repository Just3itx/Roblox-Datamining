-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local DataHydration = require(ServerDrivenUiParent.DataHydration)
local DiscoveryAnalytics = require(ServerDrivenUiParent.DiscoveryAnalytics)
local Foundation = require(ServerDrivenUiParent.Foundation)
local Game = DataHydration.Game
local SharedFlags = require(ServerDrivenUiParent.SharedFlags)
local Signals = require(ServerDrivenUiParent.Signals)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getSduiClientPageScope = SduiCoreSystem.getSduiClientPageScope

local gameVote = DiscoveryAnalytics.Events.gameVote
local getSduiPageEntrySnackbarStore = require(ServerDrivenUiParent.SduiSharedUtilities).getSduiPageEntrySnackbarStore

local GetFFlagEdpPlayerFeedbackEnabled = SharedFlags.GetFFlagEdpPlayerFeedbackEnabled
local FFlagLuaAppAddUniverseIdToEngagementEvents = SharedFlags.FFlagLuaAppAddUniverseIdToEngagementEvents

local function convertBooleanToVoteForAnalytics(bool1: boolean?): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return if bool1 == true then "UpVoted" elseif bool1 == false then "DownVoted" else "NotVoted"
end

local function SduiToggleExperienceVoteAction(arg1, _, arg2, _)
    local actionParams = if arg1 then arg1.actionParams or nil else nil

    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.ToggleExperienceVote,
                message = "Missing action params"
            },
            arg2.appPage
        )
        return
    end

    local universeId = actionParams.universeId
    local voteDirection = actionParams.voteDirection
    local placeId = actionParams.placeId

    if universeId == nil or typeof(universeId) ~= "string" or voteDirection == nil or typeof(voteDirection) ~= "boolean" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.ToggleExperienceVote,
                message = "Missing universeId or voteDirection"
            },
            arg2.appPage
        )
        return
    end

    local ctx = actionParams.ctx or ""

    local votesStore = Game.getVotesStore(false)

    local var1 = votesStore.getUserVote(universeId).data(false)
    local userVote = if var1 then var1.userVote else nil

    if userVote == voteDirection then
        voteDirection = nil
    end

    local userId = Players.LocalPlayer and Players.LocalPlayer.UserId
    gameVote({
        uid = tostring(userId),
        placeId = tostring(placeId),
        vote = convertBooleanToVoteForAnalytics(voteDirection),
        prevVote = convertBooleanToVoteForAnalytics(userVote),
        targetId = if FFlagLuaAppAddUniverseIdToEngagementEvents then universeId else nil
    }, ctx)

    if GetFFlagEdpPlayerFeedbackEnabled() and placeId then
        Game.getUserVoteFeedbackMetadataStore(false).clearItem(placeId)

        if arg2.configKey then
            getSduiClientPageScope(arg2.configKey).set("showPlayerFeedback", false)
        end
    end

    local var2 = votesStore.updateUserVote(universeId, voteDirection)

    local tbl1 = {}
    tbl1.dispose = Signals.createEffect(function(arg3)
        local var3 = var2(arg3)
        if var3 == nil then
            return
        end

        if var3.type == "error" then
            local configKey = arg2.configKey
            if configKey then
                local str1 = "Feature.Toast.VoteError.Default"
                local reasonForNotVoteable = var3.reasonForNotVoteable
                if reasonForNotVoteable == "PlayGame" then
                    str1 = "Feature.Toast.VoteError.PlayGame"
                elseif reasonForNotVoteable == "FloodCheckThresholdMet" then
                    str1 = "Feature.Toast.VoteError.FloodCheckThresholdMet"
                elseif reasonForNotVoteable == "AssetNotVoteable" then
                    str1 = "Feature.Toast.VoteError.AssetNotVoteable"
                end

                local title = arg2.dependencies.localization:Format(str1)
                getSduiPageEntrySnackbarStore().show(configKey, { title = title, icon = Foundation.Enums.IconName.TriangleExclamation })
            end
        elseif var3.type == "success" then
            local userVote2 = var3.userVote
            if GetFFlagEdpPlayerFeedbackEnabled() and userVote2 ~= nil and placeId then
                Game.getUserVoteFeedbackMetadataStore(false).getAndFetchUserVoteFeedbackMetadata(placeId)

                if arg2.configKey then
                    getSduiClientPageScope(arg2.configKey).set("showPlayerFeedback", true)
                end
            end
        end

        local dispose = tbl1.dispose
        if dispose then
            dispose()
            tbl1.dispose = nil
        end
    end)
end

return SduiToggleExperienceVoteAction
