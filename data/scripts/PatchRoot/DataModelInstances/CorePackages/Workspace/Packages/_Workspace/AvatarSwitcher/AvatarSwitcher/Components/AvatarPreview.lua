-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")

local AvatarSwitcherParent = AvatarSwitcher.Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationCloudAssets = require(AvatarSwitcherParent.FoundationCloudAssets)
local useLocalization = require(AvatarSwitcherParent.Localization).Hooks.useLocalization
local sendAXCounterV2 = require(AvatarSwitcherParent.AvatarExperienceAnalytics).sendAXCounterV2

local OutfitViewport = require(AvatarSwitcher.Components.OutfitViewport.OutfitViewport)
local Constants = require(AvatarSwitcher.Constants)

local bool1 = game:DefineFastFlag("AvatarSwitcher3DPreview", false)

local FFlagAvatarSwitcherAccurateAvatarWarning = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherAccurateAvatarWarning
local FFlagAvatarSwitcherWarningLayoutFix = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherWarningLayoutFix
local FFlagAvatarSwitcherCounters = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherCounters
local FFlagAXBackgroundsInOutfitThumbnails = require(AvatarSwitcherParent.SharedFlags).FFlagAXBackgroundsInOutfitThumbnails

local tbl1 = {
    AVATAR = FoundationCloudAssets.Assets["pictograms/avatar"],
    AVATAR_ISSUE = FoundationCloudAssets.Assets["pictograms/avatar_issue"]
}

local function AvatarPreview(tbl2)
    local var1, var2 = React.useState(false)
    React.useEffect(function()
        var2(false)
    end, { tbl2.outfitId })

    local var3 = useLocalization({
        selectAvatar = "Feature.AvatarSwitcher.Message.SelectAvatar",
        unkownSupportHeader = "Feature.AvatarSwitcher.Heading.UnknownSupport",
        unkownSupportContent = "Feature.AvatarSwitcher.Message.UnknownSupport",
        partiallyUnsupported = "Feature.AvatarSwitcher.Message.PartiallyUnsupported"
    })

    local var4 = useTokens()

    if tbl2.outfitId == nil then
        return (React.createElement(Foundation.View, {
            tag = "size-full col align-x-center align-y-center",
            padding = {
                bottom = UDim.new(0, tbl2.messageBottomPadding or var4.Padding.Medium)
            }
        }, {
            Image = React.createElement(Foundation.Image, {
                Image = tbl1.AVATAR.assetId,
                Size = UDim2.fromOffset(tbl1.AVATAR.size.X / 3, tbl1.AVATAR.size.Y / 3),
                LayoutOrder = 1
            }),
            Text = React.createElement(Foundation.Text, { tag = "auto-xy text-title-medium", Text = var3.selectAvatar, LayoutOrder = 2 })
        }))
    end

    if tbl2.showAvatarSupportWarning then
        return (React.createElement(
            Foundation.View,
            {
                tag = "size-full",
                padding = {
                    bottom = UDim.new(0, tbl2.messageBottomPadding or var4.Padding.Medium)
                }
            },
            {
                ScrollView = React.createElement(Foundation.ScrollView, {
                    tag = "size-full",
                    scroll = {
                        CanvasSize = UDim2.fromScale(0, 1),
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        scrollBarVisibility = Foundation.Enums.ScrollBarVisibility.None
                    }
                }, {
                    ScrollingContent = React.createElement(Foundation.View, {
                        tag = "size-full col align-x-center align-y-center"
                    }, {
                        Image = React.createElement(Foundation.Image, {
                            Image = tbl1.AVATAR_ISSUE.assetId,
                            Size = UDim2.fromOffset(tbl1.AVATAR_ISSUE.size.X / 3, tbl1.AVATAR_ISSUE.size.Y / 3),
                            LayoutOrder = 1
                        }),
                        Header = React.createElement(Foundation.Text, {
                            tag = "auto-y size-full-0 text-title-medium text-wrap padding-bottom-small",
                            Text = var3.unkownSupportHeader,
                            LayoutOrder = 2
                        }),
                        Content = React.createElement(
                            Foundation.Text,
                            {
                                tag = "auto-y size-full-0 text-body-small text-wrap",
                                Text = var3.unkownSupportContent,
                                LayoutOrder = 3
                            }
                        )
                    })
                })
            }
        ))
    end

    if not bool1 or var1 then
        return (React.createElement(Foundation.Image, {
            tag = "size-full",
            Image = if FFlagAXBackgroundsInOutfitThumbnails then `rbxthumb://type=Outfit&id={tbl2.outfitId}&w=420&h=420&includeBackground=true` else `rbxthumb://type=Outfit&id={tbl2.outfitId}&w=420&h=420`,
            ScaleType = tbl2.imageScaleType
        }, {}))
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = { tag = "size-full col" }

    local tbl4 = { OutfitViewportContainer = 0, CompatibilityWarningContainer = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl5 = { tag = "size-full-0 grow", LayoutOrder = 1 }

    local tbl6 = {
        OutfitViewport = React.createElement(OutfitViewport, {
            outfitId = tbl2.outfitId,
            rigType = tbl2.rigType,
            onLoadingFailed = function()
                if FFlagAvatarSwitcherCounters then
                    sendAXCounterV2(Constants.Counters.AvatarPreviewLoadFailed)
                end
                var2(true)
            end,
            onLoaded = if FFlagAvatarSwitcherAccurateAvatarWarning then tbl2.onAvatarPreviewLoaded else nil
        })
    }

    tbl4.OutfitViewportContainer = createElement2(view2, tbl5, tbl6)

    tbl4.CompatibilityWarningContainer = not FFlagAvatarSwitcherWarningLayoutFix
        and tbl2.showAvatarTypeCompatibilityWarning
        and React.createElement(Foundation.View, {
            tag = "size-full-0 auto-y padding-y-medium",
            LayoutOrder = 2
        }, {
            InfoIcon = React.createElement(
                Foundation.Image,
                {
                    Image = "icons/actions/info",
                    Size = UDim2.fromOffset(var4.Size.Size_500, var4.Size.Size_500),
                    LayoutOrder = 1
                }
            ),
            CompatibilityWarning = React.createElement(Foundation.Text, {
                tag = "auto-y position-top-right anchor-top-right text-caption-small text-wrap text-align-x-left padding-top-xsmall",
                Size = UDim2.new(1, -var4.Size.Size_500 - var4.Gap.Small, 0, 0),
                Text = var3.partiallyUnsupported,
                LayoutOrder = 2
            })
        })
    return createElement(view, tbl3, tbl4)
end

return AvatarPreview
