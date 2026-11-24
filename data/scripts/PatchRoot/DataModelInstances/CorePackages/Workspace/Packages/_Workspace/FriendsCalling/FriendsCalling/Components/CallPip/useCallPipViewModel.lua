-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCalling = script:FindFirstAncestor("FriendsCalling")
local FriendsCallingParent = FriendsCalling.Parent

local Players = game:GetService("Players")
local React = require(FriendsCallingParent.React)
local SignalsReact = require(FriendsCallingParent.SignalsReact)

local _CallParticipantCard = require(FriendsCalling.Components.CallParticipant.CallParticipantCard)
local GetFriendsCallingStore = require(FriendsCalling.Stores.GetFriendsCallingStore)
local Logger = require(FriendsCalling.Logger)

local FriendsCallingParticipantStatus = Enum.FriendsCallingParticipantStatus
local FriendsCallingPhase = Enum.FriendsCallingPhase

local useSignalState = SignalsReact.useSignalState

local tbl1 = {
    userId = 0,
    name = "",
    statusText = nil,
    isMuted = false,
    isSpeaking = false,
    isDimmed = true,
    showStatusAnimation = false
}

local function isBeingRung(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.status == FriendsCallingParticipantStatus.Ringing
end

local function getSelfUserId(): number -- Luacid: Inlined by compiler; 3 call sites recovered
    local localPlayer = Players.LocalPlayer
    return if localPlayer then localPlayer.UserId else 0
end

local function isRingingForSomeoneElse(arg1): boolean -- Luacid: unused: defined but never referenced
    local initiatorUserId = arg1.initiatorUserId
    return arg1.phase == FriendsCallingPhase.Ringing and initiatorUserId ~= 0 and initiatorUserId ~= getSelfUserId()
end

local function getOtherParticipant(arg1)
    local selfUserId = getSelfUserId()
    local var1 = nil
    for _, participant in arg1.participants do
        if participant.userId == selfUserId then
            continue
        end

        if isBeingRung(participant) then
            var1 = participant
            break
        end

        var1 = participant
    end

    return var1
end

local function toCard(arg1)
    local otherParticipant = getOtherParticipant(arg1)
    if otherParticipant == nil then
        return if arg1.phase == FriendsCallingPhase.Ringing then {
            userId = 0,
            name = "",
            statusText = "Ringing",
            isMuted = false,
            isSpeaking = false,
            isDimmed = true,
            showStatusAnimation = true
        } else tbl1
    end
    local bool1 = arg1.phase == FriendsCallingPhase.Ended
    local bool2 = otherParticipant.status == FriendsCallingParticipantStatus.Invited
    local bool3 = arg1.phase == FriendsCallingPhase.Ringing
    return {
        userId = otherParticipant.userId,
        name = tostring(otherParticipant.userId),
        statusText = if bool3 then "Ringing" else nil,
        isMuted = otherParticipant.isLocalMuted,
        isSpeaking = otherParticipant.isSpeaking,
        isDimmed = bool3 or bool1 or bool2,
        showStatusAnimation = bool3
    }
end

local function useCallPipViewModel()
    local friendsCallingStore = GetFriendsCallingStore(false)
    local var1 = useSignalState(friendsCallingStore.getWindowView)
    local var2 = useSignalState(friendsCallingStore.getCall)
    local expandCount = useSignalState(friendsCallingStore.getExpandCount)
    local var4 = React.useRef(nil)
    local at = nil
    if var2 and var2.phase == FriendsCallingPhase.Active then
        local current = var4.current
        local var3 = (current == nil or current.callId ~= var2.callId) and {
            callId = var2.callId,
            at = os.clock()
        } or current
        if current ~= var3 then
            var4.current = var3
        end
        at = var3.at
    end

    local participant = if var2 then toCard(var2) else tbl1
    local hasCall = var1.hasCall

    if hasCall then
        local bool1

        if var2 == nil then
            bool1 = false
        else
            local initiatorUserId = var2.initiatorUserId
            if var2.phase == FriendsCallingPhase.Ringing and initiatorUserId ~= 0 then
                bool1 = initiatorUserId ~= getSelfUserId()
            else
                bool1 = false
            end
        end

        hasCall = not bool1
    end

    local callId = var2 and var2.callId or ""
    local var6 = if var2 then var2.phase.Name else ""
    React.useEffect(function()
        Logger:debug(
            "{} - pip applied: enabled={}, session={}, callId={}, phase={}, connectedAt={}",
            script.Name,
            tostring(hasCall),
            var1.session,
            callId,
            var6,
            tostring(at)
        )
    end, {
        callId,
        at,
        hasCall,
        var6,
        var1.session
    })

    return {
        enabled = hasCall,
        session = var1.session,
        expandCount = expandCount,
        connectedAt = at,
        callId = if var2 then var2.callId else nil,
        participant = participant
    }
end

return useCallPipViewModel
