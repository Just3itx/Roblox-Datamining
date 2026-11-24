-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent
local React = require(GameInviteParent.React)
local useLocalization = require(GameInviteParent.Localization).Hooks.useLocalization
local MarketplaceService = game:GetService("MarketplaceService")
local Foundation = require(GameInviteParent.Foundation)
local IconButton = Foundation.IconButton
local IconSize = Foundation.Enums.IconSize
local GameInviteRewardsInfoModal = require(GameInvite.Components.GameInviteRewardsInfoModal)
local GroupService = game:GetService("GroupService")
local Players = game:GetService("Players")

local function func1(creatorId: number)
    local str1 = ""
    if creatorId == nil or creatorId == 0 then
        return ""
    end
    if game.CreatorType == Enum.CreatorType.Group then
        local success, result = pcall(function()
            return GroupService:GetGroupInfoAsync(creatorId)
        end)

        if result then
            return result.Name
        end

        str1 = if success then str1 else ""
    elseif game.CreatorType == Enum.CreatorType.User then
        local success, result = pcall(function(): string
            return Players:GetNameFromUserIdAsync(creatorId)
        end)

        str1 = if success then result else ""
    end

    return str1
end

return function(tbl1)
    local var1 = useLocalization({
        rewardsModalTitle = "Roblox.ReferralRewards.RewardBannerModalTitle",
        rewardsHeader = {
            "Roblox.ReferralRewards.RewardBannerHeader",
            rewardName = tbl1.rewardMetadata and tbl1.rewardMetadata.name or ""
        },
        rewardsBody = {
            "Roblox.ReferralRewards.RewardBannerBody",
            gameName = if game.PlaceId == nil or game.PlaceId == 0 then "" else MarketplaceService:GetProductInfoAsync(game.PlaceId).Name,
            rewardName = tbl1.rewardMetadata and tbl1.rewardMetadata.name or ""
        },
        rewardsDetailsTitle = "Roblox.ReferralRewards.RewardBannerModalRewardDetails",
        rewardsLimitsTitle = "Roblox.ReferralRewards.AdditionalCreatorTerms",
        rewardsCreatorSupportText = {
            "Roblox.ReferralRewards.RewardBannerModalCreatorSupport",
            creatorName = if game.CreatorId == nil or game.CreatorId == 0 then "" else func1(game.CreatorId) or ""
        },
        rewardsExpiresText = "Roblox.ReferralRewards.Expires",
        rewardsTerms = "Roblox.ReferralRewards.ReferralProgramTerms"
    })

    local modalOpen, setModalOpen = React.useState(false)
    local createElement = React.createElement
    local fragment = React.Fragment
    local var4 = nil
    local tbl2 = { RewardInfoModal = 0, RewardBannerContainer = 0 }
    local element

    if modalOpen and tbl1.rewardMetadata and var1 then
        element = React.createElement(GameInviteRewardsInfoModal, {
            title = var1.rewardsModalTitle,
            rewardDetailsTitle = var1.rewardsDetailsTitle,
            rewardDetailsBody = tbl1.rewardMetadata.description or "",
            rewardLimitsTitle = var1.rewardsLimitsTitle,
            rewardLimitsBody = tbl1.rewardMetadata.limits or "",
            rewardCreatorSupportText = var1.rewardsCreatorSupportText,
            rewardsExpiresText = var1.rewardsExpiresText,
            rewardsTerms = var1.rewardsTerms,
            expiryUtc = tbl1.rewardMetadata.rewardTimeOffset.endUtc or "",
            modalOpen = modalOpen,
            setModalOpen = setModalOpen
        })
            or nil
    else
        element = nil
    end

    tbl2.RewardInfoModal = element

    local createElement2 = React.createElement
    local view = Foundation.View
    local tbl3 = {
        tag = "row padding-x-xxlarge size-full-0 auto-y items-center",
        layoutOrder = tbl1.layoutOrder
    }
    local tbl4 = { RewardBannerCard = 0 }
    local createElement3 = React.createElement
    local view2 = Foundation.View
    local tbl5 = {
        tag = "row size-full-0 auto-y wrap bg-surface-300 gap-medium padding-medium radius-medium align-y-top"
    }
    local tbl6 = { RewardIcon = 0, RewardTextContainer = 0, RewardInfoButtonView = 0 }
    local element2

    if tbl1.rewardMetadata and tbl1.rewardMetadata.iconAssetId ~= nil and tbl1.rewardMetadata.iconAssetId ~= "" then
        element2 = React.createElement(Foundation.Image, {
            Image = "rbxassetid://" .. tbl1.rewardMetadata.iconAssetId,
            tag = "col shrink size-1200-1200 radius-medium self-end",
            LayoutOrder = 0
        })
            or nil
    else
        element2 = nil
    end

    tbl6.RewardIcon = element2

    tbl6.RewardTextContainer = React.createElement(
        Foundation.View,
        { tag = "col fill auto-xy items-start", LayoutOrder = 1 },
        {
            Text = React.createElement(
                Foundation.Text,
                {
                    tag = "auto-xy text-title-medium text-wrap text-align-x-left",
                    Text = var1.rewardsHeader,
                    LayoutOrder = 0
                }
            ),
            Subtext = React.createElement(
                Foundation.Text,
                {
                    tag = "auto-xy text-body-small text-wrap text-align-x-left",
                    Text = var1.rewardsBody,
                    LayoutOrder = 1
                }
            )
        }
    )

    tbl6.RewardInfoButtonView = React.createElement(Foundation.View, {
        tag = "col auto-xy items-end",
        LayoutOrder = 2
    }, {
        RewardInfoButton = React.createElement(IconButton, {
            testId = "RewardInfoButton",
            icon = "icons/actions/info_small",
            size = IconSize.Small,
            onActivated = function()
                setModalOpen(true)
            end
        })
    })

    tbl4.RewardBannerCard = createElement3(view2, tbl5, tbl6)
    tbl2.RewardBannerContainer = createElement2(view, tbl3, tbl4)
    return createElement(fragment, var4, tbl2)
end
