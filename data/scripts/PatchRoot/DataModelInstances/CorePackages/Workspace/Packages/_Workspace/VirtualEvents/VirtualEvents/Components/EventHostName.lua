-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local React = require(VirtualEvents.Parent.React)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)

local useStyle = UIBlox.Core.Style.useStyle
local EmojiTextLabel = UIBlox.Core.Text.EmojiTextLabel
local Emoji = UIBlox.App.Emoji.Enum.Emoji

local function EventHostName(tbl1)
    local var1 = useStyle()
    local verified = if tbl1.host.hasVerifiedBadge then Emoji.Verified else nil
    local var2, var3 = React.useState(0)

    local var4 = React.useCallback(function(arg1)
        var3(arg1.TextSize)
    end, { var3 })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY
    }
    local tbl3 = {
        Layout = React.createElement("UIListLayout", {
            Padding = UDim.new(0, 4),
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        UserImage = React.createElement(
            "ImageLabel",
            {
                LayoutOrder = 1,
                BackgroundColor3 = var1.Theme.Badge.Color,
                BackgroundTransparency = var1.Theme.Badge.Transparency,
                Image = string.format(
                    "rbxthumb://type=%s&id=%i&w=150&h=150",
                    if tbl1.host.hostType == "group" then "GroupIcon" else "AvatarHeadShot",
                    tbl1.host.hostId
                ),
                Size = if tbl1.changeHostImageSize then UDim2.fromOffset(32, 32) else UDim2.fromOffset(var2, var2)
            },
            {
                Corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
            }
        ),
        EmojiName = React.createElement(EmojiTextLabel, {
            Text = tbl1.host.hostName,
            LayoutOrder = 2,
            emoji = verified,
            fontStyle = var1.Font.Header2,
            colorStyle = var1.Theme.TextEmphasis,
            [React.Change.AbsoluteSize] = var4
        }),
        EmojiToArrowMargin = if verified then React.createElement("Frame", { LayoutOrder = 3, BackgroundTransparency = 1, Size = UDim2.fromOffset(var2 - 4, 0) }) else nil
    }
    return createElement(str1, tbl2, tbl3)
end

return EventHostName
