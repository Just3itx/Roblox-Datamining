-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local FFlagUserProfilePlatformProfile = require(scriptParentParentParentParent.SharedFlags).FFlagUserProfilePlatformProfile

local SocialStopwatch = require(scriptParentParentParentParent.SocialStopwatch)
local SocialLuaAnalytics = require(scriptParentParentParentParent.SocialLuaAnalytics)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)

local dependencies = require(scriptParentParentParent.dependencies)
local SetAliasModal = require(script.Parent.SetAliasModal)
local Constants = require(scriptParentParentParent.Common.Constants)

local Analytics = require(scriptParentParentParent.Analytics)
local EventNames = Analytics.EventNames
local useAnalytics = Analytics.useAnalytics

local LoadingStages = SocialLuaAnalytics.Analytics.Enums.LoadingStages
local React = dependencies.React
local NetworkingAliases = dependencies.NetworkingAliases
local getDeepValue = dependencies.SocialLibraries.Dictionary.getDeepValue
local useSelector = dependencies.Hooks.useSelector
local useDispatch = dependencies.Hooks.useDispatch
local useEffectOnMount = dependencies.Hooks.useEffectOnMount
local useUserProfilesFetch = dependencies.UserProfiles.Hooks.useUserProfilesFetch
local query = if FFlagUserProfilePlatformProfile then dependencies.UserProfiles.Queries.userProfilesBasicNamesByUserIds else dependencies.UserProfiles.Queries.userProfilesAllNamesByUserIds
local writeNamesQuery = dependencies.UserProfiles.Mutations.writeNamesQuery
local useEffectOnce = RoactUtils.Hooks.useEffectOnce

return function(arg1)
    local var2 = useDispatch()

    local userId = arg1.navigation.getParam(Constants.PROFILE_USER_ID)
    local hasSaveAliasError, var4 = React.useState(false)
    local var5 = useUserProfilesFetch({ userIds = { userId }, query = query })

    local var6 = useAnalytics()
    local screenSize = useSelector(function(tbl1)
        return tbl1.ScreenSize
    end)

    local var8 = (getDeepValue(var5, "data.userProfiles") or {})[1] or {}

    local alias = getDeepValue(var8, "names.alias")
    local displayName = getDeepValue(var8, "names.displayName")

    useEffectOnMount(function()
        if var6 then
            var6.fireAnalyticsEvent(EventNames.CustomizeNameModalOpened)
        end
    end)

    React.useEffect(function()
        local var9 = SocialStopwatch.Stopwatch.get(SocialStopwatch.Events.CustomizeNameOpened)
        var6.fireAnalyticsEvent(
            EventNames.CustomizeNameLoadingStage,
            {
                status = LoadingStages.Fetching,
                statValue = var9 and var9.timeElapsed
            }
        )
        return function()
            SocialStopwatch.Stopwatch.stop(SocialStopwatch.Events.CustomizeNameOpened)
        end
    end, {})

    useEffectOnce(function()
        local var9 = SocialStopwatch.Stopwatch.get(SocialStopwatch.Events.CustomizeNameOpened)
        var6.fireAnalyticsEvent(
            EventNames.CustomizeNameLoadingStage,
            {
                status = if var5.data then LoadingStages.Done else LoadingStages.Failed,
                statValue = var9 and var9.timeElapsed
            }
        )
    end, var5.data or var5.error)

    local function cancelOnActivated() -- Luacid: Inlined by compiler; 1 call site recovered
        arg1.navigation.pop()
    end

    return React.createElement(SetAliasModal, {
        screenSize = screenSize,
        alias = alias,
        displayName = displayName,
        cancelOnActivated = cancelOnActivated,
        saveOnActivated = function(alias2: string)
            return var2(NetworkingAliases.SetUserTag.API(userId, alias2)):andThen(function(arg2)
                if getDeepValue(arg2, "responseBody.status") == "Moderated" then
                    var4(true)
                    if var6 then
                        var6.fireAnalyticsEvent(EventNames.CustomizeNameSaveAttemptInvalidInput, { alias = alias2 })
                    end

                    return
                end

                if var6 then
                    var6.fireAnalyticsEvent(EventNames.CustomizeNameSaved, { alias = alias2 })
                end

                writeNamesQuery({
                    client = var5.client,
                    query = query,
                    userId = userId,
                    names = {
                        alias = alias2,
                        contactName = getDeepValue(var8, "names.contactName"),
                        displayName = getDeepValue(var8, "names.displayName"),
                        username = getDeepValue(var8, "names.username")
                    }
                })
                cancelOnActivated()
            end)
        end,
        hasSaveAliasError = hasSaveAliasError,
        onTextChanged = function()
            if hasSaveAliasError then
                var4(false)
            end
        end,
        isLoading = var5.loading
    })
end
