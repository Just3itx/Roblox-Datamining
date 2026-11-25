-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local React = require(VirtualEvents.Parent.React)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization
local formatNumberWithShortUnits = require(VirtualEvents.Common.formatNumberWithShortUnits)
local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useStyle = UIBlox.Core.Style.useStyle

local iconsStatusGamesPeoplePlaying_small = Images["icons/status/games/people-playing_small"]

local uDim = UDim.new(0, 6)

local function AttendanceCount(tbl1)
    local var1 = useStyle()
    local var2 = useLocalization({
        interested = "Feature.VirtualEvents.AttendanceBeforeEvent",
        attendingNow = "Feature.VirtualEvents.AttendanceDuringEvent"
    })

    local bool1 = tbl1.eventStatus == "Ongoing"

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY
    }
    local tbl3 = {
        Layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = uDim
        }),
        Icon = React.createElement(ImageSetLabel, {
            LayoutOrder = 1,
            Size = UDim2.fromOffset(18, 18),
            Image = iconsStatusGamesPeoplePlaying_small,
            ImageColor3 = var1.Theme.IconEmphasis.Color,
            BackgroundTransparency = 1
        }),
        Label = 0
    }

    local createElement2 = React.createElement
    local var3 = StyledTextLabel
    local tbl4 = {
        layoutOrder = 2,
        fontStyle = var1.Font.Header1,
        colorStyle = var1.Theme.TextEmphasis,
        text = 0
    }
    local str2 = "%s %s"
    local var4 = formatNumberWithShortUnits(if bool1 then tbl1.attending else tbl1.interested)
    local var5 = if bool1 then var2.attendingNow else var2.interested
    tbl4.text = str2:format(var4, var5)
    tbl3.Label = createElement2(var3, tbl4)
    return createElement(str1, tbl2, tbl3)
end

return AttendanceCount
