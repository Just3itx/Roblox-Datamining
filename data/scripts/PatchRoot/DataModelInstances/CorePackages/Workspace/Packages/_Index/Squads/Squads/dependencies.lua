-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
local SquadsParent = script:FindFirstAncestor("Squads").Parent

local React = require(SquadsParent.React)
local RoduxSquads = require(SquadsParent.RoduxSquads)
local Http = require(SquadsParent.SquadsCore.Http)
local RoduxSquads2 = require(SquadsParent.SquadsCore.RoduxSquads)

local RoduxNetworking = require(SquadsParent.SquadsCore.Http).RoduxNetworking

return {
    Cryo = require(SquadsParent.Cryo),
    Foundation = require(SquadsParent.Foundation),
    Hooks = {
        dependencyArray = require(SquadsParent.RoactUtils).Hooks.dependencyArray,
        useCurrentSquadSelector = RoduxSquads.Hooks.useCurrentSquadSelector,
        useDispatch = require(SquadsParent.RoactUtils).Hooks.RoactRodux.useDispatch,
        useEffectOnce = require(SquadsParent.RoactUtils).Hooks.useEffectOnce,
        useLocalization = require(SquadsParent.Localization).Hooks.useLocalization,
        usePrevious = require(SquadsParent.RoactUtils).Hooks.usePrevious,
        useSelector = require(SquadsParent.RoactUtils).Hooks.RoactRodux.useSelector,
        useStore = require(SquadsParent.RoactUtils).Hooks.RoactRodux.useStore
    },
    LuauPolyfill = require(SquadsParent.LuauPolyfill),
    React = React,
    Roact = require(SquadsParent.Roact),
    RoactRodux = require(SquadsParent.RoactRodux),
    Rodux = require(SquadsParent.Rodux),
    RoduxNetworking = RoduxNetworking,
    SharedFlags = require(SquadsParent.SharedFlags),
    SocialExperiments = require(SquadsParent.SocialExperiments),
    t = require(SquadsParent.t),
    useNavigation = require(SquadsParent.Navigation).useNavigation,
    RoduxPresence = Http.RoduxPresence,
    NetworkingPresence = Http.NetworkingPresence,
    RoduxSquads = RoduxSquads2,
    NetworkingSquads = Http.NetworkingSquads,
    UserBlockingRodux = Http.UserBlockingRodux,
    UserBlockingNetworking = Http.UserBlockingNetworking
}
