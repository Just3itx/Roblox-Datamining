-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserProfilesParent = script:FindFirstAncestor("UserProfiles").Parent

local Signals = require(UserProfilesParent.Signals)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed
local UserProfileStore = require(script.Parent.UserProfileStore)

local tbl1 = ({})
local var1 = UserProfileStore.get()

local function getOrCreateUserSignal(num1: number) -- Luacid: Inlined by compiler; 3 call sites recovered
    if not tbl1[num1] then
        local getter, setter = createSignal(false)
        tbl1[num1] = { getter = getter, setter = setter }
    end
    return tbl1[num1]
end

local function hasUserVerifiedBadge(num1: number, arg1)
    local success, result = pcall(var1.fetchNamesByUserIds({ tostring(num1) }), arg1)
    local var2 = not success and {
        status = "failed",
        data = {}
    } or result

    if var2.status == "success" and #var2.data > 0 and var2.data[1].getIsVerified then
        return var2.data[1].getIsVerified(arg1)
    end

    return false
end

local get = {
    setBadgeVisibility = function(num1: number, bool1: boolean)
        getOrCreateUserSignal(num1).setter(bool1)
    end,
    getBadgeVisibilitySignal = function(num1: number)
        local orCreateUserSignal = getOrCreateUserSignal(num1)

        return createComputed(function(arg1)
            local var2 = hasUserVerifiedBadge(num1, arg1)
            local var3 = orCreateUserSignal.getter(arg1)
            return var2 and var3
        end)
    end,
    isBadgeVisible = function(num1: number)
        local var2 = hasUserVerifiedBadge(num1, false)

        local var3 = getOrCreateUserSignal(num1).getter(false)

        return var2 and var3
    end,
    reset = function()
        tbl1 = {}
    end
}
return {
    get = function()
        return get
    end
}
