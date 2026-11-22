-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local ExperienceService = require(SquadsParent.ExperienceService).ExperienceService

local AppSquadTopBannerEventReceiver = require(script.Parent.AppSquadTopBannerEventReceiver)

local dependencies = require(Squads.dependencies)
local React = dependencies.React
local RoduxSquads = dependencies.RoduxSquads
local SquadEventReceiver = require(SquadsParent.SquadsCore.SquadEventReceiver)
local GetSquadExperienceInviteStore = require(SquadsParent.SquadsCore.Stores).GetSquadExperienceInviteStore
local useSignalState = require(SquadsParent.SignalsReact).useSignalState

local useDispatch = dependencies.Hooks.useDispatch
local useSelector = dependencies.Hooks.useSelector
local useCanAccessParty = require(Squads.Hooks.useCanAccessParty)

local CurrentSquadUpdated = RoduxSquads.Actions.CurrentSquadUpdated

local FFlagUseSignalsForSquadExperienceInvite = dependencies.SharedFlags.FFlagUseSignalsForSquadExperienceInvite

return function(_)
    local var1 = useDispatch()

    local var2 = React.useCallback(function(arg1)
        if arg1.Squad and arg1.Squad.Squad then
            return arg1.Squad.Squad.currentExperienceInvite
        end

        return nil
    end, {})

    local var3 = if FFlagUseSignalsForSquadExperienceInvite then useSignalState(GetSquadExperienceInviteStore(false).getCurrentExperienceInvite) else useSelector(var2)

    local var4 = React.useCallback(function(arg1)
        return if arg1.Squad and arg1.Squad.Squad and arg1.Squad.Squad.currentSquadPersist then arg1.Squad.Squad.currentSquadPersist.isPaused else false
    end, {})
    local var5 = useSelector(var4)

    React.useEffect(function()
        ExperienceService:RegisterForExperienceJoin(function()
            RoduxSquads.PersistManagers.currentSquadPersistManager.pause(var1)
        end)
        ExperienceService:RegisterForExperienceLeave(function()
            RoduxSquads.PersistManagers.currentSquadPersistManager.persistAndUpdateState(var1)
        end)
    end, { var1 })

    React.useEffect(function()
        if not var3 or not var5 then
            return
        end

        if FFlagUseSignalsForSquadExperienceInvite then
            GetSquadExperienceInviteStore(false).currentExperienceInviteDismissed(var3.notification.notificationId)
            return
        end

        var1(RoduxSquads.Actions.CurrentExperienceInviteDismissed(var3.notification.notificationId))
    end, { var3, var5 })

    local var6 = useCanAccessParty()

    React.useEffect(function()
        if not var6 then
            var1(CurrentSquadUpdated(nil))
        end
    end, { var6 })

    return React.createElement(React.Fragment, nil, {
        appSquadTopBannerEventReceiver = React.createElement(AppSquadTopBannerEventReceiver),
        squadEventReceiver = if var6 and not var5 then React.createElement(SquadEventReceiver) else nil
    })
end
