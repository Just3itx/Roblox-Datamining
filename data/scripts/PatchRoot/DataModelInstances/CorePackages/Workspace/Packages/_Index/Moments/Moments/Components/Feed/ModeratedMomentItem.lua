-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Players = game:GetService("Players")

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)

local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local View = Foundation.View
local FoundationText = Foundation.Text

local useImageLoadingState = MomentsCommon.Hooks.useImageLoadingState
local useLocalization = Localization.Hooks.useLocalization

local Constants = require(Moments.Constants)

local tbl1 = {
    moderatedBody = "Feature.Moments.Label.ModeratedRodeoBody",
    unavailableBody = "Feature.Moments.Label.MomentUnavailableDefault"
}

local function ModeratedMomentItem(tbl2)
    local var1 = useLocalization(tbl1)
    local localPlayer = Players.LocalPlayer
    local userId = if localPlayer then localPlayer.UserId else nil

    local var2 = React.useMemo(function(): boolean
        return not (userId == nil) and tbl2.creatorId == userId
    end, { tbl2.creatorId, userId or false })

    local image = "rbxthumb://type=Asset&id=" .. tbl2.moment.assetId .. "&w=480&h=270"
    local var4 = useImageLoadingState(if var2 then image else nil)
    local element = if var2 then React.createElement(
        Image,
        {
            Size = UDim2.fromScale(1, 1),
            ScaleType = Enum.ScaleType.Crop,
            Image = image
        },
        {
            Skeleton = if var4 then nil else React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1) })
        }
    ) else nil
    local createElement = React.createElement
    local var5 = View
    local tbl3 = { tag = "position-center-center anchor-center-center size-full" }

    local tbl4 = { OverlayText = 0, Overlay = 0, Content = 0 }
    local createElement2 = React.createElement
    local var6 = View
    local tbl5 = {
        sizeConstraint = {
            MaxSize = Constants.MaxSize.BottomUI
        },
        tag = "col flex-evenly align-x-center position-center-center anchor-center-center size-full padding-xlarge",
        testId = "--moments-moderated-overlay-text",
        ZIndex = 3
    }

    local tbl6 = {
        Text = React.createElement(
            FoundationText,
            {
                Text = if var2 then var1.moderatedBody else var1.unavailableBody,
                tag = "auto-xy text-wrap",
                LayoutOrder = 1
            }
        )
    }
    tbl4.OverlayText = createElement2(var6, tbl5, tbl6)

    tbl4.Overlay = React.createElement(View, { tag = "position-center-center anchor-center-center size-full bg-over-media-0", ZIndex = 2 })

    tbl4.Content = element
    return createElement(var5, tbl3, tbl4)
end

return ModeratedMomentItem
