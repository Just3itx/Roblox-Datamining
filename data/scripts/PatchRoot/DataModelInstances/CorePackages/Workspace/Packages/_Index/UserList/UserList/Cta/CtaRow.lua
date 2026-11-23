-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local FriendsCommon = require(UserListParent.FriendsCommon)
local SocialExperienceJoin = require(UserListParent.SocialExperienceJoin)
local _Types = require(UserList.Common.Types)

local useGetPresenceByUserId = FriendsCommon.Hooks.useGetPresenceByUserId
local useJoinUserInExperience = SocialExperienceJoin.useJoinUserInExperience
local useCtaForRow = require(UserList.Hooks.useCtaForRow)
local useProfileCta = require(UserList.Hooks.useProfileCta)
local composeCtaRow = require(script.Parent.composeCtaRow)
local FFlagUserListCanonicalCtaAnalytics = require(UserList.Flags.FFlagUserListCanonicalCtaAnalytics)
local FFlagUserListSurfaceExtensions = require(UserListParent.SharedFlags).FFlagUserListSurfaceExtensions
local FFlagUserListSurfacePresenceWins = require(UserListParent.SharedFlags).FFlagUserListSurfacePresenceWins

return React.memo(function(tbl1) -- name: CtaRow
    local id = tbl1.entity.id
    local var1, var2 = useProfileCta(id)
    local presence = useGetPresenceByUserId(id)
    local var4 = useJoinUserInExperience(id, { presence = presence })

    local var5 = useCtaForRow(
        var1,
        var2,
        tbl1.actionHandlers,
        id,
        tbl1.ctaConfig,
        var4,
        if FFlagUserListCanonicalCtaAnalytics then tbl1.index else nil
    )

    if FFlagUserListSurfaceExtensions then
        return composeCtaRow(tbl1, tbl1.ctaConfig, presence, var5)
    end

    local ctaConfig = tbl1.ctaConfig
    local bool1 = not (ctaConfig == nil or ctaConfig.showLoadingPlaceholder == false) and ctaConfig.primaryCtaMinWidth ~= nil
    local ctaLoading = var5.isLoading
        and bool1
        and ctaConfig
        and {
            minWidth = ctaConfig.primaryCtaMinWidth,
            maxWidth = ctaConfig.primaryCtaMaxWidth
        }
        or nil

    local renderRow = tbl1.renderRow
    if not renderRow then
        return tbl1.createRow({
            presence = if presence then presence.userPresenceType else nil,
            primaryCta = var5.primaryCta,
            secondaryCta = var5.secondaryCta,
            ctaLoading = ctaLoading
        })
    end

    local createRow = tbl1.createRow
    return renderRow(function(arg1)
        local var7 = table.clone(arg1)
        var7.presence = if presence then presence.userPresenceType else nil
        if FFlagUserListSurfacePresenceWins and arg1.presence ~= nil then
            var7.presence = arg1.presence
        end
        var7.primaryCta = var5.primaryCta
        var7.secondaryCta = var5.secondaryCta
        var7.ctaLoading = ctaLoading
        return createRow(var7)
    end, tbl1.entity, tbl1.index or 0)
end)
