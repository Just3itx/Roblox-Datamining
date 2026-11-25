-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local RoactNavigation = require(ProfilePlatformParent.RoactNavigation)

local SocialServerDrivenUi = require(ProfilePlatformParent.SocialServerDrivenUi)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)
local SocialSduiComponentWrapper = SocialServerDrivenUi.SocialSduiComponentWrapper
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local useDynamicSizeMargin = require(ProfilePlatform.Hooks.useDynamicSizeMargin)
local useProfileCompletionSduiContext = require(ProfilePlatform.Hooks.useProfileCompletionSduiContext)
local useProfileCompletionData = require(ProfilePlatform.Hooks.useProfileCompletionData)
local Enums = require(ProfilePlatform.Common.Enums)

local useScreenSize = RobloxAppHooks.useScreenSize

return React.memo(function(tbl1) -- name: ProfileCompletionContainer
    local var1 = useProfileAnalyticsContext()
    local var2 = useScreenSize()
    local var3, var4 = useDynamicSizeMargin()

    local containerWidth, var6 = React.useState(var2.X)
    local sduiContext = useProfileCompletionSduiContext({ sideMargin = var3, containerWidth = containerWidth })

    local analyticsContext = React.useMemo(function()
        return {
            collectionPosition = tbl1.layoutOrder
        }
    end, { tbl1.layoutOrder })

    local verticalScrollingFrameRef = React.useRef(nil)
    local onFrameResized = React.useCallback(function(arg1)
        var4(arg1)
        var6(arg1.AbsoluteSize.X)
    end, { var4, var6 })

    React.useEffect(function()
        SocialServerDrivenUi.registerSocialActions()
    end, {})

    local sduiComponentConfig, onDidFocus = useProfileCompletionData()

    return React.createElement(React.Fragment, nil, {
        NavEvents = React.createElement(RoactNavigation.NavigationEvents, { onDidFocus = onDidFocus }),
        Content = if sduiComponentConfig then React.createElement(SocialSduiComponentWrapper, {
            layoutOrder = tbl1.layoutOrder,
            sduiContext = sduiContext,
            sduiComponentConfig = sduiComponentConfig,
            pageSideMargin = var3,
            onFrameResized = onFrameResized,
            verticalScrollingFrameRef = verticalScrollingFrameRef,
            scrollViewPositionChangedSignal = var1.scrollViewPositionChangedSignal,
            analyticsContext = analyticsContext,
            debugName = Enums.Components.ProfileCompletion,
            testId = "profile-completion"
        }) else nil
    })
end)
