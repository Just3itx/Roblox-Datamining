-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createFakeSignal()
    local tbl1 = ({})
    local num1 = 0
    local module = ({})

    function module.Connect(_, arg1)
        num1 += 1
        local num2 = num1
        tbl1[num2] = arg1
        return {
            Disconnect = function()
                tbl1[num2] = nil
            end
        }
    end

    function module.fire(...)
        for _, value in table.clone(tbl1) do
            value(...)
        end
    end

    return module
end

local function createFakeInstance(className: string, tbl1)
    local tbl2 = {}
    local changed = createFakeSignal()
    local childAdded = createFakeSignal()
    local childRemoved = createFakeSignal()

    local var1 = table.clone(tbl1)
    var1.ClassName = className
    var1.Changed = changed
    var1.ChildAdded = childAdded
    var1.ChildRemoved = childRemoved

    function var1.GetChildren(_)
        return table.clone(tbl2)
    end

    function var1.addChild(arg1)
        table.insert(tbl2, arg1)
        childAdded.fire(arg1)
    end

    function var1.removeChild(arg1)
        local var2 = table.find(tbl2, arg1)
        if var2 then
            table.remove(tbl2, var2)
            childRemoved.fire(arg1)
        end
    end

    function var1.setProperty(str1: string, arg1)
        var1[str1] = arg1
        changed.fire(str1)
    end

    return var1
end

local FriendsCallingEndReason = Enum.FriendsCallingEndReason
local FriendsCallingParticipantStatus = Enum.FriendsCallingParticipantStatus
local FriendsCallingPhase = Enum.FriendsCallingPhase

local function enumItem(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return { Name = str1 }
end

return {
    createFakeCall = function(tbl1)
        local tbl2 = {
            CallId = "call-1",
            Phase = FriendsCallingPhase.Active,
            InitiatorUserId = 1,
            EndReason = FriendsCallingEndReason.None,
            Volume = 1,
            IsDeafened = false,
            ConversationId = 0
        }

        if tbl1 then
            for value, value2 in tbl1 do
                tbl2[value] = value2
            end
        end
        return (createFakeInstance("FriendsCallingInstance", tbl2))
    end,
    createFakeInstance = createFakeInstance,
    createFakeParticipant = function(userId: number, tbl1)
        local tbl2 = {
            UserId = userId,
            Status = FriendsCallingParticipantStatus.Joined,
            LeaveReason = enumItem("None"),
            Volume = 1,
            IsLocalMuted = false,
            IsSpeaking = false,
            Error = enumItem("None")
        }
        if tbl1 then
            for value, value2 in tbl1 do
                tbl2[value] = value2
            end
        end
        return (createFakeInstance("FriendsCallingParticipant", tbl2))
    end,
    enumItem = enumItem
}
