-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local HttpService = game:GetService("HttpService")
local MomentsCommon = require(MomentsParent.MomentsCommon)
local MomentsTypes = require(MomentsParent.MomentsTypes)
local Navigation = require(MomentsParent.Navigation)
local React = require(MomentsParent.React)
local RoactNavigation = require(MomentsParent.RoactNavigation)
local SharedFlags = require(MomentsParent.SharedFlags)

local AppPage = require(MomentsParent.RobloxAppEnums).AppPage
local RobloxAppEvents = require(MomentsParent.RobloxAppEvents)

local GetDeepLinkStore = require(Moments.Stores.GetDeepLinkStore)
local _createDeepLinkStore = require(Moments.Stores.GetDeepLinkStore.createDeepLinkStore)
local createMomentsStore = require(Moments.Stores.GetMomentsStore.createMomentsStore)
local GetImmersiveChromeStore = require(Moments.Stores.GetImmersiveChromeStore)
local FFlagMomentsEmojiSetsApi = require(Moments.Flags.FFlagMomentsEmojiSetsApi)

local FFlagMomentsFixDeepLinkRefocusStaleNavigation = require(Moments.Flags.FFlagMomentsFixDeepLinkRefocusStaleNavigation)

local FStringMomentsExperienceJoinActionTextIxpLayer = require(Moments.Flags.FStringMomentsExperienceJoinActionTextIxpLayer)
local useMomentsTabIsVisible = require(Moments.Hooks.useMomentsTabIsVisible)
local consumeEntrySource = require(Moments.Utils.consumeEntrySource)
local logMomentsLayerExposure = MomentsCommon.Utils.logMomentsLayerExposure
local InnerNavigator = require(Moments.Navigation.InnerNavigator)
local MomentsHostShell = require(Moments.Components.MomentsHostShell)
local _MomentsHostContext = require(Moments.MomentsHostContext)

local useResetTeleportingOnGameLeave = require(Moments.Hooks.useResetTeleportingOnGameLeave)
local getExperienceDetailsSheetStore = require(Moments.ExperienceDetailsSheet.Sheet.getExperienceDetailsSheetStore)
local MomentsGetMomentsReactionsStore = require(MomentsParent.DataHydration.MomentsGetMomentsReactionsStore)

local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames
local FunnelEventNames = Analytics.FunnelEventNames
local SessionManager = Analytics.SessionManager
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent
local fireFunnelAnalyticsEvent = Analytics.fireFunnelAnalyticsEvent

local MomentsSurfaceLoadManager = MomentsCommon.Performance.MomentsSurfaceLoadManager

local useMomentsGating = MomentsCommon.Hooks.useMomentsGating
local canRenderNativeMoments = MomentsCommon.canRenderNativeMoments

local tbl1 = ({})
local FFlagMomentsCreateAvatarPosts = SharedFlags.FFlagMomentsCreateAvatarPosts
local FFlagMomentsAvatarLookTryOn = SharedFlags.FFlagMomentsAvatarLookTryOn
local FFlagMomentsCommentDeepLinks = SharedFlags.FFlagMomentsCommentDeepLinks
local ShareLinkTargetIdType = MomentsTypes.Enums.ShareLinkTargetIdType
local getActiveRoutes = Navigation.getActiveRoutes

local function normalizeDeepLinkedMomentId(postId) -- Luacid: Inlined by compiler; 7 call sites recovered
    if type(postId) == "string" and postId ~= "" then
        return postId
    elseif type(postId) == "number" then
        return tostring(postId)
    end
    return nil
end

local function getMomentIdFromLaunchData(launchData)
    if type(launchData) ~= "string" or launchData == "" then
        return nil
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(launchData)
    end)
    if success and type(result) == "table" then
        return normalizeDeepLinkedMomentId(result.postId)
    end

    return nil
end

local function normalizeTargetIdType(feedItemId) -- Luacid: Inlined by compiler; 3 call sites recovered
    return if feedItemId == ShareLinkTargetIdType.FeedItemId then ShareLinkTargetIdType.FeedItemId else nil
end

local function getTargetIdTypeFromLaunchData(launchData)
    if type(launchData) ~= "string" or launchData == "" then
        return nil
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(launchData)
    end)
    if success and type(result) == "table" then
        return normalizeTargetIdType(result.targetIdType)
    end

    return nil
end

local function getDeepLinkedMomentIdFromParams(arg1)
    if type(arg1) ~= "table" then
        return nil
    end

    local extraProps = arg1.extraProps
    if type(extraProps) == "table" then
        local var1 = normalizeDeepLinkedMomentId(extraProps.postId)
        if var1 ~= nil then
            return var1
        end

        local momentIdFromLaunchData = getMomentIdFromLaunchData(extraProps.launchData)
        if momentIdFromLaunchData ~= nil then
            return momentIdFromLaunchData
        end
    end

    local var1 = normalizeDeepLinkedMomentId(arg1.postId)
    if var1 ~= nil then
        return var1
    end

    return (getMomentIdFromLaunchData(arg1.launchData))
