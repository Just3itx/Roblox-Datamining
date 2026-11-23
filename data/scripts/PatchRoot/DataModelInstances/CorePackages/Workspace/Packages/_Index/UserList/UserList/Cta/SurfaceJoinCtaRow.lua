-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local FriendsCommon = require(UserListParent.FriendsCommon)
local DataHydration = require(UserListParent.DataHydration)
local Enums = require(UserList.Common.Enums)
local _Types = require(UserList.Common.Types)

local useGetPresenceByUserId = FriendsCommon.Hooks.useGetPresenceByUserId
local InGame = DataHydration.Presence.PresenceEnums.PresenceType.InGame
local useCtaForRow = require(UserList.Hooks.useCtaForRow)
local useProfileCta = require(UserList.Hooks.useProfileCta)
local composeCtaRow = require(script.Parent.composeCtaRow)
local FFlagUserListCanonicalCtaAnalytics = require(UserList.Flags.FFlagUserListCanonicalCtaAnalytics)

return React.memo(function(tbl1) -- name: SurfaceJoinCtaRow
    local id = tbl1.entity.id
    local ctaConfig = tbl1.ctaConfig
    local join = ctaConfig.join
    local var1, var2 = useProfileCta(id)
    local var3 = useGetPresenceByUserId(id)
    local universeId = if var3 then var3.universeId else nil
    local isInExperience = not (var3 == nil or var3.userPresenceType ~= InGame or universeId == nil) and universeId ~= ""
    local onActivated = join.onActivated
    local var4 = React.useMemo(function()
        return {
            joinExperience = function()
                onActivated(id)
            end,
            isInExperience = isInExperience,
            isLoading = false
        }
    end, { id, isInExperience, onActivated })

    local var5 = useCtaForRow

    local actionHandlers = tbl1.actionHandlers
    local index = if FFlagUserListCanonicalCtaAnalytics then tbl1.index else nil
    local var6 = var5(var1, var2, actionHandlers, id, ctaConfig, var4, index)

    local primaryCta = var6.primaryCta
    if primaryCta and primaryCta.type == Enums.ButtonTypes.Join and join.isVisible and not join.isVisible(var3) then
        primaryCta = nil
    end

    local isLoading = var6.isLoading
    if isLoading and join.isJoinExpected and not join.isJoinExpected(id, var3) then
        isLoading = false
    end

    return composeCtaRow(
        tbl1,
        ctaConfig,
        var3,
        {
            primaryCta = primaryCta,
            secondaryCta = var6.secondaryCta,
            isLoading = isLoading
        }
    )
end)
