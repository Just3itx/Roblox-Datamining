-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)

local AvatarOneToOne = require(script.AvatarOneToOne)
local AvatarGroup = require(script.AvatarGroup)

local tbl1 = { presenceIndicatorSize = 14 }

local function AvatarCircle(tbl2)
    local var1 = Cryo.Dictionary.union(tbl2, tbl1)

    if #var1.thumbnails ~= 1 then
        return React.createElement(AvatarGroup, {
            circleColor3 = var1.circleColor3,
            circleDividerColor3 = var1.circleDividerColor3,
            circleDividerTransparency = var1.circleDividerTransparency,
            circleInteriorBackgroundColor3 = var1.circleInteriorBackgroundColor3,
            circleInteriorBackgroundTransparency = var1.circleInteriorBackgroundTransparency,
            circleTransparency = var1.circleTransparency,
            onActivated = var1.onActivated,
            overlaySize = var1.overlaySize,
            selectable = var1.selectable,
            thumbnails = var1.thumbnails
        })
    end

    return React.createElement(AvatarOneToOne, {
        circleColor3 = var1.circleColor3,
        circleDividerColor3 = var1.circleDividerColor3,
        circleDividerTransparency = var1.circleDividerTransparency,
        circleInteriorBackgroundColor3 = var1.circleInteriorBackgroundColor3,
        circleInteriorBackgroundTransparency = var1.circleInteriorBackgroundTransparency,
        circleTransparency = var1.circleTransparency,
        onActivated = var1.onActivated,
        overlaySize = var1.overlaySize,
        presenceImage = var1.presenceImage,
        presenceImageColor3 = var1.presenceImageColor3,
        presenceImageTransparency = var1.presenceImageTransparency,
        presenceIndicatorSize = var1.presenceIndicatorSize,
        selectable = var1.selectable,
        showNewPresenceImage = var1.showNewPresenceImage,
        thumbnail = var1.thumbnails[1]
    })
end

return AvatarCircle
