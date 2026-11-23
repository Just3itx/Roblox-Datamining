-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)

local Frame = require(AppChat.Components.Common.Frame)
local AvatarThumbnail = require(script.Parent.AvatarThumbnail)
local CircleMask = require(script.Parent.CircleMask)

local ImageSetLabel = require(AppChatParent.UIBlox).Core.ImageSet.ImageSetLabel

local function AvatarOneToOne(tbl1)
    local element

    if tbl1.showNewPresenceImage then
        element = React.createElement(ImageSetLabel, {
            Size = UDim2.fromOffset(tbl1.presenceIndicatorSize, tbl1.presenceIndicatorSize),
            BackgroundTransparency = 1,
            Image = tbl1.presenceImage,
            ImageColor3 = tbl1.presenceImageColor3,
            ImageTransparency = tbl1.presenceImageTransparency
        })
    else
        element = React.createElement("ImageLabel", {
            Size = UDim2.new(0, tbl1.presenceIndicatorSize, 0, tbl1.presenceIndicatorSize),
            BackgroundTransparency = 1,
            Image = tbl1.presenceImage
        })
    end

    return React.createElement(CircleMask, {
        circleColor3 = tbl1.circleColor3,
        circleTransparency = tbl1.circleTransparency,
        circleInteriorBackgroundColor3 = tbl1.circleInteriorBackgroundColor3,
        circleInteriorBackgroundTransparency = tbl1.circleInteriorBackgroundTransparency,
        circleDividerColor3 = tbl1.circleDividerColor3,
        circleDividerTransparency = tbl1.circleDividerTransparency,
        overlaySize = tbl1.overlaySize,
        renderAboveMask = React.createElement(Frame, {}, {
            layout = React.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    VerticalAlignment = Enum.VerticalAlignment.Bottom
                }
            ),
            presenceIndicator = element
        }),
        onActivated = tbl1.onActivated,
        selectable = tbl1.selectable
    }, {
        uiCorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
        avatar = React.createElement(AvatarThumbnail, { thumbnail = tbl1.thumbnail, cornerRadius = UDim.new(1, 0) })
    })
end

return AvatarOneToOne
