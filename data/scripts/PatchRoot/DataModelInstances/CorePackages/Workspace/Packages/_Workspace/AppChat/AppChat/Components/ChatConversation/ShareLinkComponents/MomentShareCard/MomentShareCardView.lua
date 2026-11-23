-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)

local View = Foundation.View
local Image = Foundation.Image
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Skeleton = Foundation.Skeleton
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local Radius = Foundation.Enums.Radius

local FFlagAppChatMomentShareCardUseFoundationImage = require(AppChat.Flags.FFlagAppChatMomentShareCardUseFoundationImage)
local FFlagAppChatNativeFoundationCornerRadii = require(AppChat.Flags.FFlagAppChatNativeFoundationCornerRadii)
local FFlagAppChatMomentShareCardLoadingSkeletons = require(AppChat.Flags.FFlagAppChatMomentShareCardLoadingSkeletons)
local FFlagAppChatMomentShareCardHideMomentsGlyph = require(AppChat.Flags.FFlagAppChatMomentShareCardHideMomentsGlyph)

local var1 = FFlagAppChatNativeFoundationCornerRadii and FFlagAppChatMomentShareCardUseFoundationImage

local GameCardError = require(script.Parent.Parent.GameCardComponents.GameCardError)
local MomentDetailsStatus = require(script.Parent.MomentDetailsStatus)

local MomentShareCardUnavailable = require(script.Parent.MomentShareCardUnavailable)

