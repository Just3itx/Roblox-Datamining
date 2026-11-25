-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local MessageBusService = game:GetService("MessageBusService")

local Constants = require(SquadsCore.Common.Constants)
local Logger = require(SquadsCore.Logger)
local RoduxSquads = require(SquadsCore.RoduxSquads)

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local SquadState = require(SquadsCore.Enums.SquadState)
local SquadViewFlags = require(SquadsCore.Components.SquadExternalContractProvider.SquadViewFlags)
local fetchActiveSquad = require(SquadsCore.Thunks.fetchActiveSquad)
local serializeTable = require(SquadsCore.Utils.serializeTable)
local useSquadState = require(SquadsCore.Hooks.useSquadState)

local React = require(SquadsCoreParent.React)
local RealtimeDelivery = require(SquadsCoreParent.RealtimeDelivery)
local LuauPolyfill = require(SquadsCoreParent.LuauPolyfill)
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalUserId = require(SquadsCoreParent.RobloxAppHooks).useLocalUserId

local clearInterval = LuauPolyfill.clearInterval
local clearTimeout = LuauPolyfill.clearTimeout
local setInterval = LuauPolyfill.setInterval
local setTimeout = LuauPolyfill.setTimeout

local num1 = game:DefineFastInt("ActiveSquadPollingCardIntervalSeconds", 30)
local num2 = game:DefineFastInt("ActiveSquadPollingLobbyIntervalSeconds", 60)
local num3 = game:DefineFastInt("ActiveSquadPollingIdleIntervalSeconds", 120)
local num4 = game:DefineFastInt("ActiveSquadInitPollingDelaySeconds", 3)

local messageId = MessageBusService:GetMessageId("Realtime", "appResume")

return function(arg1)
    local var1 = useDispatch()
    local num5 = tonumber(useLocalUserId()) or 0
    local var2, var3 = React.useState(false)

    local var4 = React.useContext(SquadExternalContractContext).useSquadViewFlags()
    local var5 = useSquadState()

    local var6, var7 = React.useState(-1)

    React.useEffect(function()
        var3(false)

        local var8 = if arg1.currentSquadId == "" then nil else setTimeout(function()
            var1(fetchActiveSquad())
            var3(true)
        end, num4 * 1000)

        return function()
            if var8 then
                clearTimeout(var8)
            end
        end
    end, { arg1.currentSquadId })

    React.useEffect(function()
        local var8 = var4
        local squadSystemMessage = SquadViewFlags.SquadSystemMessage
        local var9 = if bit32.band(var8, squadSystemMessage) ~= 0 then num1 elseif bit32.band(var4, SquadViewFlags.SquadLobby) ~= 0 then num2 else num3

        local var10 = if var2 and arg1.currentSquadId ~= "" then setInterval(function()
            var1(fetchActiveSquad())
        end, var9 * 1000) else nil

        return function()
            if var10 then
                clearInterval(var10)
            end
        end
    end, {
        arg1.currentSquadId,
        var4,
        var6,
        var2
    })

    local var8 = React.useCallback(function(num6: number)
        if var6 < num6 then
            var1(fetchActiveSquad()):andThen(function()
                var7(num6)
            end)
        end
    end, {
        var1,
        fetchActiveSquad,
        var7,
        var6
    })

    RealtimeDelivery.useRealtimeNamespace(Constants.COMMUNICATION_CHANNEL_RTN_NAMESPACE, function(arg2)
        if arg2.ChannelType ~= Constants.SQUAD_CHANNEL_TYPE then
            return
        end

        Logger:debug(
            "Squad RTN received. Detail: {}, CurrentSquadId: {}, LocalUserId: {}",
            serializeTable(arg2),
            arg1.currentSquadId,
            num5
        )

        if arg1.currentSquadId == arg2.ChannelId then
            if arg2.Type == Constants.CHANNEL_LOCAL_USER_REMOVED_DETAIL_TYPE or arg2.Type == Constants.CHANNEL_DELETED_DETAIL_TYPE then
                var1(RoduxSquads.Actions.CurrentSquadUpdated(nil))
                return
            end

            if arg2.Type == Constants.CHANNEL_PARTICIPANT_ADDED_DETAIL_TYPE
                or arg2.Type == Constants.CHANNEL_PARTICIPANT_REMOVED_DETAIL_TYPE
                or arg2.Type == Constants.CHANNEL_UPDATED_DETAIL_TYPE
                or arg2.Type == Constants.CHANNEL_PARTICIPANT_INVITED_DETAIL_TYPE
            then
                var8(arg2.SequenceNumber)
            end

            return
        end
        if var5 == SquadState.Initializing then
            return
        end

        local actor = arg2.Actor

        if actor then
            if arg2.Actor.Type == "User" then
                actor = arg2.Actor.Id == tostring(num5)
            else
                actor = false
            end
        end
        if arg2.Type == Constants.CHANNEL_CREATED_DETAIL_TYPE and actor then
            var8(arg2.SequenceNumber)
        elseif arg2.Type == Constants.CHANNEL_LOCAL_USER_ADDED_DETAIL_TYPE then
            var8(arg2.SequenceNumber)
        end
    end, {
        arg1.currentSquadId,
        var1,
        num5,
        var8,
        var5
    })

    React.useEffect(function()
        local var9 = MessageBusService:Subscribe(messageId, function()
            if arg1.currentSquadId ~= "" then
                var1(fetchActiveSquad())
            end
        end, false, true)
        return function()
            if var9 then
                var9:Disconnect()
            end
        end
    end, { arg1.currentSquadId, var1 })

    return nil
end
