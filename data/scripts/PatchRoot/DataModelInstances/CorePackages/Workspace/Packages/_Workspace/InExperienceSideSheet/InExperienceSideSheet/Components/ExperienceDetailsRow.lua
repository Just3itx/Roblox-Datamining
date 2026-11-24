-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local Foundation = require(InExperienceSideSheetParent.Foundation)
local React = require(InExperienceSideSheetParent.React)
local VerifiedBadge = require(InExperienceSideSheetParent.VerifiedBadges.VerifiedBadge)

local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local UnibarList = require(InExperienceSideSheet.Components.UnibarList)

local useExperienceDetails = require(InExperienceSideSheet.Hooks.useExperienceDetails)
local useExperienceIcon = require(InExperienceSideSheet.Hooks.useExperienceIcon)

return React.memo(function(tbl1) -- name: ExperienceDetailsRow
    local var1 = useTokens()

    local var2, var3, var4 = useExperienceDetails()
    local image = useExperienceIcon()

    local var6 = var1.Padding.XXSmall * 2
    local yOffset = var1.Typography.TitleMedium.LineHeight * var1.Typography.TitleMedium.FontSize - var6
    local yOffset2 = var1.Typography.BodyMedium.LineHeight * var1.Typography.BodyMedium.FontSize - var6
    local experienceNameSkeleton = if var2 or not var4 then nil else React.createElement(
        View,
        { LayoutOrder = 1, tag = "size-full-0 auto-y padding-y-xxsmall" },
        {
            Skeleton = React.createElement(
                Skeleton,
                {
                    Size = UDim2.new(1, 0, 0, yOffset),
                    radius = Radius.Small,
                    testId = "experience-name-placeholder"
                }
            )
        }
    )
    local name = if var3 then var3.name else nil
    local bool1 = if var3 then var3.hasVerifiedBadge == true else false
    local element2

    if name ~= nil and name ~= "" then
        element2 = React.createElement(View, {
            LayoutOrder = 2,
            tag = "row align-y-center gap-xsmall size-full-0 auto-y"
        }, {
            CreatorName = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = name,
                tag = "shrink auto-xy text-body-medium text-align-x-left text-truncate-end content-default"
            }),
            VerifiedBadge = if bool1 then React.createElement(VerifiedBadge, { LayoutOrder = 2, testId = "experience-creator-verified-badge" }) else nil
        })
    elseif var4 then
        element2 = React.createElement(View, {
            LayoutOrder = 2,
            tag = "size-full-0 auto-y padding-y-xxsmall"
        }, {
            Skeleton = React.createElement(
                Skeleton,
                {
                    Size = UDim2.new(1, 0, 0, yOffset2),
                    radius = Radius.Small,
                    testId = "experience-publisher-placeholder"
                }
            )
        })
    else
        element2 = nil
    end

    return React.createElement(
        View,
        {
            tag = "row align-y-center gap-small size-full-0 auto-y padding-y-large",
            LayoutOrder = tbl1.layoutOrder
        },
        {
            Leading = React.createElement(View, {
                tag = "row align-y-center fill gap-medium auto-y",
                LayoutOrder = 1
            }, {
                ExperienceIconContainer = React.createElement(View, {
                    tag = "size-1000",
                    LayoutOrder = 1
                }, {
                    ExperienceIcon = image and React.createElement(Image, { Image = image, tag = "size-full radius-small" }),
                    ExperienceIconSkeleton = not image and React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1), radius = Radius.Small })
                }),
                ExperienceNameContainer = React.createElement(View, {
                    tag = "col fill gap-none auto-y",
                    LayoutOrder = 2
                }, {
                    ExperienceName = var2
                        and React.createElement(FoundationText, {
                            LayoutOrder = 1,
                            Text = var2,
                            tag = "size-full-0 auto-y text-title-medium text-align-x-left text-truncate-split content-emphasis"
                        }),
                    ExperienceNameSkeleton = experienceNameSkeleton,
                    CreatorRow = element2
                })
            }),
            UnibarList = React.createElement(UnibarList, { layoutOrder = 3 })
        }
    )
end)
