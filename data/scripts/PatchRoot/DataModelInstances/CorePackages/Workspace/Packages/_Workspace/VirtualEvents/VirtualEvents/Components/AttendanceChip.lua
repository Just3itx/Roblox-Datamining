-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")
local Players = game:GetService("Players")

local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local Foundation = require(VirtualEvents.Parent.Foundation)
local React = require(VirtualEvents.Parent.React)
local EventSocialProof = require(VirtualEvents.Components.EventSocialProof)
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization
local formatNumberWithShortUnits = require(VirtualEvents.Common.formatNumberWithShortUnits)
local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)

local View = Foundation.View
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local function AttendanceChip(tbl1)
    local var1 = useTokens()
    local var2 = useLocalization({
        interested = "Feature.VirtualEvents.AttendanceBeforeEvent",
        attendingNow = "Feature.VirtualEvents.AttendanceDuringEvent"
    })

    local experienceDetails = tbl1.virtualEvent.experienceDetails
    local rsvpCounters = tbl1.virtualEvent.rsvpCounters
    local bool1 = tbl1.eventStatus == "Ongoing"

    local userIds = React.useMemo(function()
        local result = {}
        if tbl1.virtualEvent.rsvps then
            for _, rsvp in tbl1.virtualEvent.rsvps do
                if rsvp.rsvpStatus == "going" then
                    table.insert(result, tostring(rsvp.userId))
                end
            end
        end
        return result
    end, { tbl1.virtualEvent })

    if bool1 and experienceDetails and experienceDetails.playing == 0
        or not bool1 and rsvpCounters and rsvpCounters.going == 0
    then
        return nil
    end

    local var4 = if rsvpCounters and rsvpCounters.going then rsvpCounters.going else 0
    local var5 = if experienceDetails and experienceDetails.playing then experienceDetails.playing else 0

    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        backgroundStyle = var1.Inverse.Surface.Surface_300,
        tag = {
            ["row gap-xsmall size-0-700 auto-x align-y-center align-x-center clip radius-circle"] = true
        }
    }
    local tbl3 = {
        Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 12) }),
        EventSocialProof = 0,
        AttendanceCount = 0
    }

    local createElement2 = React.createElement
    local var7 = EventSocialProof
    local tbl4 = {
        userIds = userIds,
        desiredFirstUserId = if Players.LocalPlayer then tostring(Players.LocalPlayer.UserId) else nil
    }
    tbl3.EventSocialProof = createElement2(var7, tbl4)

    local createElement3 = React.createElement
    local var9 = FoundationText
    local tbl5 = {
        Text = 0,
        textStyle = 0,
        fontStyle = 0,
        tag = "auto-x size-0-full shrink text-caption-large text-truncate-end"
    }
    local str1 = "%s %s"
    local var10 = formatNumberWithShortUnits

    if bool1 then
        var4 = var5
    end

    local var11 = var10(var4)
    local var12 = if bool1 then var2.attendingNow else var2.interested
    tbl5.Text = str1:format(var11, var12)

    tbl5.textStyle = var1.Inverse.Content.Emphasis
    tbl5.fontStyle = var1.Typography.TitleSmall
    tbl3.AttendanceCount = createElement3(var9, tbl5)
    return createElement(var6, tbl2, tbl3)
end

return AttendanceChip
