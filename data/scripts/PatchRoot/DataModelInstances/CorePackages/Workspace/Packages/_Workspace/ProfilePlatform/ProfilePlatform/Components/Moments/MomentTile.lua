-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local MomentsCommon = require(ProfilePlatformParent.MomentsCommon)
local _MomentsStoreTypes = require(ProfilePlatformParent.DataHydration.MomentsStoreTypes)
local ToMediaItem = require(ProfilePlatformParent.Moments.ToMediaItem)
local useSceneOutfitMediaItem = require(script.Parent.useSceneOutfitMediaItem)
local SceneOutfitPoster = require(script.Parent.SceneOutfitPoster)
local FFlagProfileMomentSceneOutfitPoster = require(ProfilePlatformParent.SharedFlags).FFlagProfileMomentSceneOutfitPoster
local FFlagMomentsPostFeedback = require(ProfilePlatformParent.SharedFlags).FFlagMomentsPostFeedback
local PostStatusBadge = require(ProfilePlatformParent.Moments.PostStatusBadge)

local useExperienceName = require(ProfilePlatform.Hooks.useExperienceName)

local View = Foundation.View
local FoundationText = Foundation.Text
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useTokens = Foundation.Hooks.useTokens

local MomentMediaTile = MomentsCommon.Media.MomentMediaTile

local function MomentTile(tbl1)
    local moment = tbl1.moment
    local var1 = useTokens()

    local var2 = useExperienceName(moment.metadata.universeId)

    local var3 = React.useMemo(function()
        local var3 = ToMediaItem({ kind = "moment", moment = moment })

        var3.cornerRadius = var1.Radius.Large
        return var3
    end, { moment.momentId })

    local var4 = if FFlagProfileMomentSceneOutfitPoster then useSceneOutfitMediaItem(moment, var3) else nil
    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        Size = tbl1.itemSize,
        onActivated = tbl1.onActivated,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        tag = "col gap-xsmall"
    }
    local tbl3 = { MediaContainer = 0, Footer = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        LayoutOrder = 1,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, -48 - var1.Gap.XSmall),
        ClipsDescendants = true
    }
    local tbl5 = {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Large) }),
        Media = 0,
        ScenePoster = 0,
        StatusBadge = 0
    }
    local createElement3 = React.createElement
    local var6 = MomentMediaTile
    local tbl6 = { mediaItem = 0, isActive = 0 }
    if var4 ~= nil then
        var3 = var4.mediaItem
    end

    tbl6.mediaItem = var3
    tbl6.isActive = tbl1.isActive
    tbl5.Media = createElement3(var6, tbl6)

    tbl5.ScenePoster = if var4 == nil or var4.scenePoster == nil then nil else React.createElement(SceneOutfitPoster, { content = var4.scenePoster, cornerRadius = var1.Radius.Large, zIndex = 2 })

    tbl5.StatusBadge = if FFlagMomentsPostFeedback then React.createElement(PostStatusBadge, { momentId = moment.momentId, ZIndex = 3 }) else nil
    tbl3.MediaContainer = createElement2(str1, tbl4, tbl5)

    tbl3.Footer = React.createElement(
        View,
        {
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, 48),
            tag = "col align-x-left align-y-top gap-xxsmall"
        },
        {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                tag = "size-full-0 auto-y text-align-x-left text-truncate-end",
                fontStyle = var1.Typography.TitleMedium,
                textStyle = var1.Color.Content.Emphasis,
                Text = moment.metadata.experienceName or var2 or ""
            })
        }
    )
    return createElement(var5, tbl2, tbl3)
end

return MomentTile
