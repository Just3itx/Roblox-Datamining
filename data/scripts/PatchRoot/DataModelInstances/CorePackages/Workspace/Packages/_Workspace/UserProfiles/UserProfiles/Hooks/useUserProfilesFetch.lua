-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:31:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserProfiles = script:FindFirstAncestor("UserProfiles")
local UserProfilesParent = UserProfiles.Parent
local Cryo = require(UserProfilesParent.Cryo)
local React = require(UserProfilesParent.React)
local RoactUtils = require(UserProfilesParent.RoactUtils)
local setupFireDiag = require(UserProfiles.Analytics.setupFireDiag)
local EventNames = require(UserProfiles.Analytics.EventNames)
local UserProfilesAnalytics = require(UserProfiles.Analytics.UserProfilesAnalytics)
local SocialCommon = require(UserProfilesParent.SocialCommon)

local getDeepValue = require(UserProfilesParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue

local useApolloAutoRetry = SocialCommon.Hooks.useApolloAutoRetry

local useEffectOnce = RoactUtils.Hooks.useEffectOnce
local useEffectOnMount = RoactUtils.Hooks.useEffectOnMount

local useQuery = require(UserProfilesParent.ApolloClient).useQuery

local bool1 = game:DefineFastFlag("UserProfilesEnableRetries", false)
local FFlagUserProfilesLogCancelledRequests = require(UserProfiles.Flags.FFlagUserProfilesLogCancelledRequests)
local FFlagUserProfilesLogErrorCodes = require(UserProfiles.Flags.FFlagUserProfilesLogErrorCodes)
local num1 = game:DefineFastInt("UserProfileDefaultRetryCount", 2)
local bool2 = game:DefineFastFlag("UserProfilesFilterInvalidUserIds", false)

return function(tbl1)
    local var1 = if bool2 then React.useMemo(function()
        return Cryo.List.filter(tbl1.userIds, function(arg1): boolean
            return tonumber(arg1) ~= nil
        end)
    end, { tbl1.userIds }) else nil

    local skip = if bool2 then #var1 == 0 else #tbl1.userIds == 0
    local var2 = useQuery
    local query = tbl1.query
    local tbl2 = {
        errorPolicy = "all",
        skip = skip or tbl1.skip,
        variables = 0
    }
    local variables = { userIds = 0 }
    if not bool2 then
        var1 = tbl1.userIds
    end

    variables.userIds = var1
    tbl2.variables = variables
    local var3 = var2(query, tbl2)

    local var4 = var3
    if bool1 then
        var4 = useApolloAutoRetry(var3, { retryCount = if tbl1.overrideRetryCount then tbl1.overrideRetryCount else num1 })
    end

    local var5 = React.useRef(var4.loading or var4.isRetrying)
    if FFlagUserProfilesLogCancelledRequests then
        var5.current = var4.loading or var4.isRetrying
    end

    local var6 = React.useMemo(function()
        return setupFireDiag({ analytics = { Diag = UserProfilesAnalytics.Diag } })
    end, {})

    local var7 = React.useRef(DateTime.now())

    useEffectOnMount(function()
        var7.current = DateTime.now()
        var6(EventNames.UserProfilesRequestBegin)
    end)

    if bool1 then
        useEffectOnce(function()
            if not var7.current then
                return
            end

            local var8 = DateTime.now().UnixTimestampMillis - var7.current.UnixTimestampMillis
            var6(EventNames.UserProfilesRequestFail)
            UserProfilesAnalytics.Diag:reportStats(EventNames.UserProfilesRequestFailDuration, var8)

            if not FFlagUserProfilesLogErrorCodes then
                return
            end

            local deepValue = getDeepValue(var4, "error.graphQLErrors")
            if not deepValue then
                return
            end

            local var9 = deepValue[1] or {}
            local status = getDeepValue(var9, "extensions.status")

            var6(EventNames.UserProfilesErrorCode, { status = status })
        end, var4.error)

        useEffectOnce(function()
            if not var7.current then
                return
            end

            local var8 = DateTime.now().UnixTimestampMillis - var7.current.UnixTimestampMillis
            if var4.data and var4.retryCount == 0 then
                var6(EventNames.UserProfilesRequestSuccess)
                UserProfilesAnalytics.Diag:reportStats(EventNames.UserProfilesRequestSuccessDuration, var8)
                return
            end

            if var4.data then
                var6(EventNames.UserProfilesRequestSuccessAfterRetry)
                UserProfilesAnalytics.Diag:reportStats(EventNames.UserProfilesRequestSuccessAfterRetry, var8)
                return
            end

            var6(EventNames.UserProfilesRequestFailAfterRetry)
            UserProfilesAnalytics.Diag:reportStats(EventNames.UserProfilesRequestFailAfterRetryDuration, var8)

            if not FFlagUserProfilesLogErrorCodes then
                return
            end

            local deepValue = getDeepValue(var4, "error.graphQLErrors")
            if not deepValue then
                return
            end

            local var9 = deepValue[1] or {}
            local status = getDeepValue(var9, "extensions.status")

            var6(EventNames.UserProfilesErrorCode, { status = status })
        end, if FFlagUserProfilesLogCancelledRequests then not var5.current else var4.loading == false and var4.isRetrying == false)
    end

    if FFlagUserProfilesLogCancelledRequests then
        React.useEffect(function()
            return function()
                if var5.current then
                    var6(EventNames.UserProfilesUnmountEarly)
                end
            end
        end, {})
    end

    return var4
end
