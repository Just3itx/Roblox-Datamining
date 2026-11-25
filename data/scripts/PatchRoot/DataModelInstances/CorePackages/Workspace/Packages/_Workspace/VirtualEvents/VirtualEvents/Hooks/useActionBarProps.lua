-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local getEventCtaButtonState = require(VirtualEvents.Common.getEventCtaButtonState)
local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local React = require(VirtualEvents.Parent.React)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization
local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)
local usePlayButtonState = require(VirtualEvents.Parent.GamePlayButton).usePlayButtonState
local RoactNetworking = require(VirtualEvents.Parent.RoactServiceTags).RoactNetworking
local useRoactService = require(VirtualEvents.Parent.RobloxAppHooks).useRoactService

local Images = UIBlox.App.ImageSet.Images
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local function useActionBarProps(arg1, arg2, tbl1, buttonRef)
    local var1 = useLocalization({
        notifyMe = "Feature.VirtualEvents.NotifyMe",
        unfollowEvent = "Feature.VirtualEvents.UnfollowEvent",
        joinEvent = "Feature.VirtualEvents.JoinEvent",
        goHome = "Feature.VirtualEvents.GoHome"
    })

    local var2 = useRoactService(RoactNetworking)
    local var3 = usePlayButtonState(var2, tostring(arg1.universeId))
    local eventCtaButtonState = getEventCtaButtonState(var3)
    local isJoinEventDisabled = eventCtaButtonState.isJoinEventDisabled
    local isRsvpDisabled = eventCtaButtonState.isRsvpDisabled

    local button = React.useMemo(function()
        if arg1.eventStatus == "cancelled" or arg1.eventStatus == "moderated" then
            return {
                props = {
                    buttonType = ButtonType.Secondary,
                    text = var1.goHome,
                    onActivated = tbl1.onClose,
                    buttonRef = buttonRef
                }
            }
        end

        if arg2 ~= "Upcoming" and arg2 ~= "UpcomingImminent" then
            if arg2 ~= "Ongoing" and arg2 ~= "ElapsedImminent" then
                return nil
            end

            return {
                props = {
                    buttonType = ButtonType.PrimaryContextual,
                    text = var1.joinEvent,
                    onActivated = tbl1.onJoinEvent,
                    buttonRef = buttonRef,
                    isDisabled = isJoinEventDisabled
                }
            }
        end

        if arg1.userRsvpStatus == "going" then
            return {
                props = {
                    buttonType = ButtonType.Secondary,
                    text = var1.unfollowEvent,
                    icon = Images["icons/actions/favoriteOn"],
                    onActivated = tbl1.onRsvpChanged,
                    buttonRef = buttonRef,
                    isDisabled = isRsvpDisabled
                }
            }
        end

        return {
            props = {
                buttonType = ButtonType.PrimarySystem,
                text = var1.notifyMe,
                icon = Images["icons/actions/favoriteOff"],
                onActivated = tbl1.onRsvpChanged,
                buttonRef = buttonRef,
                isDisabled = isRsvpDisabled
            }
        }
    end, {
        arg1,
        arg2,
        tbl1,
        buttonRef,
        isRsvpDisabled,
        isJoinEventDisabled
    })

    local var5 = React.useMemo(function()
        if arg1.eventStatus == "cancelled" or arg1.eventStatus == "moderated" or arg2 == "Elapsed" then
            return nil
        end

        return {
            props = {
                anchorPoint = Vector2.new(0.5, 0.5),
                position = UDim2.fromScale(0.5, 0.5),
                icon = Images["icons/actions/share"],
                userInteractionEnabled = true,
                onActivated = tbl1.onShare
            }
        }
    end, { arg1, arg2, tbl1 })

    return (React.useMemo(function()
        return {
            button = button,
            icons = { var5 }
        }
    end, { button, var5 }))
end

return useActionBarProps
