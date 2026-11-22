-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent
local Foundation = require(MomentsCommonParent.Foundation)

local React = require(MomentsCommonParent.React)

local MomentMediaView = require(script.Parent.MomentMediaView)
local _MediaTypes = require(script.Parent.Parent.MediaTypes)
local useVideoPosterFrame = require(script.Parent.Parent.useVideoPosterFrame)

local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius

local function MomentMediaTile(tbl1)
    local mediaItem = tbl1.mediaItem
    local cornerRadius = mediaItem.cornerRadius
    local bool1 = mediaItem.captureType == Enum.CaptureType.Video
    local content = if bool1 then mediaItem.content else nil
    local var1 = useVideoPosterFrame(content)

    if not bool1 then
        var1 = mediaItem.posterContent
    end
    if tbl1.isActive and bool1 then
        return React.createElement(MomentMediaView, {
            momentId = mediaItem.momentId,
            posterContent = var1,
            cornerRadius = cornerRadius,
            suppressTapToToggle = true,
            holdPosterUntilPlaying = true,
            tag = "size-full clip"
        })
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    }
    local tbl3 = {
        Shimmer = React.createElement(
            Skeleton,
            {
                radius = if cornerRadius then Radius.Large else Radius.None,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 1
            }
        ),
        Poster = 0
    }
    local element

    if var1 == nil then
        element = nil
    else
        element = React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            ImageContent = var1,
            ScaleType = Enum.ScaleType.Crop,
            ZIndex = 2
        }, {
            Corner = if cornerRadius == nil then nil else React.createElement("UICorner", { CornerRadius = UDim.new(0, cornerRadius) })
        })
    end

    tbl3.Poster = element
    return createElement(str1, tbl2, tbl3)
end

return MomentMediaTile
