-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local builderIcon = require(scriptParentParent.Common.builderIcon)
local SharedFlags = require(scriptParentParentParent.SharedFlags)
local FFlagEnableBlackbirdCheck = SharedFlags.FFlagEnableBlackbirdCheck
local FFlagHidePremiumIconography = SharedFlags.FFlagHidePremiumIconography

local tbl1 = {
    [Enum.FriendStatus.Friend] = builderIcon("two-people", "Filled"),
    [Enum.FriendStatus.FriendRequestReceived] = builderIcon("person-clock", "Filled")
}
local var1 = builderIcon("circle-slash")
local var2 = builderIcon("hammer-code", "Filled")
local var3 = builderIcon("person-check", "Filled")
local var4 = builderIcon("premium")

local function getSocialIcon(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 then
        if arg1.isBlocked then
            return var1
        end

        return tbl1[arg1.friendStatus]
    end

    return nil
end

local function getPlayerBadgeIcon(arg1, arg2, arg3, arg4)
    if not arg1 then
        return nil
    end

    local socialIcon = getSocialIcon(arg4)

    if socialIcon then
        return socialIcon
    end

    if arg3 and arg3.isPlaceOwner then
        return var2
    end

    if arg1.CustomPlayerIcons and arg1.CustomPlayerIcons[arg2.UserId] then
        return arg1.CustomPlayerIcons[arg2.UserId]
    end

    if arg3 and arg3.specialGroupIcon then
        return arg3.specialGroupIcon
    end

    if arg4 and arg4.isFollowing then
        return var3
    end

    local bool1 = arg2.MembershipType == Enum.MembershipType.Premium
    if FFlagEnableBlackbirdCheck then
        if game:GetEngineFeature("ReadHasRobloxSubscriptionLua") and arg2.HasRobloxSubscription then
            return arg1.SubscriptionIcon
        end
        if not FFlagHidePremiumIconography and bool1 then
            return var4
        end
    elseif bool1 then
        return var4
    end

    return nil
end

return getPlayerBadgeIcon
