-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCardsParent = script:FindFirstAncestor("SocialCards").Parent

local React = require(SocialCardsParent.React)
local RealtimeDelivery = require(SocialCardsParent.RealtimeDelivery)
local Signals = require(SocialCardsParent.Signals)
local SignalsReact = require(SocialCardsParent.SignalsReact)

local CallCardStatus = require(script.Parent.CallCardStatus)
local getCallCard = require(script.Parent.getCallCard)
local _mapCallCard = require(script.Parent.mapCallCard)
local parseCallCard = require(script.Parent.parseCallCard)

local GetFriendsCallingStore = require(SocialCardsParent.FriendsCalling.GetFriendsCallingStore)

local useSignalState = SignalsReact.useSignalState

local tbl1 = {
    [CallCardStatus.Answered] = true,
    [CallCardStatus.Declined] = true,
    [CallCardStatus.Cancelled] = true,
    [CallCardStatus.Missed] = true
}

local FriendsCallingPhase = Enum.FriendsCallingPhase

local tbl2 = {
    [FriendsCallingPhase.Ringing] = CallCardStatus.Ringing,
    [FriendsCallingPhase.Active] = CallCardStatus.Ongoing,
    [FriendsCallingPhase.Ended] = CallCardStatus.Ended
}

local function sameSnapshot(tbl3, tbl4): boolean
    if tbl3 == nil or tbl4 == nil then
        return tbl3 == tbl4
    end

    return tbl3.callId == tbl4.callId
        and tbl3.status == tbl4.status
        and tbl3.otherCallId == tbl4.otherCallId
        and tbl3.initiatorUserId == tbl4.initiatorUserId
end

local function useCallCard(arg1)
    local callId = arg1.callId
    local var1, var2 = React.useState(nil)
    local var3 = React.useRef(0)
    local var4 = React.useRef(nil)

    if var1 == nil or var1.callId ~= callId then
        var1 = arg1
    end

    local var5 = React.useRef(var1)
    var5.current = var1

    local var6 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local var6 = nil
            local callId2 = nil
            for _, value in GetFriendsCallingStore(arg2).getCalls(arg2) do
                if value.callId == callId then
                    var6 = value
                elseif value.callId ~= "" and callId2 == nil then
                    callId2 = value.callId
                end
            end
            return {
                callId = callId,
                status = if var6 == nil then nil else tbl2[var6.phase],
                otherCallId = callId2,
                initiatorUserId = if var6 == nil then nil else var6.initiatorUserId
            }
        end, sameSnapshot)
    end, { callId })
    local var7 = useSignalState(var6)
    if var7.callId ~= callId then
        var7 = nil
    end

    local status = if var7 == nil then nil else var7.status

    local var8 = React.useCallback(function()
        if var6(false).status ~= nil or tbl1[var5.current.status] then
            return
        end
        local var8 = var3
        var8.current += 1
        local current = var3.current
        getCallCard(callId, function(arg2)
            if current ~= var3.current then
                return
            end
            var2(parseCallCard.applyCallCardRefresh(arg1, arg2))
        end)
    end, { callId, var6, arg1 })

    React.useEffect(function()
        return function()
            local var9 = var3
            var9.current += 1
        end
    end, {})

    React.useEffect(function()
        local current = if status == nil then nil else callId

        if var4.current == callId and current == nil then
            var8()
        end
        var4.current = current
    end, { callId, status, var8 })

    RealtimeDelivery.useRealtimeNamespace("CallV2", function(arg2)
        if arg2.type == "CallCardUpdated" and arg2.callId == callId then
            var8()
        end
    end, { callId, var8 })

    RealtimeDelivery.useRealtimeConnectionStateChanged("CallV2", function(connectionState, arg2)
        if connectionState == Enum.ConnectionState.Connected and arg2 then
            var8()
        end
    end, { var8 })

    local otherCallId = if var7 == nil then nil else var7.otherCallId
    local initiatorUserId = if var7 == nil then nil else var7.initiatorUserId
    local localPlayer = game:GetService("Players").LocalPlayer
    local isInitiator = if initiatorUserId ~= nil and initiatorUserId ~= 0 and localPlayer ~= nil then localPlayer.UserId == initiatorUserId else var1.isInitiator

    if status == nil then
        return var1, otherCallId, false
    end

    return {
        callId = var1.callId,
        isInitiator = isInitiator,
        status = status,
        durationSeconds = nil,
        enableJoin = var1.enableJoin
    }, otherCallId, true
end

return useCallCard
