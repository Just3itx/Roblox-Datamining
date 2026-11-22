-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)
local Navigation = require(MomentsParent.Navigation)
local SignalsReact = require(MomentsParent.SignalsReact)
local useNavigationFocus = Navigation.useNavigationFocus
local useSignalState = SignalsReact.useSignalState

local useMomentsTabIsVisible = require(Moments.Hooks.useMomentsTabIsVisible)

local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)

local feedPlaybackSuspension = MomentsCommon.Media.feedPlaybackSuspension

local function useFeedPlaybackActive()
    local var1 = useNavigationFocus()
    local var2 = useMomentsTabIsVisible()

    local var3 = useSignalState(feedPlaybackSuspension.getSuspended)

    local var4 = useSignalState(GetMomentsPreferencesStore(false).getIsTeleporting)

    return var1 and var2 and not var3 and not var4
end

return useFeedPlaybackActive
