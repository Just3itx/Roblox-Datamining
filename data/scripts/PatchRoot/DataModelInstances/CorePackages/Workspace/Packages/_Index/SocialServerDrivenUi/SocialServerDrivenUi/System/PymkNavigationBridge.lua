-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T20:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local Signal = require(SocialServerDrivenUiParent.AppCommonLib).Signal

local var1 = nil
local var2 = nil

local function getOpenProfileRequested() -- Luacid: Inlined by compiler; 2 call sites recovered
    local var3 = var1
    if var3 ~= nil then
        return var3
    end

    local signal = Signal.new()
    var1 = signal
    return signal
end

local function getOpenAddFriendsRequested() -- Luacid: Inlined by compiler; 2 call sites recovered
    local var3 = var2
    if var3 ~= nil then
        return var3
    end

    local signal = Signal.new()
    var2 = signal
    return signal
end

return {
    requestOpenProfile = function(userId: string, extraProps)
        getOpenProfileRequested():fire({ userId = userId, extraProps = extraProps })
    end,
    subscribeOpenProfile = function(func1: (...any) -> (...any))
        return getOpenProfileRequested():connect(func1)
    end,
    requestOpenAddFriends = function()
        getOpenAddFriendsRequested():fire()
    end,
    subscribeOpenAddFriends = function(func1: (...any) -> (...any))
        return getOpenAddFriendsRequested():connect(func1)
    end
}
