-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local useRoactService = require(scriptParentParentParentParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(scriptParentParentParentParent.RoactServiceTags).RoactNetworking

local React = require(scriptParentParentParentParent.React)
local ReactUtils = require(scriptParentParentParentParent.ReactUtils)

local useContext = React.useContext
local useEventConnection = ReactUtils.useEventConnection

local fetchEventDetails = require(scriptParentParentParent.Common.fetchEventDetails)

local ServiceOverrideContext = require(scriptParentParentParent.Components.CoreUI.ServiceOverrideContext)

local FFlagInGameRsvpPushUpsellEnabled = require(scriptParentParentParentParent.SharedFlags).FFlagInGameRsvpPushUpsellEnabled

return function(tbl1)
    local var1 = useRoactService(RoactNetworking)

    local socialService = useContext(ServiceOverrideContext).socialService

    local var2 = React.useCallback(function(str1: string)
        fetchEventDetails(var1, str1):andThen(function(arg1)
            tbl1.openRsvpPrompt(str1, arg1)
        end, function(arg1)
            socialService:PromptRsvpToEventCompleted(str1, false, Enum.RsvpStatus.None)
            warn("Error fetching event details: ", arg1)

            if not FFlagInGameRsvpPushUpsellEnabled then
                tbl1.closePrompt()
            end
        end)
    end, { tbl1.openRsvpPrompt, var1 })

    useEventConnection(socialService.ShowPromptRsvpToEvent, var2)

    return React.createElement(React.Fragment, {}, {})
end