end

local function getDeepLinkedMomentTargetIdTypeFromParams(arg1)
    if type(arg1) ~= "table" then
        return nil
    end

    local extraProps = arg1.extraProps
    if type(extraProps) == "table" then
        if normalizeDeepLinkedMomentId(extraProps.postId) ~= nil then
            return normalizeTargetIdType(extraProps.targetIdType)
        end

        if getMomentIdFromLaunchData(extraProps.launchData) ~= nil then
            return (getTargetIdTypeFromLaunchData(extraProps.launchData))
        end
    end

    if normalizeDeepLinkedMomentId(arg1.postId) ~= nil then
        return normalizeTargetIdType(arg1.targetIdType)
    end

    return (getTargetIdTypeFromLaunchData(arg1.launchData))
end

local function getCommentsTargetFromTable(arg1)
    if type(arg1) ~= "table" then
        return nil
    end
    local commentId = if type(arg1.commentId) == "string" and arg1.commentId ~= "" then arg1.commentId else nil
    return if commentId == nil and arg1.openComments ~= true then nil else { commentId = commentId }
end

local function getCommentsTargetFromLaunchData(launchData) -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(launchData) ~= "string" or launchData == "" then
        return nil
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(launchData)
    end)
    if success then
        return (getCommentsTargetFromTable(result))
    end

    return nil
end

local function getDeepLinkedCommentsTargetFromParams(arg1)
    if type(arg1) ~= "table" then
        return nil
    end

    local extraProps = arg1.extraProps
    if type(extraProps) == "table" then
        if normalizeDeepLinkedMomentId(extraProps.postId) ~= nil then
            return (getCommentsTargetFromTable(extraProps))
        end

        if getMomentIdFromLaunchData(extraProps.launchData) ~= nil then
            return getCommentsTargetFromLaunchData(extraProps.launchData)
        end
    end

    if normalizeDeepLinkedMomentId(arg1.postId) ~= nil then
        return (getCommentsTargetFromTable(arg1))
    end

    return getCommentsTargetFromLaunchData(arg1.launchData)
end

local function getCommentsTargetKey(commentsTarget): string -- Luacid: Inlined by compiler; 2 call sites recovered
    if commentsTarget == nil then
        return ""
    end
    return `:comments:{commentsTarget.commentId or ""}`
end

local function getDeepLinkRequestFromNavigationParams(arg1, str1: string): {commentsTarget: any, key: number, momentId: any, targetIdType: any}?
    if not (arg1 and arg1.getParam) then
        return nil
    end

    local tbl2 = {
        extraProps = arg1.getParam("extraProps"),
        postId = arg1.getParam("postId"),
        targetIdType = arg1.getParam("targetIdType"),
        launchData = arg1.getParam("launchData"),
        commentId = if FFlagMomentsCommentDeepLinks then arg1.getParam("commentId") else nil,
        openComments = if FFlagMomentsCommentDeepLinks then arg1.getParam("openComments") else nil
    }
    local momentId = getDeepLinkedMomentIdFromParams(tbl2)
    if momentId == nil then
        return nil
    end

    local targetIdType = getDeepLinkedMomentTargetIdTypeFromParams(tbl2)
    local commentsTarget = if FFlagMomentsCommentDeepLinks then getDeepLinkedCommentsTargetFromParams(tbl2) else nil
    local tbl3 = {
        momentId = momentId,
        targetIdType = targetIdType,
        commentsTarget = commentsTarget,
        key = 0
    }
    local str2 = tostring(tbl2.extraProps)
    local str3 = tostring(tbl2.postId)
    local launchData = tbl2.launchData
    tbl3.key = `{str1}:params:{str2}:{str3}:{tostring(launchData)}:{momentId}:{tostring(targetIdType)}{getCommentsTargetKey(commentsTarget)}`
    return tbl3
end

local function getDeepLinkRequestFromNavigationState(state, str1: string)
    local activeRoutes = getActiveRoutes(state)
    for i = #activeRoutes, 1, -1 do
        local var1 = activeRoutes[i]
        local momentId = getDeepLinkedMomentIdFromParams(var1.params)
        if momentId == nil then
            continue
        end

        local targetIdType = getDeepLinkedMomentTargetIdTypeFromParams(var1.params)
        local commentsTarget = if FFlagMomentsCommentDeepLinks then getDeepLinkedCommentsTargetFromParams(var1.params) else nil
        local tbl2 = {
            momentId = momentId,
            targetIdType = targetIdType,
            commentsTarget = commentsTarget,
            key = 0
        }
        local str2 = tostring(var1.key)
        local params = var1.params
        tbl2.key = `{str1}:state:{str2}:{tostring(params)}:{momentId}:{tostring(targetIdType)}{getCommentsTargetKey(commentsTarget)}`
        return tbl2
    end

    return nil
