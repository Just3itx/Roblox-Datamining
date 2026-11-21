-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local HttpService = game:GetService("HttpService")
local EditProfileParent = EditProfile.Parent
local FFlagUserProfilePlatformProfile = require(EditProfileParent.SharedFlags).FFlagUserProfilePlatformProfile
local React = require(EditProfileParent.React)
local RoactNavigation = require(EditProfileParent.RoactNavigation)
local JavascriptHybrid = require(EditProfile.Common.Constants).JavascriptHybrid
local UrlBuilder = require(EditProfileParent.UrlBuilder).UrlBuilder

local UserProfiles = require(EditProfileParent.UserProfiles)
local useLocalUserId = require(EditProfileParent.RobloxAppHooks).useLocalUserId
local useLocalization = require(EditProfileParent.Localization).Hooks.useLocalization
local TextKeys = require(EditProfile.Common.TextKeys)

local Analytics = require(EditProfile.Analytics)
local EventNames = Analytics.EventNames

local useAnalytics = Analytics.useAnalytics

return RoactNavigation.withNavigation(function(tbl1) -- name: EditUsernameWrapper
    local var1 = useLocalUserId()
    local var2 = UserProfiles.Hooks.useUserProfilesFetch({
        userIds = { var1 },
        query = if FFlagUserProfilePlatformProfile then UserProfiles.Queries.userProfilesBasicNamesByUserIds else UserProfiles.Queries.userProfilesAllNamesByUserIds
    })

    local var3 = useLocalization({ updated = TextKeys.UsernameUpdated })

    local var4 = useAnalytics()

    local function getFeatureStringFromHybridEvent(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
        if arg1.moduleID == JavascriptHybrid.Module.Navigation
            and arg1.functionName == JavascriptHybrid.Function.navigateToFeature
            and arg1.params
            and arg1.params.params
        then
            return arg1.params.params.feature
        end

        return nil
    end

    local function isCloseEditUsername(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return getFeatureStringFromHybridEvent(arg1) == JavascriptHybrid.Feature.CloseUpdateUsernameModal
    end

    local function isCompletedEditUsername(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return getFeatureStringFromHybridEvent(arg1) == JavascriptHybrid.Feature.UpdateUsernameModalSuccess
    end

    local function updateUsername() -- Luacid: Inlined by compiler; 1 call site recovered
        var2.refetch()

        var4.fireAnalyticsEvent(EventNames.UsernameSaved)
    end

    return React.createElement(tbl1.BrowserWrapperComponent, {
        isVisible = true,
        webViewVisible = true,
        modal = false,
        url = UrlBuilder.static.settings.account() .. "?changeusername",
        isGenericWebview = true,
        javaScriptCallback = function(input: string)
            local var5 = HttpService:JSONDecode(input)

            if not isCompletedEditUsername(var5) then
                if isCloseEditUsername(var5) then
                    tbl1.navigation.goBack()
                end
                return
            end

            updateUsername()

            if tbl1.onUsernameChanged then
                tbl1.onUsernameChanged()
            end
            tbl1.navigation.goBack()
            tbl1.showToast(var3.updated)
        end
    })
end)
