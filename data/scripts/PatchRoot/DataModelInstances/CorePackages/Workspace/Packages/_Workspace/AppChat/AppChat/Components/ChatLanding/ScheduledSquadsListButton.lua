-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local SquadExternalContractProvider = require(AppChatParent.SquadsCore.SquadExternalContractProvider)

local DomLocators = require(AppChat.Utils.DomLocators)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)

local ScheduledSquadActionEnum = require(AppChatParent.Squads.Enums).ScheduledSquadActionEnum

local EventNames = require(AppChatParent.SquadsCore.EventNames)
local SquadExternalContractContext = SquadExternalContractProvider.SquadExternalContractContext
local useCurrentSquadId = require(AppChatParent.SquadsCore.Hooks).useCurrentSquadId

local IconButton = Foundation.IconButton

local ScheduledSquadsListSheet = require(AppChatParent.Squads.Components).ScheduledSquadsListSheet

return function(tbl1)
    local squadId = useCurrentSquadId()
    local var2 = React.useContext(SquadExternalContractContext)

    local isOpen, var4 = React.useState(false)

    local onActivated = React.useCallback(function()
        var2.fireSquadAnalytics(EventNames.ScheduledSquadAction, {
            actionType = ScheduledSquadActionEnum.ViewSubscribedScheduledSquadsList,
            source = tbl1.source,
            squadId = squadId,
            squadLocation = var2.squadLocation
        })

        var4(true)
    end, {
        squadId,
        var4,
        var2.fireSquadAnalytics,
        var2.squadLocation
    })

    local onClose = React.useCallback(function()
        var4(false)
    end, { var4 })

    local createElement = React.createElement
    local fragment = React.Fragment
    local var7 = nil
    local tbl2 = {
        ScheduledSquadsListButton = React.createElement(IconButton, {
            icon = Foundation.Enums.IconName.Calendar,
            LayoutOrder = tbl1.layoutOrder,
            onActivated = onActivated,
            testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatLandingTopBarIconButton("scheduledSquads") else nil
        }),
        ScheduledSquadsListSheet = React.createElement(ScheduledSquadsListSheet, { isOpen = isOpen, onClose = onClose })
    }
    return createElement(fragment, var7, tbl2)
end
