-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local Http = require(SquadsParent.Http)
local LocalStorageKey = require(SquadsParent.LocalStorage).Enums.LocalStorageKey
local Promise = require(SquadsParent.Promise)

local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")

local Enums = require(SquadsParent.SquadsCore.Enums)
local _Types = require(SquadsParent.SquadsCore.Types)
local dependencies = require(Squads.dependencies)

local Cryo = dependencies.Cryo
local NetworkingSquads = dependencies.NetworkingSquads
local RoduxSquads = dependencies.RoduxSquads
local SquadExperienceInviteSource = Enums.SquadExperienceInviteSource
local EventNames = require(SquadsParent.SquadsCore.EventNames)
local SquadPromptType = Enums.SquadPromptType
local encodeSquadMembers = require(SquadsParent.SquadsCore.encodeSquadMembers)

local GetSquadExperienceInviteStore = require(SquadsParent.SquadsCore.Stores).GetSquadExperienceInviteStore

local FFlagEncodeSquadMembersUpdated = require(SquadsParent.SquadsCore.Flags).FFlagEncodeSquadMembersUpdated
local FFlagEnableSquadRegroupExperimentation = dependencies.SharedFlags.FFlagEnableSquadRegroupExperimentation

local FFlagUseSignalsForSquadExperienceInviteStatus = dependencies.SharedFlags.FFlagUseSignalsForSquadExperienceInviteStatus
local LuckyRecommendationExperimentation = dependencies.SocialExperiments.LuckyRecommendationExperimentation

local FFlagEnablePrivatePartyStartJoin = dependencies.SharedFlags.FFlagEnablePrivatePartyStartJoin
local SquadExperienceInviteType = Enums.SquadExperienceInviteType
local GetExperienceInviteRetryAfterStore = require(SquadsParent.SquadsCore.Stores).GetExperienceInviteRetryAfterStore

local function getRetryAfterSeconds(arg1): number? -- Luacid: unused: defined but never referenced
    local var1 = tonumber(if type(arg1) == "table" then arg1.retryAfterSeconds else nil)
    return if var1 and not (var1 <= 0) then var1 else nil
end

local var1 = nil

return function(placeId: string, arg1, str1: string?, inviteType)
    return function(arg2)
        local state = arg2:getState()

        local currentSquad = state.Squad and state.Squad.Squad and state.Squad.Squad.currentSquad

        local squadId = currentSquad and currentSquad.squadId
        local parentChannelId = currentSquad and currentSquad.parentChannelId
        local var2 = not (currentSquad and currentSquad.members) and {} or currentSquad.members

        if not FFlagEncodeSquadMembersUpdated then
            encodeSquadMembers = function(_)
                local input = Cryo.List.map(var2, function(arg3)
                    return arg3.userId
                end)

                local success, result = pcall(function(): string
                    return HttpService:JSONEncode(input)
                end)

                return if success then result else "[]"
            end
        end

        local squadMembers = encodeSquadMembers(var2)

        if not squadId then
            return Promise.resolve()
        end

        local success, result = pcall(function(): string
            return AppStorageService:GetItem(LocalStorageKey.BrowserTrackerId)
        end)
        local voteIdentifier = if success then result else ""

        local function updateCurrentExperienceInviteStatus(isExperienceInvitePending: boolean)
            if FFlagUseSignalsForSquadExperienceInviteStatus then
                GetSquadExperienceInviteStore(false).currentExperienceInviteStatusUpdated(isExperienceInvitePending)
                return
            end
            arg2:dispatch(
                RoduxSquads.Actions.CurrentExperienceInviteStatusUpdated({ isExperienceInvitePending = isExperienceInvitePending })
            )
        end

        local function CreateExperienceInvite(callback)
            if var1 then
                task.cancel(var1)
                var1 = nil
            end

            updateCurrentExperienceInviteStatus(true)

            local tbl1 = {
                membershipEntityId = squadId,
                placeId = placeId,
                voteIdentifier = voteIdentifier
            }
            local source = if FFlagEnableSquadRegroupExperimentation or LuckyRecommendationExperimentation.getLuckyRecommendationEnabled() then str1 or SquadExperienceInviteSource.Default else nil

            if source then
                tbl1.source = source
            end

            if FFlagEnablePrivatePartyStartJoin then
                tbl1.inviteType = inviteType or SquadExperienceInviteType.PlayWithPartyInPublicServer
            end

            return arg2:dispatch(NetworkingSquads.CreateExperienceInvite.API(tbl1)):andThen(function(arg3)
                local experienceInviteId = arg3.responseBody.experienceInviteId
                arg1.fireSquadAnalytics(EventNames.SquadExperienceInviteApiCall, {
                    parentChannelId = parentChannelId,
                    experienceInviteId = experienceInviteId,
                    isSuccess = true,
                    invitationPlaceId = tonumber(placeId),
                    squadMembers = squadMembers,
                    squadMembersCount = #var2
                })

                var1 = task.delay(2, function()
                    updateCurrentExperienceInviteStatus(false)
                    var1 = nil
                end)
                return experienceInviteId
            end):catch(function(tbl2)
                updateCurrentExperienceInviteStatus(false)

                local body = tbl2.Body
                local success2, result2 = pcall(function()
                    return HttpService:JSONDecode(body)
                end)

                local errorType = if success2 then result2.errorType else nil
                local fireSquadAnalytics = arg1.fireSquadAnalytics
                local squadExperienceInviteApiCall = EventNames.SquadExperienceInviteApiCall
                local tbl3 = {
                    parentChannelId = parentChannelId,
                    isSuccess = false,
                    errorMessage = errorType,
                    errorType = if tbl2.StatusCode then tostring(tbl2.StatusCode) else nil,
                    invitationPlaceId = tonumber(placeId),
                    squadMembers = squadMembers,
                    squadMembersCount = #var2
                }
                fireSquadAnalytics(squadExperienceInviteApiCall, tbl3)

                if tbl2.StatusCode ~= Http.StatusCodes.CONFLICT then
                    arg1.setSquadPrompt(arg2, { promptType = SquadPromptType.Error })

                    return
                end

                local var7

                if success2 then
                    local var8 = tonumber(if type(result2) == "table" then result2.retryAfterSeconds else nil)
                    var7 = var8 and not (var8 <= 0) and var8 or nil
                else
                    var7 = nil
                end
                if var7 then
                    GetExperienceInviteRetryAfterStore(false).block(squadId, var7)
                    return
                end
                arg1.setSquadPrompt(arg2, {
                    onConfirm = function()
                        callback(callback)
                    end,
                    promptType = SquadPromptType.InvitedToExperience
                })
            end)
        end

        return CreateExperienceInvite(CreateExperienceInvite)
    end
end