local function toUDim(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if type(arg1) == "number" then
        return UDim.new(0, arg1)
    end

    return arg1
end

local function roundedCorner(cornerRadii)
    if cornerRadii == nil then
        return nil
    end
    return React.createElement("UICorner", {
        TopLeftRadius = toUDim(cornerRadii.topLeft),
        TopRightRadius = toUDim(cornerRadii.topRight),
        BottomLeftRadius = toUDim(cornerRadii.bottomLeft),
        BottomRightRadius = toUDim(cornerRadii.bottomRight)
    })
end

return React.memo(function(tbl1) -- name: MomentShareCardView
    if tbl1.status == MomentDetailsStatus.Error then
        return React.createElement(GameCardError)
    end

    if tbl1.status == MomentDetailsStatus.Unavailable or tbl1.status == MomentDetailsStatus.Locked then
        return React.createElement(MomentShareCardUnavailable)
    end

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        tag = "col auto-y",
        testId = "MomentShareCardView",
        Size = UDim2.fromOffset(tbl1.mediaSize, 0),
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = { MomentSharePlaceholder = 0, Footer = 0 }
    local createElement2 = React.createElement
    local var3 = View
    local tbl4 = {
        tag = "clip",
        testId = "MomentSharePlaceholder",
        Size = UDim2.fromOffset(tbl1.mediaSize, tbl1.mediaSize),
        LayoutOrder = 1
    }
    local tbl5 = { MomentShareCardPoster = 0, MomentSharePlayButton = 0, InteractionOverlay = 0 }
    local var4

    if tbl1.hasMedia then
        local createElement3 = React.createElement
        local var5 = View
        local tbl6 = { tag = "size-full", testId = "MomentShareCardPoster" }

        local tbl7 = { ShimmerClip = 0, Poster = 0 }
        local element

        if tbl1.isPosterLoaded then
            element = nil
        else
            element = React.createElement("CanvasGroup", {
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 1,
                [React.Tag] = "data-testid=MomentShareCardPosterShimmer"
            }, {
                Corner = roundedCorner(tbl1.cornerRadii),
                Shimmer = React.createElement(Skeleton, { radius = Radius.None, Size = UDim2.fromScale(1, 1) })
            })
        end

        tbl7.ShimmerClip = element
        local element2

        if tbl1.posterContent == nil then
            element2 = nil
        elseif var1 then
            element2 = React.createElement(Image, {
                tag = "size-full",
                ImageContent = tbl1.posterContent,
                ScaleType = Enum.ScaleType.Crop,
                ZIndex = 2,
                testId = "MomentShareCardPosterImage",
                cornerRadius = tbl1.cornerRadii
            })
        else
            element2 = React.createElement("ImageLabel", {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                ImageContent = tbl1.posterContent,
                ScaleType = Enum.ScaleType.Crop,
                ZIndex = 2,
                [React.Tag] = "data-testid=MomentShareCardPosterImage"
            }, {
                Corner = roundedCorner(tbl1.cornerRadii)
            })
        end

        tbl7.Poster = element2
        var4 = createElement3(var5, tbl6, tbl7)
    else
        var4 = nil
    end

    tbl5.MomentShareCardPoster = var4

    tbl5.MomentSharePlayButton = if tbl1.isVideo then React.createElement(
        View,
        {
            tag = "row align-x-center align-y-center position-center-center anchor-center-center size-1200-1200 radius-circle clip bg-over-media-0",
            testId = "MomentSharePlayButton",
            ZIndex = 2
        },
        {
            Glyph = React.createElement(Icon, { name = IconName.PlayLarge, size = IconSize.Medium, style = tbl1.playIconStyle })
        }
    ) else nil

    tbl5.InteractionOverlay = React.createElement(
        View,
        {
            tag = "size-full",
            testId = "MomentShareInteractionOverlay",
            onActivated = tbl1.onActivated,
            cornerRadius = if FFlagAppChatNativeFoundationCornerRadii then tbl1.cornerRadii else nil,
            selection = {
                Selectable = tbl1.selectable
            },
            ZIndex = 3
        },
        {
            Corner = if FFlagAppChatNativeFoundationCornerRadii then nil else roundedCorner(tbl1.cornerRadii)
        }
    )
    tbl3.MomentSharePlaceholder = createElement2(var3, tbl4, tbl5)

    local createElement3 = React.createElement
    local var5 = View
    local tbl6 = {
        tag = "col size-full-0 auto-y padding-medium",
        testId = "MomentShareFooter",
        LayoutOrder = 2
    }

    local tbl7 = { Username = 0, Metadata = 0 }
    local element

    if FFlagAppChatMomentShareCardLoadingSkeletons and tbl1.isUsernameLoading then
        element = React.createElement(View, {
            tag = "row align-y-center size-full-500",
            LayoutOrder = 1
        }, {
            Skeleton = React.createElement(
                Skeleton,
                {
                    Size = UDim2.fromScale(0.6, 1),
                    radius = Radius.Small,
                    testId = "MomentShareUsernameSkeleton"
                }
            )
        })
    elseif tbl1.username then
        element = React.createElement(FoundationText, {
            tag = "size-full-500 text-title-medium text-align-x-left text-truncate-end content-emphasis",
            Text = tbl1.username,
            LayoutOrder = 1
        })
    else
        element = nil
    end

    tbl7.Username = element
    local element2

    if tbl1.metadataText or FFlagAppChatMomentShareCardLoadingSkeletons and tbl1.isMetadataLoading then
        element2 = React.createElement(
            View,
            {
                tag = "row align-y-center gap-xsmall size-full-500",
                testId = "MomentShareMetadata",
                LayoutOrder = 2
            },
            {
                MomentsGlyph = if FFlagAppChatMomentShareCardHideMomentsGlyph then nil else React.createElement(
                    Icon,
                    {
                        name = IconName.Moments,
                        size = IconSize.Small,
                        testId = "MomentShareMomentsGlyph",
                        LayoutOrder = 1
                    }
                ),
                MetadataText = if FFlagAppChatMomentShareCardLoadingSkeletons and tbl1.isMetadataLoading then React.createElement(
                    Skeleton,
                    {
                        Size = UDim2.fromScale(0.7, 1),
                        radius = Radius.Small,
                        testId = "MomentShareMetadataSkeleton",
                        LayoutOrder = 2
                    }
                ) else React.createElement(FoundationText, {
                    tag = "fill auto-y text-body-medium text-align-x-left text-truncate-end content-default",
                    Text = tbl1.metadataText,
                    LayoutOrder = 2
                })
            }
        )
    else
        element2 = nil
    end

    tbl7.Metadata = element2
    tbl3.Footer = createElement3(var5, tbl6, tbl7)
    return createElement(var2, tbl2, tbl3)
end)
