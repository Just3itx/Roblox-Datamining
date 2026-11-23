-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local Foundation = require(UserListParent.Foundation)
local convertToFoundationPresenceEnum = require(UserListParent.SocialCommon).Utils.convertToFoundationPresenceEnum
local _Types = require(UserList.Common.Types)
local Enums = require(UserList.Common.Enums)
local useUserDataValues = require(UserList.Hooks.useUserDataValues)
local BaseRow = require(script.Parent.BaseRow)
local useIsRobloxSubscriber = require(UserListParent.UserProfiles).Hooks.useIsRobloxSubscriber
local FFlagEnableBlackbirdCheck = require(UserListParent.SharedFlags).FFlagEnableBlackbirdCheck

local FFlagUserListCtaIntegrationEnabled = require(UserListParent.SharedFlags).FFlagUserListCtaIntegrationEnabled
local FFlagUserListSurfaceExtensions = require(UserListParent.SharedFlags).FFlagUserListSurfaceExtensions

return React.memo(function(tbl1) -- name: UserRow
    local var1 = useUserDataValues(tbl1.entityId)
    local var2 = if FFlagEnableBlackbirdCheck then useIsRobloxSubscriber(if tbl1.entityId then tbl1.entityId else nil) else nil
    local combinedName = if var1.combinedName == "" then nil else var1.combinedName
    local var3 = not tbl1.configs or tbl1.configs.showSubtitle == nil or tbl1.configs.showSubtitle
    local text = if var1.username == "" then nil else `@{var1.username}`
    local subtitle = if var3 then text else nil
    local var6 = not tbl1.configs or tbl1.configs.showPresence == nil or tbl1.configs.showPresence

    local none = Foundation.Enums.UserPresence.None
    if var6 and tbl1.presence then
        none = convertToFoundationPresenceEnum(tbl1.presence)
    end

    local isTitleLoading = if tbl1.loadingState and tbl1.loadingState.title ~= nil then tbl1.loadingState.title else var1.isLoading
    local isSubtitleLoading = if tbl1.loadingState and tbl1.loadingState.subtitle ~= nil then tbl1.loadingState.subtitle else var1.isLoading
    local contextualInfo = tbl1.loadingState and tbl1.loadingState.contextualInfo
    local var4 = tbl1.configs and tbl1.configs.showUsernameAsContextualFallback and not tbl1.contextualInfo and {
        text = text
    }
        or tbl1.contextualInfo

    local createElement = React.createElement
    local var10 = BaseRow
    local tbl2 = {
        userId = tbl1.entityId,
        userPresenceType = none,
        title = combinedName,
        subtitle = subtitle,
        layoutMode = tbl1.layoutMode,
        onActivated = tbl1.onActivated,
        isTitleLoading = isTitleLoading,
        isSubtitleLoading = isSubtitleLoading,
        isContextualInfoLoading = contextualInfo,
        contextualInfo = var4,
        primaryCta = tbl1.primaryCta,
        secondaryCta = tbl1.secondaryCta,
        shouldShowNewIndicator = tbl1.shouldShowNewIndicator,
        ctaLoading = if FFlagUserListCtaIntegrationEnabled then tbl1.ctaLoading else nil,
        trailingContent = tbl1.trailingContent,
        layoutOrder = tbl1.layoutOrder,
        trustedConnectionIndicatorEnabled = not (FFlagUserListSurfaceExtensions and tbl1.configs and tbl1.configs.showTrustedFriendIndicator == false)
            and tbl1.layoutMode == Enums.RowLayoutMode.Wide,
        isRobloxSubscriber = 0,
        disableRowActivation = 0
    }

    if not FFlagEnableBlackbirdCheck then
        var2 = nil
    end

    tbl2.isRobloxSubscriber = var2
    tbl2.disableRowActivation = if FFlagUserListSurfaceExtensions and tbl1.configs then tbl1.configs.disableRowActivation else nil
    return createElement(var10, tbl2)
end)
