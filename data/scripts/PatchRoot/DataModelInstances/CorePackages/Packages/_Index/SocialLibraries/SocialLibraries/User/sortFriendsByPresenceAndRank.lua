-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local RoduxPresence = dependencies.RoduxPresence
local UserModel = dependencies.UserModel
local t = dependencies.t
local PresenceType = RoduxPresence.Enums.PresenceType

local tbl1 = {
    [PresenceType.InGame.rawValue()] = 3,
    [PresenceType.Online.rawValue()] = 2,
    [PresenceType.InStudio.rawValue()] = 1,
    [PresenceType.Offline.rawValue()] = 0
}

local tbl2 = {
    [UserModel.PresenceType.IN_GAME] = 3,
    [UserModel.PresenceType.ONLINE] = 2,
    [UserModel.PresenceType.IN_STUDIO] = 1,
    [UserModel.PresenceType.OFFLINE] = 0
}

local function func1(num1: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    return t.number(num1) and tbl1[num1] or tbl1[PresenceType.Offline]
end

local function func2(presence: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    return t.string(presence) and tbl2[presence] or tbl2[UserModel.PresenceType.OFFLINE]
end

local function func3(tbl3, tbl4)
    local num1 = 0
    local num2 = 0

    if tbl3.userPresenceType and tbl4.userPresenceType then
        num1 = func1((tbl3.userPresenceType.rawValue()))
        local var1 = tbl4.userPresenceType.rawValue()
        num2 = t.number(var1) and tbl1[var1]

        if not num2 then
            return num1, tbl1[PresenceType.Offline]
        end
    elseif tbl3.presence and tbl4.presence then
        num1 = func2(tbl3.presence)
        num2 = func2(tbl4.presence)
    end

    return num1, num2
end

local function func4(tbl3, tbl4) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl3.username or tbl3.name or "", tbl4.username or tbl4.name or ""
end

return function(tbl3, tbl4): boolean
    local var1, var2 = func3(tbl3, tbl4)
    if var1 ~= var2 then
        return var2 < var1
    end

    local friendRank = t.number(tbl3.friendRank) and tbl3.friendRank or 0
    local friendRank2 = t.number(tbl4.friendRank) and tbl4.friendRank or 0
    if friendRank ~= friendRank2 then
        return friendRank < friendRank2
    end

    local displayName = t.string(tbl3.displayName) and tbl3.displayName or ""
    local displayName2 = t.string(tbl4.displayName) and tbl4.displayName or ""
    if string.lower(displayName) ~= string.lower(displayName2) then
        return string.lower(displayName) < string.lower(displayName2)
    end

    local var3, var4 = func4(tbl3, tbl4)
    return string.lower(var3) < string.lower(var4)
end
