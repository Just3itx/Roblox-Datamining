-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local React = require(VirtualEvents.Parent.React)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization
local formatDate = require(VirtualEvents.Common.formatDate)
local getVirtualEventDates = require(VirtualEvents.Common.getVirtualEventDates)

local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useStyle = UIBlox.Core.Style.useStyle

local str1 = utf8.char(8226)

local function EventTimer(tbl1)
    local var1 = useStyle()
    local var2 = useLocalization({ cancelled = "Feature.VirtualEvents.EventCancelledText" })

    local bool1 = tbl1.virtualEvent.eventStatus == "cancelled"

    local var3 = React.useMemo(function()
        return getVirtualEventDates(tbl1.virtualEvent)
    end, { tbl1.virtualEvent })

    return React.createElement(StyledTextLabel, {
        text = if bool1 then var2.cancelled else ("%s %s %s"):format(formatDate(var3.startDate), str1, formatDate(var3.endDate)),
        automaticSize = Enum.AutomaticSize.XY,
        fontStyle = var1.Font.CaptionHeader,
        colorStyle = if bool1 then var1.Theme.Alert else var1.Theme.TextMuted
    })
end

return EventTimer
