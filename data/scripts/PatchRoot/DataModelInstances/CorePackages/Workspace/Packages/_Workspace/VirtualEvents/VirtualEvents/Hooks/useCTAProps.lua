-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local React = require(VirtualEvents.Parent.React)
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization
local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)

local function useCTAProps(arg1, arg2, bool1: boolean, tbl1)
    local var1 = useLocalization({
        notifyMe = "Feature.VirtualEvents.NotifyMe",
        unfollowEvent = "Feature.VirtualEvents.UnfollowEvent",
        join = "Feature.VirtualEvents.Join",
        goHome = "Feature.VirtualEvents.GoHome"
    })

    local button = React.useMemo(function()
        if arg1.eventStatus == "cancelled" or arg1.eventStatus == "moderated" then
            return {
                text = var1.goHome,
                icon = nil,
                variant = "Standard",
                onActivated = tbl1.onClose
            }
        end

        if arg2 ~= "Upcoming" and arg2 ~= "UpcomingImminent" then
            if arg2 ~= "Ongoing" and arg2 ~= "ElapsedImminent" then
                return nil
            end

            return {
                text = var1.join,
                icon = nil,
                variant = "Emphasis",
                onActivated = tbl1.onJoinEvent
            }
        end

        if arg1.userRsvpStatus == "going" then
            return {
                text = var1.unfollowEvent,
                icon = nil,
                variant = "Standard",
                onActivated = tbl1.onRsvpChanged
            }
        end

        return {
            text = var1.notifyMe,
            icon = nil,
            variant = if bool1 then "Emphasis" else "Standard",
            onActivated = tbl1.onRsvpChanged
        }
    end, { arg1, arg2, tbl1 })

    local icon = React.useMemo(function(): {icon: string, onActivated: any, text: nil, variant: string}?
        return if arg1.eventStatus == "cancelled" or arg1.eventStatus == "moderated" or arg2 == "Elapsed" then nil else {
            text = nil,
            icon = "icons/actions/shareArrowOff",
            variant = "Standard",
            onActivated = tbl1.onShare
        }
    end, { arg1, arg2, tbl1 })

    return (React.useMemo(function()
        return { button = button, icon = icon }
    end, { button, icon }))
end

return useCTAProps
