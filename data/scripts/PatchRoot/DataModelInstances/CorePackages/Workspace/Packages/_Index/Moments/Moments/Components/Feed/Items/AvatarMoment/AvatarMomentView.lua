-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local FFlagProfileRenderAvatarMoments = require(MomentsParent.SharedFlags).FFlagProfileRenderAvatarMoments
local FFlagMomentsAvatarSceneStage = require(Moments.Flags.FFlagMomentsAvatarSceneStage)

local MomentItem = require(Moments.Components.Feed.Items.Moment.MomentItem)
local _MomentContext = require(Moments.Components.Feed.Items.Moment.MomentContext)
local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)
local _MomentsTypes = require(MomentsParent.MomentsTypes)

local function AvatarMomentView(tbl1)
    local element = React.createElement(MomentsCommon.Media.MomentMediaView, {
        momentId = tbl1.moment.momentId,
        suppressTapToToggle = true,
        getScaleType = GetMomentsPreferencesStore(false).getMediaScaleType
    })
    if FFlagMomentsAvatarSceneStage and tbl1.viewportFrameRef ~= nil then
        element = React.createElement(Foundation.View, {
            backgroundStyle = { Transparency = 1 },
            tag = "size-full"
        }, {
            SceneViewport = React.createElement(
                "ViewportFrame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    ZIndex = 0,
                    ref = tbl1.viewportFrameRef
                },
                {
                    WorldModel = React.createElement("WorldModel", { ref = tbl1.worldModelRef })
                }
            ),
            Media = element
        })
    end

    return React.createElement(Foundation.View, {
        backgroundStyle = { Transparency = 1 },
        tag = "size-full",
        ref = if FFlagProfileRenderAvatarMoments or FFlagMomentsAvatarSceneStage then tbl1.pageRef else nil
    }, {
        Moment = React.createElement(
            MomentItem,
            {
                data = tbl1.data,
                moment = tbl1.moment,
                mediaSurface = element,
                isStaticMedia = true,
                isWorkspaceRendered = true
            }
        )
    })
end

return AvatarMomentView
