-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TiltLoadingScreen = script:FindFirstAncestor("TiltLoadingScreen")
local TiltLoadingScreenParentParent = TiltLoadingScreen.Parent.Parent

local React = require(TiltLoadingScreenParentParent.React)
local Foundation = require(TiltLoadingScreenParentParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local TiltKeyart = require(TiltLoadingScreen.Components.TiltKeyart)
local VerifiedBadge = require(TiltLoadingScreen.Components.VerifiedBadge)
local VerifiedBadge2 = require(TiltLoadingScreenParentParent.VerifiedBadges.VerifiedBadge)
local FFlagUnifyVerifiedBadgeComponent = require(TiltLoadingScreenParentParent.SharedFlags).FFlagUnifyVerifiedBadgeComponent
local Constants = require(TiltLoadingScreen.Constants)
local FFlagLoadingScreenMilestones = require(TiltLoadingScreenParentParent.SharedFlags).FFlagLoadingScreenMilestones

local _Types = require(TiltLoadingScreen.Types)

local TILT_DEGREES = Constants.KEYART.TILT_DEGREES

local tbl1 = {
    keyart = {
        rotation = React.createBinding(TILT_DEGREES),
        sizeScale = React.createBinding(1),
        coverTransparency = React.createBinding(1)
    },
    frame = {
        rotation = React.createBinding(-TILT_DEGREES),
        sizeScale = React.createBinding(1),
        groupTransparency = React.createBinding(0)
    },
    title = {
        reveal = React.createBinding(1),
        slide = React.createBinding(UDim.new(0, 0))
    },
    creator = {
        reveal = React.createBinding(1),
        slide = React.createBinding(UDim.new(0, 0))
    },
    verified = {
        reveal = React.createBinding(1)
    }
}

local function clamp01(num1: number): number -- Luacid: Inlined by compiler; 4 call sites recovered
    return math.clamp(num1, 0, 1)
end

local function clipWindowHeight(tbl2): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return math.ceil(tbl2.FontSize * tbl2.LineHeight)
end

local function clippingFromReveal(reveal) -- Luacid: Inlined by compiler; 2 call sites recovered
    return reveal:map(function(num1: number): boolean
        return num1 < 0.999
    end)
end

return React.memo(function(arg1) -- name: TiltLockup
    local var1 = useTokens()
    local var2 = arg1.animation or tbl1

    local color3 = var1.Color.Content.Emphasis.Color3
    local color3_2 = var1.Color.Content.Default.Color3
    local color3_3 = var1.Color.System.Emphasis.Color3
    local yOffset = clipWindowHeight(var1.Typography.HeadingLarge)
    local yOffset2 = clipWindowHeight(var1.Typography.BodyMedium)
    local clipsDescendants = clippingFromReveal(var2.title.reveal)
    local var3 = clippingFromReveal(var2.creator.reveal)

    local textStyle = var2.title.reveal:map(function(num1: number)
        return {
            Color3 = color3,
            Transparency = 1 - clamp01(num1)
        }
    end)
    local var4 = var2.creator.reveal:map(function(num1: number)
        return {
            Color3 = color3_2,
            Transparency = 1 - clamp01(num1) * 0.6
        }
    end)
    local backplateStyle = var2.verified.reveal:map(function(num1: number)
        return {
            Color3 = color3_3,
            Transparency = 1 - clamp01(num1)
        }
    end)
    local checkStyle = var2.verified.reveal:map(function(num1: number)
        return {
            Color3 = var1.Color.Content.Emphasis.Color3,
            Transparency = 1 - clamp01(num1)
        }
    end)

    local thumbnailUrl = arg1.thumbnailUrl or ""

    local key = if FFlagLoadingScreenMilestones then "Card_" .. thumbnailUrl else "Card"
    local textWidthScale = arg1.textWidthScale or 0.8

    local createElement = React.createElement
    local var10 = View
    local tbl2 = { tag = "col align-x-center gap-large size-full-0 auto-y", testId = "tilt-lockup" }

    local tbl3 = { ArtTitle = 0 }
    local createElement2 = React.createElement
    local var11 = View
    local tbl4 = { tag = "col align-x-center gap-small size-full-0 auto-y", LayoutOrder = 1 }

    local tbl5 = {
        Card = React.createElement(TiltKeyart, {
            key = key,
            thumbnailUrl = thumbnailUrl,
            onThumbnailLoaded = arg1.onThumbnailLoaded,
            keyart = var2.keyart,
            frame = var2.frame
        }),
        TitleCreator = 0
    }
    local createElement3 = React.createElement
    local var12 = View
    local tbl6 = {
        tag = "col align-x-center gap-xsmall auto-y padding-y-xsmall",
        Size = UDim2.new(textWidthScale, 0, 0, 0),
        LayoutOrder = 2
    }
    local tbl7 = {
        TitleWrap = React.createElement(View, {
            ClipsDescendants = clipsDescendants,
            Size = UDim2.new(1, 0, 0, yOffset),
            padding = {
                top = var2.title.slide
            },
            LayoutOrder = 1
        }, {
            Title = React.createElement(FoundationText, {
                tag = "size-full text-heading-large text-no-wrap text-align-x-center text-align-y-center text-truncate-end",
                Text = arg1.gameName or "",
                textStyle = textStyle
            })
        }),
        SubWrap = 0
    }

    local createElement4 = React.createElement
    local var13 = View
    local tbl8 = {
        tag = "col align-x-center align-y-center",
        ClipsDescendants = var3,
        Size = UDim2.new(1, 0, 0, yOffset2),
        padding = {
            top = var2.creator.slide
        },
        LayoutOrder = 2
    }
    local tbl9 = {
        Row = React.createElement(View, {
            tag = "row align-x-center align-y-center gap-xsmall size-full-0 auto-y"
        }, {
            Author = React.createElement(FoundationText, {
                tag = "shrink auto-xy text-body-medium text-no-wrap text-truncate-end",
                Text = arg1.creatorName or "",
                textStyle = var4,
                LayoutOrder = 1
            }),
            Verified = if arg1.isCreatorVerified then if FFlagUnifyVerifiedBadgeComponent then React.createElement(
                VerifiedBadge2,
                {
                    backplateStyle = backplateStyle,
                    checkStyle = checkStyle,
                    LayoutOrder = 2,
                    testId = "tilt-verified-badge"
                }
            ) else React.createElement(VerifiedBadge, { backplateStyle = backplateStyle, checkStyle = checkStyle, LayoutOrder = 2 }) else nil
        })
    }
    tbl7.SubWrap = createElement4(var13, tbl8, tbl9)
    tbl5.TitleCreator = createElement3(var12, tbl6, tbl7)
    tbl3.ArtTitle = createElement2(var11, tbl4, tbl5)
    return createElement(var10, tbl2, tbl3)
end)
