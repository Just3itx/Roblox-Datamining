-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local Cryo = require(ProfilePlatformParent.Cryo)
local React = require(ProfilePlatformParent.React)
local AppCommonLib = require(ProfilePlatformParent.AppCommonLib)
local SubPages = require(ProfilePlatformParent.SocialLuaAnalytics).Analytics.Enums.SubPages
local initializeProfileAnalytics = require(ProfilePlatform.Analytics.initializeProfileAnalytics)
local ProfileAnalyticsContext = require(ProfilePlatform.Contexts.ProfileAnalyticsContext)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local ProfileScrollContextProvider = require(ProfilePlatform.Contexts.ProfileScrollContext.ProfileScrollContextProvider)
local HttpService = game:GetService("HttpService")
local FFlagProfilePlatformEnableImpressions = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableImpressions

local ProfilePlatformNavigator = require(script.Parent.ProfilePlatformNavigator)

local function func1(arg1)
    local ref = if FFlagProfilePlatformEnableImpressions then nil else React.createRef()
    local var1 = useProfileWrapperContext()
    local profileId = var1.profileId
    local signal = if FFlagProfilePlatformEnableImpressions then AppCommonLib.Signal.new() else nil

    local value = React.useMemo(function()
        if not FFlagProfilePlatformEnableImpressions and ref.current == nil then
            ref.current = HttpService:GenerateGUID(false)
        end
        local var2 = initializeProfileAnalytics()
        var2.updateInfoForAllEvents({
            profileSessionId = if FFlagProfilePlatformEnableImpressions then var1.profileSessionId elseif var1.sessionIdOverride then var1.sessionIdOverride else ref.current,
            profileId = profileId,
            profileType = var1.profileType,
            subpage = SubPages.PeekView
        })
        if FFlagProfilePlatformEnableImpressions then
            return (Cryo.Dictionary.join(var2, { scrollViewPositionChangedSignal = signal }))
        end

        return var2
    end, { profileId, var1.sessionIdOverride })

    return React.createElement(
        ProfileAnalyticsContext.Provider,
        { value = value },
        { React.createElement(ProfileScrollContextProvider, nil, { React.createElement(ProfilePlatformNavigator, arg1) }) }
    )
end

local var1 = React.PureComponent:extend("ProfilePlatformNavigatorWithProviders")

function var1.render(arg1)
    return React.createElement(func1, arg1.props)
end

var1.router = ProfilePlatformNavigator.router

return var1
