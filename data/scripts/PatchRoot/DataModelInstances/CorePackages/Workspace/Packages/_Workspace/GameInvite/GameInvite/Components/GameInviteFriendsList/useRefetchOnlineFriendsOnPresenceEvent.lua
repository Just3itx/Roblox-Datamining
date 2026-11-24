-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent
local React = require(GameInviteParent.React)
local DataHydration = require(GameInviteParent.DataHydration)
local useRealtimeNamespace = require(GameInviteParent.RealtimeDelivery).useRealtimeNamespace
local UserModel = require(GameInviteParent.UserLib).Models.UserModel

local _GameInviteFriendRow = require(script.Parent.GameInviteFriendRow)
local FIntGameInviteOnlineFriendsRefetchThrottleSec = require(GameInvite.Flags.FIntGameInviteOnlineFriendsRefetchThrottleSec)

local function isOfflineReport(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local presenceReport = tbl1.PresenceReport
    return not (presenceReport == nil) and presenceReport.userPresenceType == 0
end

local function hasListedFriendComeOnline(tbl1, current)
    for _, value in tbl1 do
        local var1 = current[tostring(value.UserId)]

        if var1 ~= nil and var1.presence == UserModel.PresenceType.OFFLINE and not isOfflineReport(value) then
            return true
        end
    end
    return false
end

local function useRefetchOnlineFriendsOnPresenceEvent(current)
    local var1 = React.useRef(current)
    var1.current = current

    local var2 = React.useRef(os.clock())
    local var3 = React.useRef(nil)

    local var4 = React.useCallback(function()
        var3.current = nil
        var2.current = os.clock()
        DataHydration.Friends.FriendsStore.get().RefetchOnlineFriends()
    end, {})

    useRealtimeNamespace("PresenceBulkNotifications", function(tbl1)
        if type(tbl1) ~= "table" or var3.current ~= nil or not hasListedFriendComeOnline(tbl1, var1.current) then
            return
        end

        local var5 = FIntGameInviteOnlineFriendsRefetchThrottleSec - (os.clock() - var2.current)
        if var5 <= 0 then
            var4()
            return
        end
        var3.current = task.delay(var5, var4)
    end, {})

    React.useEffect(function()
        return function()
            local current2 = var3.current
            if current2 ~= nil then
                task.cancel(current2)
                var3.current = nil
            end
        end
    end, {})
end

return useRefetchOnlineFriendsOnPresenceEvent
