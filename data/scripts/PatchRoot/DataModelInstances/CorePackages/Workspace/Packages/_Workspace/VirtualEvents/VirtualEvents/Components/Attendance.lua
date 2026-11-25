-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local Players = game:GetService("Players")

local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local React = require(VirtualEvents.Parent.React)
local AttendanceCount = require(VirtualEvents.Components.AttendanceCount)
local FacePile = require(VirtualEvents.Components.FacePile)
local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)

local function Attendance(tbl1)
    local experienceDetails = tbl1.virtualEvent.experienceDetails
    local rsvpCounters = tbl1.virtualEvent.rsvpCounters

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

    if tbl1.eventStatus == "Ongoing" and experienceDetails and experienceDetails.playing == 0
        or tbl1.eventStatus ~= "Ongoing" and rsvpCounters and rsvpCounters.going == 0
    then
        return nil
    end

    local createElement = React.createElement
    local str1 = "Folder"
    local var2 = nil
    local tbl2 = {
        Layout = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8) }),
        AttendanceCount = React.createElement(AttendanceCount, {
            layoutOrder = 1,
            eventStatus = tbl1.eventStatus,
            interested = if rsvpCounters and rsvpCounters.going then rsvpCounters.going else 0,
            attending = if experienceDetails and experienceDetails.playing then experienceDetails.playing else 0
        }),
        FacePile = 0
    }

    local createElement2 = React.createElement
    local var3 = FacePile
    local tbl3 = {
        layoutOrder = 2,
        userIds = userIds,
        desiredFirstUserId = if Players.LocalPlayer then tostring(Players.LocalPlayer.UserId) else nil
    }
    tbl2.FacePile = createElement2(var3, tbl3)
    return createElement(str1, var2, tbl2)
end

return Attendance
