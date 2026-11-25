-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:31:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserProfiles = script:FindFirstAncestor("UserProfiles")
local UserProfilesParent = UserProfiles.Parent

local Signals = require(UserProfilesParent.Signals)

local FFlagEnableBlackbirdCheck = require(UserProfilesParent.SharedFlags).FFlagEnableBlackbirdCheck

local UserProfileStore = require(UserProfiles.Stores.UserProfileStore)

local createComputed = Signals.createComputed

local function createIsRobloxSubscriberGetter(str1: string?)
    if not FFlagEnableBlackbirdCheck or str1 == nil or str1 == "" then
        return createComputed(function(): boolean
            return false
        end)
    end

    local var1 = UserProfileStore.get().fetchNamesByUserIds({ str1 })

    return createComputed(function(arg1)
        local success, result = pcall(var1, arg1)
        if success and result.status == "success" and #result.data > 0 then
            local var2 = result.data[1]
            if var2.getHasRobloxSubscription ~= nil then
                return var2.getHasRobloxSubscription(arg1)
            end
        end
        return false
    end)
end

return createIsRobloxSubscriberGetter
