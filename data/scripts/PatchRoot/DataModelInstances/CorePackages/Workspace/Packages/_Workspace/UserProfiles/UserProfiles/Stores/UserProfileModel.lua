-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserProfilesParent = script:FindFirstAncestor("UserProfiles").Parent
local createSignal = require(UserProfilesParent.Signals).createSignal

local SharedFlags = require(UserProfilesParent.SharedFlags)
local FFlagEnableVerifiedBadgeStore = SharedFlags.FFlagEnableVerifiedBadgeStore
local FFlagEnableBlackbirdCheck = SharedFlags.FFlagEnableBlackbirdCheck

return {
    update = function(tbl1, arg1)
        if not arg1 or type(arg1) ~= "table" then
            return
        end

        local names = arg1.names
        if names and type(names) == "table" then
            local username = names.username
            if username and type(username) == "string" then
                tbl1.names.setUsername(username)
            end
            local displayName = names.displayName
            if displayName and type(displayName) == "string" then
                tbl1.names.setDisplayName(displayName)
            end
            local combinedName = names.combinedName
            if combinedName and type(combinedName) == "string" then
                tbl1.names.setCombinedName(combinedName)
            end
            local inExperienceCombinedName = names.inExperienceCombinedName
            if inExperienceCombinedName and type(inExperienceCombinedName) == "string" then
                tbl1.names.setInExperienceCombinedName(inExperienceCombinedName)
            end
            local platformName = names.platformName
            if platformName and type(platformName) == "string" then
                tbl1.names.setPlatformName(platformName)
            end
            local contactName = names.contactName
            if contactName and type(contactName) == "string" then
                tbl1.names.setContactName(contactName)
            end
            local alias = names.alias
            if alias and type(alias) == "string" then
                tbl1.names.setAlias(alias)
            end
        end

        local platformProfileId = arg1.platformProfileId
        if platformProfileId and type(platformProfileId) == "string" then
            tbl1.setPlatformProfileId(platformProfileId)
        end

        local isVerified = if FFlagEnableVerifiedBadgeStore then arg1.isVerified else nil

        if isVerified ~= nil and type(isVerified) == "boolean" then
            tbl1.setIsVerified(isVerified)
        end

        local hasRobloxSubscription = if FFlagEnableBlackbirdCheck then arg1.hasRobloxSubscription else nil

        if hasRobloxSubscription ~= nil and type(hasRobloxSubscription) == "boolean" then
            tbl1.setHasRobloxSubscription(hasRobloxSubscription)
        end
    end,
    create = function(userId: string)
        local getUsername, setUsername = createSignal("")
        local getDisplayName, setDisplayName = createSignal("")
        local getCombinedName, setCombinedName = createSignal("")
        local getInExperienceCombinedName, setInExperienceCombinedName = createSignal("")
        local getPlatformName, setPlatformName = createSignal("")
        local getContactName, setContactName = createSignal("")
        local getAlias, setAlias = createSignal("")
        local getPlatformProfileId, setPlatformProfileId = createSignal("")
        local var17, var18

        if FFlagEnableVerifiedBadgeStore then
            var17, var18 = createSignal(false)
        else
            var17 = nil
            var18 = nil
        end

        local var19, var20

        if FFlagEnableBlackbirdCheck then
            var19, var20 = createSignal(false)
        else
            var19 = nil
            var20 = nil
        end

        local tbl1 = {
            userId = userId,
            names = {
                getUsername = getUsername,
                setUsername = setUsername,
                getDisplayName = getDisplayName,
                setDisplayName = setDisplayName,
                getCombinedName = getCombinedName,
                setCombinedName = setCombinedName,
                getInExperienceCombinedName = getInExperienceCombinedName,
                setInExperienceCombinedName = setInExperienceCombinedName,
                getPlatformName = getPlatformName,
                setPlatformName = setPlatformName,
                getContactName = getContactName,
                setContactName = setContactName,
                getAlias = getAlias,
                setAlias = setAlias
            },
            getPlatformProfileId = getPlatformProfileId,
            setPlatformProfileId = setPlatformProfileId,
            getIsVerified = 0,
            setIsVerified = 0,
            getHasRobloxSubscription = 0,
            setHasRobloxSubscription = 0
        }

        if not FFlagEnableVerifiedBadgeStore then
            var17 = nil
        end

        tbl1.getIsVerified = var17
        if not FFlagEnableVerifiedBadgeStore then
            var18 = nil
        end

        tbl1.setIsVerified = var18
        if not FFlagEnableBlackbirdCheck then
            var19 = nil
        end

        tbl1.getHasRobloxSubscription = var19
        if not FFlagEnableBlackbirdCheck then
            var20 = nil
        end

        tbl1.setHasRobloxSubscription = var20

        return tbl1
    end
}
