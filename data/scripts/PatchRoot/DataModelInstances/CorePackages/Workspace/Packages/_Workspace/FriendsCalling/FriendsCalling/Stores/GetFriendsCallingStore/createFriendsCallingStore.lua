-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCalling = script:FindFirstAncestor("FriendsCalling")
local FriendsCallingParent = FriendsCalling.Parent

local Signals = require(FriendsCallingParent.Signals)

local Logger = require(FriendsCalling.Logger)

local _FriendsCallingEndReason = Enum.FriendsCallingEndReason
local _FriendsCallingParticipantStatus = Enum.FriendsCallingParticipantStatus
local _FriendsCallingPhase = Enum.FriendsCallingPhase

local function readParticipant(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        userId = arg1.UserId,
        status = arg1.Status,
        leaveReason = arg1.LeaveReason.Name,
        volume = arg1.Volume,
        isLocalMuted = arg1.IsLocalMuted,
        isSpeaking = arg1.IsSpeaking,
        error = arg1.Error.Name
    }
end

local function readCall(instance)
    local participants = {}
    for _, child in instance:GetChildren() do
        if child.ClassName == "FriendsCallingParticipant" then
            table.insert(participants, readParticipant(child))
        end
    end

    return {
        callId = instance.CallId,
        phase = instance.Phase,
        initiatorUserId = instance.InitiatorUserId,
        endReason = instance.EndReason,
        volume = instance.Volume,
        isDeafened = instance.IsDeafened,
        conversationId = instance.ConversationId,
        participants = participants
    }
end

local function disconnectObservedCall(tbl1)
    for _, connection in tbl1.connections do
        connection:Disconnect()
    end
    for _, participantConnection in tbl1.participantConnections do
        participantConnection:Disconnect()
    end
end

return function(arg1)
    local getCalls, var2 = Signals.createSignal({})
    local getSession, var4 = Signals.createSignal(0)
    local num1 = 0
    local getExpandCount, var6 = Signals.createSignal(0)
    local getCall = Signals.createComputed(function(arg2)
        return getCalls(arg2)[1]
    end)
    local getCallId = Signals.createComputed(function(arg2)
        local var7 = getCall(arg2)
        return if var7 then var7.callId else nil
    end)
    local getHasCall = Signals.createComputed(function(arg2): boolean
        return getCall(arg2) ~= nil
    end)

    local getWindowView = Signals.createComputed(function(arg2)
        return {
            hasCall = getHasCall(arg2),
            session = getSession(arg2)
        }
    end)

    local tbl1 = {}
    local num2 = 0
    local num3 = 0
    local bool1 = false

    local function publish()
        local var7 = table.clone(tbl1)
        table.sort(var7, function(arg2, arg3): boolean
            return arg2.arrivalOrder < arg3.arrivalOrder
        end)

        local tbl2 = {}
        for _, value in var7 do
            table.insert(tbl2, (readCall(value.instance)))
        end
        local bool2 = #tbl2 > 0
        local bool3 = bool1 and not bool2
        bool1 = bool2

        var2(tbl2)
        if bool3 then
            num3 += 1
            var4(num3)
        end
        local var8 = tbl2[1]
        Logger:debug(
            "{} - published: hasCall={}, session={}, callId={}, phase={}, endReason={}, participants={}",
            script.Name,
            tostring(bool2),
            num3,
            var8 and var8.callId or "",
            if var8 then var8.phase.Name else "",
            if var8 then var8.endReason.Name else "",
            var8 and #var8.participants or 0
        )
    end

    local function unobserveCall(instance: Instance)
        for value, value2 in tbl1 do
            if value2.instance ~= instance then
                continue
            end

            Logger:debug("{} - unobserveCall: callId={}, phase={}", script.Name, instance.CallId or "", instance.Phase.Name)
            disconnectObservedCall(value2)
            table.remove(tbl1, value)
            publish()
            return
        end
    end

    local function observeCall(instance)
        for _, value in tbl1 do
            if value.instance == instance then
                return
            end
        end

        Logger:debug("{} - observeCall: callId={}, phase={}", script.Name, instance.CallId or "", instance.Phase.Name)
        num2 += 1
        local tbl2 = {
            instance = instance,
            arrivalOrder = num2,
            connections = {},
            participantConnections = {}
        }
        table.insert(tbl1, tbl2)

        local function observeParticipant(arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
            if arg2.ClassName == "FriendsCallingParticipant" and not tbl2.participantConnections[arg2] then
                tbl2.participantConnections[arg2] = arg2.Changed:Connect(function(str1: string)
                    Logger:debug(
                        "{} - child.Changed: property {}, userId={}, callId={}",
                        script.Name,
                        str1,
                        arg2.UserId,
                        instance.CallId or ""
                    )
                    publish()
                end)
            end
        end

        local function unobserveParticipant(arg2: Instance) -- Luacid: Inlined by compiler; 1 call site recovered
            local participantConnection = tbl2.participantConnections[arg2]
            if participantConnection then
                participantConnection:Disconnect()
                tbl2.participantConnections[arg2] = nil
            end
        end

        local connections = tbl2.connections
        local changed = instance.Changed

        table.insert(connections, changed:Connect(function(str1: string)
            Logger:debug(
                "{} - call.Changed: property {}, callId={}, phase={}",
                script.Name,
                str1,
                instance.CallId or "",
                instance.Phase.Name
            )
            publish()
        end))

        local connections2 = tbl2.connections
        local childAdded = instance.ChildAdded

        table.insert(connections2, childAdded:Connect(function(child: Instance)
            if child.ClassName == "FriendsCallingParticipant" then
                Logger:debug("{} - call.ChildAdded: userId={}, callId={}", script.Name, child.UserId, instance.CallId or "")
            end

            observeParticipant(child)
            publish()
        end))

        local connections3 = tbl2.connections
        local childRemoved = instance.ChildRemoved

        table.insert(connections3, childRemoved:Connect(function(child: Instance)
            if child.ClassName == "FriendsCallingParticipant" then
                Logger:debug("{} - call.ChildRemoved: userId={}, callId={}", script.Name, child.UserId, instance.CallId or "")
            end

            unobserveParticipant(child)
            publish()
        end))

        for _, child in instance:GetChildren() do
            observeParticipant(child)
        end

        publish()
    end

    Logger:debug("{} - created: watching {} for FriendsCallingInstance", script.Name, arg1.ClassName)

    local connection = arg1.ChildAdded:Connect(function(child: Instance)
        if child.ClassName == "FriendsCallingInstance" then
            observeCall(child)
        end
    end)
    local connection2 = arg1.ChildRemoved:Connect(function(child: Instance)
        if child.ClassName == "FriendsCallingInstance" then
            unobserveCall(child)
        end
    end)

    for _, child in arg1:GetChildren() do
        if child.ClassName == "FriendsCallingInstance" then
            observeCall(child)
        end
    end

    return {
        getCalls = getCalls,
        getCall = getCall,
        getCallId = getCallId,
        getHasCall = getHasCall,
        getSession = getSession,
        getWindowView = getWindowView,
        getExpandCount = getExpandCount,
        expand = function()
            num1 += 1
            var6(num1)
        end,
        cleanup = function()
            Logger:debug("{} - store cleanup", script.Name)
            connection:Disconnect()
            connection2:Disconnect()
            for _, value in tbl1 do
                disconnectObservedCall(value)
            end
            table.clear(tbl1)
            local bool2 = bool1
            bool1 = false
            var2({})
            if bool2 then
                num3 += 1
                var4(num3)
            end
        end
    }
end
