-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)
local Cryo = require(AppChatParent.Cryo)
local PresenceType = require(AppChat.Http.RoduxPresence).Enums.PresenceType

local USERS = {
    ["1"] = {
        id = "1",
        username = "username1",
        displayName = "displayName1",
        combinedName = "combinedName1",
        alias = "alias1",
        presenceType = PresenceType.Online,
        presenceText = "Online",
        lastLocation = "TestLocation"
    },
    ["2"] = {
        id = "2",
        username = "username2",
        displayName = "displayName2",
        combinedName = "combinedName2",
        alias = "alias2",
        presenceType = PresenceType.InGame,
        presenceText = "Studio - Testing",
        lastLocation = "Studio - Testing"
    },
    ["3"] = {
        id = "3",
        username = "username3",
        displayName = "displayName3",
        combinedName = "combinedName3",
        alias = "alias3",
        presenceType = PresenceType.Offline,
        presenceText = "Offline",
        lastLocation = nil
    },
    ["4"] = {
        id = "4",
        username = "username4",
        displayName = "displayName4",
        combinedName = "combinedName4",
        alias = "alias4",
        presenceType = PresenceType.Online,
        presenceText = "Online",
        lastLocation = "TestLocation"
    },
    ["1989"] = {
        id = "1989",
        username = "username",
        displayName = "Test Display Name",
        combinedName = "Test Primary Name",
        alias = "Test Primary Name",
        presenceType = PresenceType.Online,
        presenceText = "Online",
        lastLocation = "TestLocation"
    },
    ["1969"] = {
        id = "1969",
        username = "username",
        displayName = "ClementOrange",
        combinedName = "OrangeClement",
        alias = "OrangeClement",
        presenceType = PresenceType.InGame,
        presenceText = "Studio - Testing",
        lastLocation = "Studio - Testing"
    },
    ["1949"] = {
        id = "1949",
        username = "username",
        displayName = "PineAzure",
        combinedName = "AzurePine",
        alias = "AzurePine",
        presenceType = PresenceType.Offline,
        presenceText = "Offline",
        lastLocation = nil
    },
    ["422502"] = {
        id = "422502",
        username = "username",
        displayName = "TestUserB",
        combinedName = "TestUserB",
        alias = "(alias)",
        presenceType = PresenceType.InGame,
        presenceText = "Studio - Testing",
        lastLocation = "Studio - Testing"
    }
}

function createMockUserProfile(arg1)
    local createSignal = Signals.createSignal

    local getUsername, _ = createSignal(arg1.username or "")
    local getDisplayName, _ = createSignal(arg1.displayName or "")
    local getCombinedName, _ = createSignal(arg1.combinedName or "")
    local getInExperienceCombinedName, _ = createSignal(arg1.combinedName or "")
    local getPlatformName, _ = createSignal(arg1.combinedName or "")
    local getAlias, _ = createSignal(arg1.alias or "")
    local getPlatformProfileId, _ = createSignal("")

    return {
        userId = arg1.id,
        names = {
            getUsername = getUsername,
            getDisplayName = getDisplayName,
            getCombinedName = getCombinedName,
            getInExperienceCombinedName = getInExperienceCombinedName,
            getPlatformName = getPlatformName,
            getAlias = getAlias
        },
        getPlatformProfileId = getPlatformProfileId
    }
end

function createMockUserProfileStore()
    local tbl2 = ({})

    for k, value in pairs(USERS) do
        tbl2[k] = createMockUserProfile(value)
    end

    return {
        fetchNamesByUserIds = function(arg1)
            local tbl3 = {
                status = "success",
                data = Cryo.List.filterMap(arg1, function(arg2)
                    local var1 = tbl2[arg2]
                    if not var1 and USERS[arg2] then
                        var1 = createMockUserProfile(USERS[arg2])
                        tbl2[arg2] = var1
                    end
                    return var1
                end)
            }

            return Signals.createSignal(tbl3)
        end,
        invalidateCachedNamesForUserIds = function() end
    }
end

function useMockProfileNames(arg1)
    local namesByUserId = ({})
    local bool1 = false
    for _, value in arg1 do
        local var1 = USERS[tostring(value)]
        if var1 then
            local id = var1.id
            namesByUserId[id] = {
                combinedName = var1.combinedName,
                username = var1.username
            }
        else
            bool1 = true
        end
    end

    return {
        status = if bool1 then "Failed" else "Ready",
        namesByUserId = namesByUserId
    }
end

function createMockPresenceData()
    local mockPresenceData = ({})

    for k, value in pairs(USERS) do
        local tbl2 = {
            userPresenceType = value.presenceType,
            lastLocation = value.lastLocation
        }
        mockPresenceData[k] = tbl2
    end

    return mockPresenceData
end

function createMockApolloProfiles()
    local mockApolloProfiles = ({})

    for k, value in pairs(USERS) do
        local tbl2 = {
            combinedName = value.combinedName,
            alias = value.alias,
            displayName = value.displayName,
            username = value.username,
            platformName = value.combinedName
        }
        mockApolloProfiles[k] = tbl2
    end

    return mockApolloProfiles
end

function getUserProfilesFetchData()
    return Cryo.List.map(USERS, function<T>(arg1: T): T
        return arg1
    end)
end

return {
    USERS = USERS,
    createMockUserProfile = createMockUserProfile,
    createMockUserProfileStore = createMockUserProfileStore,
    useMockProfileNames = useMockProfileNames,
    createMockPresenceData = createMockPresenceData,
    createMockApolloProfiles = createMockApolloProfiles,
    getUserProfilesFetchData = getUserProfilesFetchData
}
