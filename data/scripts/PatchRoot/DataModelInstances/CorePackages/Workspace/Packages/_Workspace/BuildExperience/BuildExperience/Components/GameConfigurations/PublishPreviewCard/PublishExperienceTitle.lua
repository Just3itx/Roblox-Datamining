-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local VerifiedBadge = require(BuildExperienceParent.VerifiedBadges.VerifiedBadge)
local FFlagUnifyVerifiedBadgeComponent = require(BuildExperienceParent.SharedFlags).FFlagUnifyVerifiedBadgeComponent

local _chatTypes = require(BuildExperience.Chat.chatTypes)

local Icon = Foundation.Icon
local Image = Foundation.Image
local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant

local function getGameIconUrl(target) -- Luacid: Inlined by compiler; 1 call site recovered
    return target.gameIcon or `rbxthumb://type=GameIcon&id={target.universeId}&w=150&h=150`
end

local function PublishExperienceTitle(tbl1)
    local testId = tbl1.testId or "publish-experience-title"
    local target = tbl1.target
    local creatorName = target.creatorName or ""

    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "row align-y-center gap-medium size-full-0 auto-y",
        testId = testId
    }
    local tbl3 = {
        GameIcon = React.createElement(Image, {
            LayoutOrder = 1,
            Image = getGameIconUrl(target),
            ScaleType = Enum.ScaleType.Crop,
            tag = "size-1200-1200 radius-medium clip bg-surface-200",
            testId = `{testId}-game-icon`
        }),
        Details = 0
    }
    local createElement2 = React.createElement
    local var2 = View
    local tbl4 = { LayoutOrder = 2, tag = "col fill size-full-0 auto-y" }

    local tbl5 = {
        Title = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = target.experienceName,
            tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
        }),
        CreatorRow = 0
    }

    local createElement3 = React.createElement
    local var3 = View
    local tbl6 = { LayoutOrder = 2, tag = "row align-y-center gap-xsmall size-full-0 auto-y" }

    local tbl7 = {
        CreatorName = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = creatorName,
            tag = {
                ["text-body-medium text-align-x-left content-default"] = true,
                ["shrink auto-xy text-wrap"] = FFlagUnifyVerifiedBadgeComponent,
                ["fill auto-y text-wrap"] = not FFlagUnifyVerifiedBadgeComponent
            }
        }),
        VerifiedBadge = 0
    }
    local element

    if tbl1.isCreatorVerified ~= true then
        element = nil
    elseif FFlagUnifyVerifiedBadgeComponent then
        element = React.createElement(VerifiedBadge, { LayoutOrder = 2, testId = `{testId}-verified-badge` })
    else
        element = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "size-400-400",
                testId = `{testId}-verified-badge`
            },
            {
                Backplate = React.createElement(
                    Icon,
                    {
                        name = IconName.VerifiedBackplate,
                        size = IconSize.Small,
                        tag = "content-system-emphasis",
                        ZIndex = 1
                    }
                ),
                Check = React.createElement(
                    Icon,
                    {
                        name = IconName.VerifiedCheck,
                        size = IconSize.Small,
                        variant = IconVariant.Regular,
                        ZIndex = 2
                    }
                )
            }
        )
    end

    tbl7.VerifiedBadge = element
    tbl5.CreatorRow = createElement3(var3, tbl6, tbl7)
    tbl3.Details = createElement2(var2, tbl4, tbl5)
    return createElement(var1, tbl2, tbl3)
end

return PublishExperienceTitle
