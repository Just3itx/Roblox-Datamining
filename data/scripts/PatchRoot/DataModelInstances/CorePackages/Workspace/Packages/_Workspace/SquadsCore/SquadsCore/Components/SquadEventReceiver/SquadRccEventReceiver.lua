-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local HttpService = game:GetService("HttpService")

local React = require(SquadsCoreParent.React)
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch

local Constants = require(SquadsCore.Common.Constants)
local EventNames = require(SquadsCore.Analytics.EventNames)

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local SquadRccEventManager = require(SquadsCore.ServiceManager.SquadRccEventManager)
local actOnPartyNudge = require(SquadsCore.Thunks.actOnPartyNudge)
local createConversation = require(SquadsCore.Thunks.createConversation)
local encodeUserIds = require(SquadsCore.Common.encodeUserIds)

return function(tbl1)
    local squadContext = React.useContext(SquadExternalContractContext)
    local var2 = squadContext.useIsChatEnabled()
    local var3 = squadContext.useIsLoadingChatSettings()

    React.useEffect(function()
        SquadRccEventManager:fireSquadChangeEvent(tbl1.currentSquadId, var2)
    end, { tbl1.currentSquadId, var2 })

    local var4 = useDispatch()
    local var5 = React.useRef({})

    local var6 = React.useCallback(function()
        for _, value in ipairs(var5.current) do
            local partySourceType = value.partySourceType
            local data = value.data
            if partySourceType ~= "PartyNudge" or data.nudgeType ~= Constants.ONE_TO_ONE_NUDGE_IN_EXPERIENCE_TYPE then
                continue
            end

            local partyAttemptId = HttpService:GenerateGUID(false)
            squadContext.fireSquadAnalytics(EventNames.SquadCreateOrJoinFromRCC, {
                partySourceType = partySourceType,
                nudgeType = data.nudgeType,
                nudgeId = data.nudgeId,
                partyAttemptId = partyAttemptId,
                inviteeUserIds = encodeUserIds({ data.inviteeId })
            })

            local var6 = var4
            local var7 = createConversation
            local tbl2 = {
                conversationType = "one_to_one",
                userIds = { tostring(data.inviteeId) },
                source = "createOrJoinPartyRemoteEvent",
                squadContext = squadContext,
                onSuccessCallback = 0,
                onErrorCallback = 0
            }

            function tbl2.onSuccessCallback(arg1)
                var4(
                    actOnPartyNudge(
                        if tbl1.currentSquadId == "" then Constants.ACCEPT_START_PARTY_REQUEST_ACTION else Constants.REJECT_START_PARTY_REQUEST_ACTION,
                        data.nudgeId,
                        false,
                        squadContext.setSquadPrompt,
                        squadContext.fireSquadAnalytics,
                        squadContext.squadLocation,
                        var2,
                        partyAttemptId,
                        arg1
                    )
                )
            end

            function tbl2.onErrorCallback()
                var4(
                    actOnPartyNudge(
                        Constants.REJECT_START_PARTY_REQUEST_ACTION,
                        data.nudgeId,
                        false,
                        squadContext.setSquadPrompt,
                        squadContext.fireSquadAnalytics,
                        squadContext.squadLocation,
                        var2,
                        partyAttemptId
                    )
                )
            end

            var6(var7(tbl2))
        end

        var5.current = {}
    end, {
        var2,
        squadContext,
        squadContext.setSquadPrompt,
        squadContext.fireSquadAnalytics,
        squadContext.squadLocation
    })

    React.useEffect(function()
        if not var3 then
            if var2 then
                var6()
            else
                var5.current = {}
            end
        end

        local connection = nil
        coroutine.wrap(function()
            connection = RobloxReplicatedStorage:WaitForChild("CreateOrJoinParty", math.huge).OnClientEvent:Connect(function(partySourceType, arg1)
                if var3 then
                    table.insert(var5.current, { partySourceType = partySourceType, data = arg1 })
                elseif var2 then
                    var6()
                end
            end)
        end)()

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { var3, var2, var6 })

    return nil
end
