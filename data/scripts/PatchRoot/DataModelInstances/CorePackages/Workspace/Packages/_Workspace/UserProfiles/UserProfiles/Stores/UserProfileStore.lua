-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserProfiles = script:FindFirstAncestor("UserProfiles")
local UserProfilesParent = UserProfiles.Parent
local Lumberyak = require(UserProfilesParent.Lumberyak)
local SharedFlags = require(UserProfilesParent.SharedFlags)
local FFlagUserProfilePlatformProfile = SharedFlags.FFlagUserProfilePlatformProfile
local PlatformProfileRequest = require(UserProfilesParent.GraphQLServer.PlatformProfileRequest)
local Signals = require(UserProfilesParent.Signals)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local maxLevel = game:DefineFastString("UserProfileStoreMaxLoggingLevel", Lumberyak.Logger.Levels.Error)
local num1 = game:DefineFastInt("UserProfileStoreHttpTimeout", 1500)
local FIntUserProfileStoreBatchSize = SharedFlags.FIntUserProfileStoreBatchSize
local num2 = game:DefineFastInt("UserProfileStoreQueueProcessDelay", 1)
local FFlagEnableVerifiedBadgeStore = SharedFlags.FFlagEnableVerifiedBadgeStore
local FFlagEnableBlackbirdCheck = SharedFlags.FFlagEnableBlackbirdCheck
local UserProfileModel = require(script.Parent.UserProfileModel)
local FFlagUserProfileStoreSplitPlatformFields = require(UserProfiles.Flags.FFlagUserProfileStoreSplitPlatformFields)
local var1 = FFlagUserProfilePlatformProfile and FFlagUserProfileStoreSplitPlatformFields