end

local function getDeepLinkRequest(arg1)
    local num1 = 0

    while arg1 ~= nil do
        local str1 = tostring(num1)
        local var1 = getDeepLinkRequestFromNavigationParams(arg1, str1) or getDeepLinkRequestFromNavigationState(arg1.state, str1)
        if var1 ~= nil then
            return var1
        end

        if not arg1._dangerouslyGetParent then
            break
        end

        arg1 = arg1._dangerouslyGetParent()
        num1 += 1
    end

    return nil
end

local function seedDeepLinkedMoment(arg1, str1: string, str2: string?, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    arg1.setDeepLinkedMoment(str1, str2, arg2)
end

local function MomentsTabEntry(current)
    local var1 = React.useRef(current)
    var1.current = current

    local var2 = React.useRef(false)
    local var3 = React.useRef(false)

    local var4 = React.useRef(nil)
    if var4.current == nil then
        var4.current = createMomentsStore()
    end

    useResetTeleportingOnGameLeave()
    local var5 = React.useRef(nil)
    local var6 = React.useRef({})
    local deepLinkRequest = getDeepLinkRequest(current.navigation)
    local momentId = if deepLinkRequest == nil then nil else deepLinkRequest.momentId
    local key = if deepLinkRequest == nil then nil else deepLinkRequest.key

    if momentId ~= nil and var5.current ~= key then
        local deepLinkStore = GetDeepLinkStore()
        local targetIdType = if deepLinkRequest == nil then nil else deepLinkRequest.targetIdType
        local commentsTarget = if FFlagMomentsCommentDeepLinks and deepLinkRequest ~= nil then deepLinkRequest.commentsTarget else nil
        seedDeepLinkedMoment(deepLinkStore, momentId, targetIdType, commentsTarget)
        var5.current = key
    end

    React.useEffect(function()
        if momentId ~= nil and var3.current then
            RobloxAppEvents.ReloadPage:fire(AppPage.Moments)
        end
        var3.current = true
    end, { key, momentId, current.navigation })

    local var7 = React.useCallback(function()
        if var2.current then
            return
        end
        var2.current = true

        local current2 = var4.current

        local source = consumeEntrySource(var1.current.navigation, var6.current)

        current2.resetSession()
        current2.setSessionSource(source)

        logMomentsLayerExposure(FStringMomentsExperienceJoinActionTextIxpLayer)
        if require(Moments.Flags.FFlagMomentsCreatorAttributionIxpEnabled) then
            logMomentsLayerExposure(require(Moments.Flags.FStringMomentsCreatorAttributionIxpLayer))
        end

        if require(Moments.Flags.FFlagMomentsFeedIxpEnabled) then
            logMomentsLayerExposure(require(Moments.Flags.FStringMomentsFeedIxpLayer))
        end

        if FFlagMomentsEmojiSetsApi then
            local getAndFetchEmojiSets = MomentsGetMomentsReactionsStore(false).getAndFetchEmojiSets
            assert(getAndFetchEmojiSets ~= nil, "expected getAndFetchEmojiSets when FFlagMomentsEmojiSetsApi is on")
            getAndFetchEmojiSets()
        end

        fireAnalyticsEvent(
            EventNames.TapMomentsTab,
            {
                moments_session_id = current2.getMomentsSessionId(false),
                source = source
            }
        )
        Analytics.reportMomentsSessionStarted(source)

        local momentsSessionHeartbeat = Analytics.createMomentsSessionHeartbeat()
        tbl1[current2.getMomentsSessionId(false)] = momentsSessionHeartbeat
        momentsSessionHeartbeat.start(source)

        local var8 = SessionManager.startSession(FunnelEventNames.FunnelTypes.AppNavigation)
        fireFunnelAnalyticsEvent(
            FunnelEventNames.FunnelTypes.AppNavigation,
            FunnelEventNames.AppNavigationSteps.AppLaunched,
            var8
        )
    end, {})

    local var8 = React.useCallback(function()
        if not var2.current then
            return
        end
        var2.current = false
        MomentsSurfaceLoadManager.abort("blur")

        getExperienceDetailsSheetStore(false).close()

        local current2 = var4.current
        local var8 = os.clock() - current2.getSessionStartTime(false)

        fireAnalyticsEvent(EventNames.MomentsSessionEnded, {
            moments_session_id = current2.getMomentsSessionId(false),
            source = current2.getSessionSource(false),
            duration_seconds = tostring(math.floor(var8))
        })
        local momentsSessionId = current2.getMomentsSessionId(false)
        local var9 = tbl1[momentsSessionId]
        if var9 then
            var9.stop()
            tbl1[momentsSessionId] = nil
        end
        Analytics.reportMomentsSessionEnded(current2.getSessionSource(false))

        SessionManager.endSession(FunnelEventNames.FunnelTypes.AppNavigation)
    end, {})

    local var9 = React.useCallback(function()
        GetImmersiveChromeStore(false).setOverlayCovering(false)
        local onTabFocused = var1.current.onTabFocused
        if onTabFocused then
            onTabFocused()
        end
    end, {})

    React.useEffect(function()
        local navigation = current.navigation
        if not (navigation and navigation.addListener) then
            var7()
            var9()
            return function()
                var8()
            end
        end

        var7()
        var9()

        local var10 = navigation.addListener(RoactNavigation.Events.DidFocus, function()
            local var10 = if FFlagMomentsFixDeepLinkRefocusStaleNavigation then var1.current.navigation else navigation
            local deepLinkRequest2 = getDeepLinkRequest(var10)
            local bool1 = not (deepLinkRequest2 == nil) and var5.current == deepLinkRequest2.key

            if deepLinkRequest2 ~= nil and not bool1 then
                local deepLinkStore = GetDeepLinkStore()
                local momentId2 = deepLinkRequest2.momentId
                local targetIdType = deepLinkRequest2.targetIdType
                local commentsTarget = if FFlagMomentsCommentDeepLinks then deepLinkRequest2.commentsTarget else nil
                seedDeepLinkedMoment(deepLinkStore, momentId2, targetIdType, commentsTarget)
                var5.current = deepLinkRequest2.key
                RobloxAppEvents.ReloadPage:fire(AppPage.Moments)
            end
            var7()
            var9()
        end)
        local var11 = navigation.addListener(RoactNavigation.Events.WillBlur, function()
            var8()
        end)

        return function()
            var8()
            var10.remove()
            var11.remove()
        end
    end, { var7, var8, var9 })

    local var10 = useMomentsTabIsVisible()
    React.useEffect(function()
        if var10 then
            var9()
        end
    end, { var10, var9 })

    local var11 = React.useMemo(function()
        local openProfile = current.openProfile
        local openOwnMoments = current.openOwnMoments
        return {
            openProfile = openProfile and function(num1: number)
                GetImmersiveChromeStore(false).setOverlayCovering(true)
                openProfile(num1)
            end or nil,
            openOwnMoments = openOwnMoments and function()
                GetImmersiveChromeStore(false).setOverlayCovering(true)
                openOwnMoments()
            end or nil,
            openAvatarMomentsCreation = if FFlagMomentsCreateAvatarPosts then current.openAvatarMomentsCreation else nil,
            openMomentsFeedReport = current.openMomentsFeedReport,
            openAvatarLookTryOn = if FFlagMomentsAvatarLookTryOn then current.openAvatarLookTryOn else nil,
            openMomentCommentReport = current.openMomentCommentReport,
            openBlockUser = current.openBlockUser
        }
    end, {
        current.openProfile,
        current.openOwnMoments,
        if FFlagMomentsCreateAvatarPosts then current.openAvatarMomentsCreation else nil,
        current.openMomentsFeedReport,
        current.openMomentCommentReport,
        current.openBlockUser,
        if FFlagMomentsAvatarLookTryOn then current.openAvatarLookTryOn else nil
    })

    local var12 = useMomentsGating()
    if not canRenderNativeMoments(var12) then
        return nil
    end

    return React.createElement(
        MomentsHostShell,
        {
            sessionStore = var4.current,
            openProfile = var11.openProfile,
            openOwnMoments = var11.openOwnMoments,
            openAvatarMomentsCreation = if FFlagMomentsCreateAvatarPosts then var11.openAvatarMomentsCreation else nil,
            openMomentsFeedReport = var11.openMomentsFeedReport,
            openAvatarLookTryOn = if FFlagMomentsAvatarLookTryOn then var11.openAvatarLookTryOn else nil,
            openMomentCommentReport = var11.openMomentCommentReport,
            openBlockUser = var11.openBlockUser
        },
        React.createElement(InnerNavigator, { navigation = current.navigation })
    )
end

local var1 = React.Component:extend("MomentsTabEntryScreen")

function var1.render(arg1)
    return React.createElement(MomentsTabEntry, arg1.props)
end

var1.router = InnerNavigator.router

return var1
