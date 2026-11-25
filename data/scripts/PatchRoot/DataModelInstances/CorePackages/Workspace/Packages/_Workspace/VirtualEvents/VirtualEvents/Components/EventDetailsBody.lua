-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local React = require(VirtualEvents.Parent.React)
local Foundation = require(VirtualEvents.Parent.Foundation)
local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local AppCommonLibText = require(VirtualEvents.Parent.AppCommonLib).Text
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization

local formatDate = require(VirtualEvents.Common.formatDate)
local getVirtualEventDates = require(VirtualEvents.Common.getVirtualEventDates)
local getEventCategory = require(VirtualEvents.Common.getEventCategory)
local AttendanceChip = require(VirtualEvents.Components.AttendanceChip)
local DescriptionExpander = require(VirtualEvents.Components.DescriptionExpander)

local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)

local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize

local function EventDetailsBody(tbl1)
    local var1 = useTokens()

    local description = React.useMemo(function()
        if tbl1.virtualEvent.description == nil then
            return nil
        end
        return AppCommonLibText.Trim(tbl1.virtualEvent.description)
    end, { tbl1.virtualEvent.description })

    local var3 = React.useMemo(function()
        return getEventCategory(tbl1.virtualEvent)
    end, { tbl1.virtualEvent })

    local var4 = React.useMemo(function()
        return getVirtualEventDates(tbl1.virtualEvent)
    end, { tbl1.virtualEvent })

    local var5 = useLocalization({
        interested = "Feature.VirtualEvents.AttendanceBeforeEvent",
        newContent = "Feature.VirtualEvents.Label.NewContent",
        itemDrop = "Feature.VirtualEvents.Label.ItemDrop",
        newSeason = "Feature.VirtualEvents.Label.NewSeason",
        newLocation = "Feature.VirtualEvents.Label.NewLocation",
        newMap = "Feature.VirtualEvents.Label.NewMap",
        moreLevels = "Feature.VirtualEvents.Label.MoreLevels",
        newFeature = "Feature.VirtualEvents.Label.NewFeature",
        earlyAccess = "Feature.VirtualEvents.Label.EarlyAccess",
        expansion = "Feature.VirtualEvents.Label.Expansion",
        challenge = "Feature.VirtualEvents.Label.Challenge",
        quest = "Feature.VirtualEvents.Label.Quest",
        festival = "Feature.VirtualEvents.Label.Festival"
    })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0)
    }
    local tbl3 = { BodyContainer = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ZIndex = 1
    }

    local tbl5 = {
        Layout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8)
            }
        ),
        EventAttendace = React.createElement(
            AttendanceChip,
            {
                LayoutOrder = 1,
                virtualEvent = tbl1.virtualEvent,
                eventStatus = tbl1.eventStatus
            }
        ),
        EventTitle = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, 0),
            Text = tbl1.virtualEvent.title,
            TextTruncate = Enum.TextTruncate.None,
            AutomaticSize = Enum.AutomaticSize.Y,
            RichText = true,
            textStyle = var1.Color.Content.Emphasis,
            fontStyle = var1.Typography.TitleLarge,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = false
        }),
        Description = if description and description ~= "" then React.createElement(DescriptionExpander, {
            layoutOrder = 3,
            description = description,
            width = tbl1.containerSize.X - 32 - 16,
            maxHeight = tbl1.containerSize.Y * 0.3,
            isExpanded = tbl1.isExpanded,
            setIsExpanded = tbl1.setIsExpanded
        }) else nil,
        EventCategory = 0,
        EventTime = 0
    }
    local element

    if var3 and var5[var3] then
        element = React.createElement(
            "Frame",
            {
                LayoutOrder = 4,
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            },
            {
                Layout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 6)
                }),
                Icon = React.createElement(
                    Icon,
                    {
                        LayoutOrder = 1,
                        name = "icons/common/poi_small",
                        size = IconSize.Small,
                        style = var1.Color.Content.Emphasis
                    }
                ),
                Label = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = var5[var3],
                    TextTruncate = Enum.TextTruncate.None,
                    textStyle = var1.Color.Content.Emphasis,
                    fontStyle = var1.Typography.BodyLarge,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = false
                })
            }
        )
    else
        element = nil
    end

    tbl5.EventCategory = element
    local element2

    if tbl1.eventStatus == "Upcoming" then
        element2 = React.createElement(
            "Frame",
            {
                LayoutOrder = 5,
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            },
            {
                Layout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 6)
                }),
                Icon = React.createElement(
                    Icon,
                    {
                        LayoutOrder = 1,
                        name = "icons/actions/calendar_small",
                        size = IconSize.Small,
                        style = var1.Color.Content.Emphasis
                    }
                ),
                Label = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = formatDate(var4.startDate, true),
                    TextTruncate = Enum.TextTruncate.None,
                    textStyle = var1.Color.Content.Emphasis,
                    fontStyle = var1.Typography.BodyLarge,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = false
                })
            }
        )
    else
        element2 = nil
    end

    tbl5.EventTime = element2
    tbl3.BodyContainer = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return EventDetailsBody
