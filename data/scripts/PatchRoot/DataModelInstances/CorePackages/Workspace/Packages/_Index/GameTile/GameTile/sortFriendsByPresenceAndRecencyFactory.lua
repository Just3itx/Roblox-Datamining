-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local UserModel = require(GameTileParent.UserLib).Models.UserModel

local tbl1 = {
    [UserModel.PresenceType.IN_GAME] = 3,
    [UserModel.PresenceType.ONLINE] = 2,
    [UserModel.PresenceType.IN_STUDIO] = 1,
    [UserModel.PresenceType.OFFLINE] = 0
}

local function useLastOnlineForSort(lastOnline, lastOnline2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return typeof(lastOnline) == "number" and typeof(lastOnline2) == "number" and lastOnline ~= lastOnline2
end

local function getFriendWeight(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = if arg1 and arg1.presence then tbl1[arg1.presence] else nil

    if var1 == nil then
        var1 = tbl1[UserModel.PresenceType.OFFLINE]
    end
    return var1
end

return function(str1: string)
    return function(arg1, arg2): boolean
        local friendWeight = getFriendWeight(arg1)
        local friendWeight2 = getFriendWeight(arg2)

        if friendWeight ~= friendWeight2 then
            return friendWeight2 < friendWeight
        end

        if arg1.presence ~= UserModel.PresenceType.OFFLINE and useLastOnlineForSort(arg1.lastOnline, arg2.lastOnline) then
            return arg1.lastOnline > arg2.lastOnline
        end
        local var1 = arg1[str1] or ""
        local var2 = arg2[str1] or ""
        return var1:lower() < var2:lower()
    end
end
