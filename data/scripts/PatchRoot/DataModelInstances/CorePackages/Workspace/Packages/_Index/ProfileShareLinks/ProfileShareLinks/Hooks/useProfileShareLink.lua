-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileShareLinks = script:FindFirstAncestor("ProfileShareLinks")
local ProfileShareLinksParent = ProfileShareLinks.Parent

local default = require(ProfileShareLinksParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local React = require(ProfileShareLinksParent.React)
local RoactUtils = require(ProfileShareLinksParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffectOnce = RoactUtils.Hooks.useEffectOnce
local SetCurrentToastMessage = require(ProfileShareLinksParent.ToastRodux).Actions.SetCurrentToastMessage
local _SocialLuaAnalytics = require(ProfileShareLinksParent.SocialLuaAnalytics)

local ProfileSharePolicyEnum = require(ProfileShareLinks.Enums.ProfileSharePolicyEnum)
local useGetOrGenerateLinkUrl = require(ProfileShareLinks.Hooks.useGetOrGenerateLinkUrl)
local useShortUrl = require(ProfileShareLinks.Hooks.useShortUrl)
local useProfileSharePolicy = require(ProfileShareLinks.Hooks.useProfileSharePolicy)
local useAnalytics = require(ProfileShareLinks.Analytics.useAnalytics)
local EventNames = require(ProfileShareLinks.Analytics.EventNames)
local TextKeys = require(ProfileShareLinks.Common.TextKeys)

return function(tbl1)
    local var1 = tbl1.enableFetch == nil or tbl1.enableFetch
    local var2 = useAnalytics()
    local var3 = useDispatch()
    local var4 = useProfileSharePolicy()
    local var5 = useGetOrGenerateLinkUrl()
    local var6 = useShortUrl()
    local hasLoaded = var6 ~= nil

    local var7 = useEffectOnce

    local bool2 = not hasLoaded

    if bool2 then
        if var4 == ProfileSharePolicyEnum.Disabled then
            var1 = false
        end
    else
        var1 = bool2
    end

    var7(var5, var1)

    return {
        hasLoaded = hasLoaded,
        policy = var4,
        onActivated = React.useCallback(function()
            if var4 == ProfileSharePolicyEnum.Disabled or var6 == nil then
                return
            end

            local stamp = tostring(DateTime.now().UnixTimestampMillis)
            local url = `{var6}&source=ProfileShare&stamp={stamp}`
            var2.fireAnalyticsEvent(
                EventNames.ProfileShareLinkActivated,
                {
                    context = tbl1.context,
                    shareType = var4,
                    stamp = stamp
                }
            )
            default:shareUrl({ context = tbl1.context, url = url })

            if var4 == ProfileSharePolicyEnum.Copy then
                var3(SetCurrentToastMessage({ toastMessage = TextKeys.LinkCopied }))
            end
        end, {
            var4,
            var6,
            tbl1.context,
            var2,
            var3
        })
    }
end
