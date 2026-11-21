-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent
local React = require(AvatarExperienceProfilePictureEditorParent.React)
local HttpRequest = require(AvatarExperienceProfilePictureEditorParent.HttpRequest)
local ProfilePlatformCommon = require(AvatarExperienceProfilePictureEditorParent.ProfilePlatformCommon)
local SignalsReact = require(AvatarExperienceProfilePictureEditorParent.SignalsReact)
local FFlagRobloxSubscriptionOnboardingSheet = require(AvatarExperienceProfilePictureEditorParent.SharedFlags).FFlagRobloxSubscriptionOnboardingSheet
local Constants = require(AvatarExperienceProfilePictureEditor.Constants)
local _parseCloseupCameraConfig = require(AvatarExperienceProfilePictureEditor.Shared.parseCloseupCameraConfig)
local _Enums = require(AvatarExperienceProfilePictureEditor.Common.Enums)
local userAvatarConfigurationsApi = require(AvatarExperienceProfilePictureEditor.Api.userAvatarConfigurationsApi)
local userAvatarConfigurationsCache = require(AvatarExperienceProfilePictureEditor.Api.userAvatarConfigurationsCache)

local ProfileRefreshSignal = ProfilePlatformCommon.Signals.ProfileRefreshSignal
local useSignalState = SignalsReact.useSignalState

local tbl1 = {
    distanceScale = Constants.DefaultDistanceScale,
    yRotDeg = Constants.DefaultYRotDeg,
    fieldOfViewDeg = Constants.DefaultFieldOfViewDeg,
    emoteAssetId = nil
}

local var1 = HttpRequest.config({
    requestFunction = function(str1: string, arg1, arg2)
        return HttpRequest.requestFunctions.RequestInternal(str1, arg1, arg2)
    end
})

local function useUserAvatarConfigurations(current: string?, tbl2)
    local bool1 = not tbl2 or tbl2.listenToProfileRefreshSignal ~= false or false
    local var2 = if tbl2 then tbl2.selectionTypes else userAvatarConfigurationsApi.DEFAULT_SELECTION_TYPES
    local var3 = useSignalState(ProfileRefreshSignal.getProfileRefreshSignal)
    local var4, var5 = React.useState(0)
    local var6 = React.useRef(0)

    React.useEffect(function()
        if not bool1 then
            return
        end
        if var3 > var6.current then
            var6.current = var3
            var5(function(arg1): number
                return arg1 + 1
            end)
        end
    end, { bool1, var3 })

    local var7, var8 = React.useState(tbl1)
    local var9, var10 = React.useState(nil)
    local var11, var12 = React.useState(true)
    local bool2, func1

    if FFlagRobloxSubscriptionOnboardingSheet then
        local var13
        bool2, var13 = React.useState(false)
        func1 = var13
    else
        bool2 = false
        func1 = function(_) end
    end
    local var13 = React.useRef(false)
    local var14 = React.useRef(nil)
    local var15 = React.useRef(var4)

    React.useEffect(function()
        local bool3 = false

        if current == nil then
            var13.current = false
            var14.current = nil
            var15.current = var4
            var8(tbl1)
            var10(nil)
            func1(false)
            var12(false)
            return
        end

        if var14.current ~= current then
            var13.current = false
            var14.current = current
            var8(tbl1)
            var10(nil)
            func1(false)
        end

        if var15.current ~= var4 then
            userAvatarConfigurationsCache.invalidate(current)
            var15.current = var4
        end

        if not var13.current then
            var12(true)
        end

        userAvatarConfigurationsCache.fetchCached(var1, current, var2):andThen(function(arg1)
            if bool3 then
                return
            end

            var8(arg1.parsed.closeupCameraConfig)
            var10(arg1.parsed.profileFrameAssetId)
            func1(false)
            var13.current = true
            var12(false)
        end):catch(function(_)
            if bool3 then
                return
            end

            func1(true)
            var13.current = true
            var12(false)
        end)

        return function()
            bool3 = true
        end
    end, { current, var4, var2 })

    return var7, var9, var11, bool2
end

return useUserAvatarConfigurations
