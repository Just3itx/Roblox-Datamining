-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local FFlagMomentsRenderAvatarPostsInFeed = require(MomentsParent.SharedFlags).FFlagMomentsRenderAvatarPostsInFeed

local Badge = Foundation.Badge
local Chip = Foundation.Chip
local View = Foundation.View

local BadgeShape = Foundation.Enums.BadgeShape
local BadgeSize = Foundation.Enums.BadgeSize
local BadgeVariant = Foundation.Enums.BadgeVariant
local ChipSize = Foundation.Enums.ChipSize
local ChipVariant = Foundation.Enums.ChipVariant

local useLocalization = Localization.Hooks.useLocalization

local MomentContext = require(script.Parent.Parent.Parent.MomentContext)

local tbl1 = { partnerContent = "Feature.Moments.Label.RobloxPartnerContent" }

local function noop() end

return React.memo(function(tbl2) -- name: StatusChip
    local var1 = useLocalization(tbl1)
    local var2 = MomentContext.useMoment().store.getData(false)

    if var2.kind == "ad" then
        return React.createElement(View, {
            LayoutOrder = tbl2.LayoutOrder,
            tag = "row align-x-left auto-xy"
        }, {
            Chip = React.createElement(Chip, {
                text = "Ad",
                size = ChipSize.Small,
                variant = ChipVariant.Standard,
                trailing = {
                    iconName = BuilderIcons.Icon.CircleI,
                    onActivated = noop
                },
                onActivated = noop
            })
        })
    end

    if var2.kind == "experience" and var2.isOfficialContent then
        return nil
    end

    if not (if FFlagMomentsRenderAvatarPostsInFeed then var2.kind == "experience" and var2.isSponsored else var2.isSponsored == true) then
        return nil
    end

    local partnerContent = var1.partnerContent
    return React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        tag = "row align-x-left auto-xy"
    }, {
        Badge = React.createElement(Badge, {
            text = if partnerContent == nil or partnerContent == "" then "Roblox Partner Content" else partnerContent,
            variant = BadgeVariant.Neutral,
            size = BadgeSize.Small,
            shape = BadgeShape.Box
        })
    })
end)