local computed = createComputed(function(_)
    local urlBuilder = require(UserProfilesParent.UrlBuilder)
    local urlBuilder2 = urlBuilder.UrlBuilder
    local urlBase = urlBuilder.UrlBase

    local logger = Lumberyak.Logger.new(nil, "UserProfileStore")
    logger:setContext({ prefix = "[UserProfileStore] " })
    logger:addSink({
        maxLevel = maxLevel,
        log = function(_, _, _) end
    })

    local HttpService = game:GetService("HttpService")
    local url = urlBuilder2.new({ base = urlBase.APIS, path = "user-profile-api/v1/user/profiles/get-profiles" })()
    local timeout = num1

    local tbl1 = {
        USERNAME = "names.username",
        DISPLAY_NAME = "names.displayName",
        COMBINED_NAME = "names.combinedName",
        IN_EXPERIENCE_COMBINED_NAME = "names.inExperienceCombinedName",
        PLATFORM_NAME = "names.platformName",
        CONTACT_NAME = "names.contactName",
        ALIAS = "names.alias",
        PLATFORM_PROFILE_ID = "platformProfileId",
        IS_VERIFIED = if FFlagEnableVerifiedBadgeStore then "isVerified" else nil,
        HAS_ROBLOX_SUBSCRIPTION = if FFlagEnableBlackbirdCheck then "hasRobloxSubscription" else nil
    }

    local tbl2 = ({})
    local tbl3 = ({})
    local tbl4 = ({})
    local bool1 = false

    local function getOrCreateByUserId(str2: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        local var3 = tbl2[str2]
        if var3 ~= nil then
            logger:trace("Found profile: {}", str2)
            return var3
        end

        logger:trace("Creating profile: {}", str2)
        local var4 = UserProfileModel.create(str2)
        tbl2[str2] = var4
        return var4
    end

    local tbl5 = { tbl1.PLATFORM_NAME, tbl1.PLATFORM_PROFILE_ID }
    local var3 = table.clone(tbl5)
    table.sort(var3)
    local str2 = table.concat(var3, ",")

    local function performBatchFetch(tbl6, str3: string, tbl7, bool2: boolean)
        if #tbl6 == 0 then
            logger:trace("No more ids to fetch. Setting result.")
            for _, value in ipairs(tbl7) do
                local tbl8 = {}
                local var4 = tbl3[str3]
                for _, userId in value.userIds do
                    local var5 = var4[userId]
                    if var5 then
                        logger:trace("Found cached profile: {}", userId)
                        table.insert(tbl8, var5)
                    else
                        logger:debug("Expected cached profile: {}", userId)
                    end
                end

                local tbl9 = {
                    status = if bool2 then "success" else "failed",
                    data = tbl8
                }
                value.setResult(tbl9)
                local callback = value.callback
                if callback ~= nil then
                    callback(tbl9)
                end
            end
            return
        end

        local tbl8 = {}
        local num4 = #tbl6
        local tbl9

        if FIntUserProfileStoreBatchSize < num4 then
            tbl9 = {}
            for i = 1, FIntUserProfileStoreBatchSize do
                local var4 = tbl6[i]
                table.insert(tbl9, var4)
            end
            for i = FIntUserProfileStoreBatchSize + 1, #tbl6 do
                table.insert(tbl8, tbl6[i])
            end
        else
            tbl9 = tbl6
        end

        local fields = string.split(str3, ",")
        local var4 = nil
        if FFlagUserProfilePlatformProfile and PlatformProfileRequest.hasPlatformFields(fields) then
            var4 = true
        end

        local body = HttpService:JSONEncode({ userIds = tbl9, fields = fields, includePlatformProfile = var4 })

        logger:debug("Fetching: {}", body)

        HttpService:RequestInternal({
            Url = url,
            Method = "POST",
            Body = body,
            Timeout = timeout,
            CachePolicy = Enum.HttpCachePolicy.None,
            Priority = 0,
            Headers = { ["Content-Type"] = "application/json", Accept = "application/json" },
            RequestType = Enum.HttpRequestType.Default
        }):Start(
            function(arg1, arg2)
                if arg1 == true then
                    local body2 = arg2.Body
                    if body2 ~= nil then
                        local _success, result = pcall(function()
                            return HttpService:JSONDecode(body2)
                        end)
                        if result ~= nil then
                            logger:trace("Fetched: {}\nresponse: {}", body, body2)
                            local profileDetails = result.profileDetails
                            if profileDetails ~= nil then
                                if FFlagUserProfilePlatformProfile then
                                    profileDetails = PlatformProfileRequest.normalizeProfiles(profileDetails, fields)
                                end
                                local var5 = tbl3[str3]
                                for _, profileDetail in ipairs(profileDetails) do
                                    local str5 = tostring(profileDetail.userId)
                                    local orCreateByUserId = getOrCreateByUserId(str5)

                                    if profileDetail then
                                        logger:trace("Updating profile: {}", str5)
                                        UserProfileModel.update(orCreateByUserId, profileDetail)
                                    end
                                    var5[str5] = orCreateByUserId
                                end

                                if var1 and str3 == str2 then
                                    for _, userId in tbl9 do
                                        if var5[userId] ~= nil then
                                            continue
                                        end

                                        local orCreateByUserId = getOrCreateByUserId(userId)
                                        UserProfileModel.update(orCreateByUserId, PlatformProfileRequest.normalizeProfiles({{ userId = userId }}, fields)[1])

                                        var5[userId] = orCreateByUserId
                                    end
                                end
                            end
                        end
                    end
                else
                    logger:error("Error fetching")
                end

                performBatchFetch(tbl8, str3, tbl7, not (arg1 == false) and bool2)
            end
        )
    end
    local function processQueuedRequests()
        for k, value in pairs(tbl4) do
            logger:trace("Processing requests ({}) for fields: {}", #value, k)
            local tbl6 = ({})
            local tbl7 = {}
            local var4 = tbl3[k]
            for _, value2 in ipairs(value) do
                for _, userId in ipairs(value2.userIds) do
                    if tbl6[userId] ~= nil then
                        continue
                    end

                    tbl6[userId] = userId
                    if var4[userId] == nil then
                        table.insert(tbl7, userId)
                    end
                end
            end

            performBatchFetch(tbl7, k, table.clone(value), true)
        end

        tbl4 = {}
    end

    local function fetchByUserIds(userIds, tbl6, callback: ((...any) -> (...any))?)
        table.sort(tbl6)
        local str3 = table.concat(tbl6, ",")

        local tbl7 = tbl3[str3]
        if tbl7 == nil then
            tbl7 = {}
            tbl3[str3] = tbl7
        end

        local tbl8 = {}
        local bool2 = false
        for _, userId in userIds do
            local var4 = tbl7[userId]
            if var4 == nil and bool2 == false then
                bool2 = true
            end

            table.insert(tbl8, var4 or getOrCreateByUserId(userId))
        end

        if bool2 == false then
            logger:trace("All requested profiles are cached. Calling back early")

            local tbl9 = { status = "success", data = tbl8 }

            local signal = createSignal(tbl9)
            if callback ~= nil then
                callback(tbl9)
            end
            return signal
        end

        local tbl9 = { status = "fetching", data = tbl8 }

        local getResult, setResult = createSignal(tbl9)

        local tbl10 = tbl4[str3]
        if tbl10 == nil then
            tbl10 = {}
            tbl4[str3] = tbl10
        end

        table.insert(tbl10, { userIds = userIds, getResult = getResult, setResult = setResult, callback = callback })

        if not bool1 then
            bool1 = true
            if FFlagEnableBlackbirdCheck then
                task.defer(function()
                    processQueuedRequests()
                    bool1 = false
                end)
            else
                task.delay(num2, function()
                    processQueuedRequests()
                    bool1 = false
                end)
            end
        end
        if callback ~= nil then
            callback(tbl9)
        end
        return getResult
    end

    local function getNameFields(bool2: boolean?)
        local tbl6 = {
            tbl1.COMBINED_NAME,
            tbl1.DISPLAY_NAME,
            tbl1.USERNAME,
            tbl1.IN_EXPERIENCE_COMBINED_NAME,
            tbl1.CONTACT_NAME,
            tbl1.ALIAS
        }

        if not FFlagUserProfilePlatformProfile or bool2 and not var1 then
            table.insert(tbl6, tbl1.PLATFORM_NAME)
            table.insert(tbl6, tbl1.PLATFORM_PROFILE_ID)
        end

        if FFlagEnableVerifiedBadgeStore then
            table.insert(tbl6, tbl1.IS_VERIFIED)
        end

        if FFlagEnableBlackbirdCheck then
            table.insert(tbl6, tbl1.HAS_ROBLOX_SUBSCRIPTION)
        end

        return tbl6
    end

    local function getPlatformFields() -- Luacid: Inlined by compiler; 2 call sites recovered
        return table.clone(tbl5)
    end

    local function combineFetchResults(tbl6, tbl7) -- Luacid: Inlined by compiler; 4 call sites recovered
        local str3 = "success"
        if tbl6.status == "fetching" or tbl7.status == "fetching" then
            str3 = "fetching"
        elseif tbl6.status == "failed" or tbl7.status == "failed" then
            str3 = "failed"
        end

        return {
            status = str3,
            data = tbl6.data
        }
    end

    local function fetchNamesAndPlatformFieldsByUserIds(userIds, callback: ((...any) -> (...any))?)
        local var4 = nil
        local var5 = nil
        local status = nil
        local function report() -- Luacid: Inlined by compiler; 2 call sites recovered
            if callback == nil or var4 == nil or var5 == nil then
                return
            end
            local tbl6 = combineFetchResults(var4, var5)
            if tbl6.status ~= status then
                status = tbl6.status
                callback(tbl6)
            end
        end

        local var6 = fetchByUserIds(userIds, getNameFields(false), function(arg1)
            var4 = arg1
            report()
        end)

        local var7 = fetchByUserIds(userIds, getPlatformFields(), function(arg1)
            var5 = arg1
            report()
        end)

        return createComputed(function(arg1)
            return combineFetchResults(var6(arg1), (var7(arg1)))
        end)
    end

    local function invalidateCachedProfiles(tbl6, tbl7)
        table.sort(tbl6)
        local str3 = table.concat(tbl6, ",")

        local var4 = tbl3[str3]
        if var4 == nil or tbl7 == nil then
            return
        end

        for _, value in tbl7 do
            var4[value] = nil
        end
    end

    return {
        fetchNamesByUserIds = function(userIds, func1: ((...any) -> (...any))?, bool2: boolean?)
            if var1 and bool2 then
                return fetchNamesAndPlatformFieldsByUserIds(userIds, func1)
            end
            return (fetchByUserIds(userIds, getNameFields(bool2), func1))
        end,
        updateFromHydration = function(tbl6)
            for value, value2 in tbl6 do
                if value2.userId ~= nil then
                    value = tostring(value2.userId)
                end

                local orCreateByUserId = getOrCreateByUserId(value)
                UserProfileModel.update(
                    orCreateByUserId,
                    {
                        names = {
                            username = value2.username,
                            displayName = value2.displayName
                        },
                        isVerified = value2.isVerified
                    }
                )
            end
        end,
        getProfileByUserId = function(str3: string)
            return tbl2[str3]
        end,
        invalidateCachedNamesForUserIds = function(tbl6)
            if var1 then
                invalidateCachedProfiles(getNameFields(false), tbl6)
                invalidateCachedProfiles(getPlatformFields(), tbl6)
                return
            end

            if FFlagUserProfilePlatformProfile then
                invalidateCachedProfiles(getNameFields(false), tbl6)
                invalidateCachedProfiles(getNameFields(true), tbl6)
                return
            end

            local tbl7 = {
                tbl1.COMBINED_NAME,
                tbl1.DISPLAY_NAME,
                tbl1.USERNAME,
                tbl1.IN_EXPERIENCE_COMBINED_NAME,
                tbl1.CONTACT_NAME,
                tbl1.ALIAS,
                tbl1.PLATFORM_NAME,
                tbl1.PLATFORM_PROFILE_ID
            }

            invalidateCachedProfiles(tbl7, tbl6)
        end
    }
end)
return {
    get = function()
        return computed(false)
    end
}
