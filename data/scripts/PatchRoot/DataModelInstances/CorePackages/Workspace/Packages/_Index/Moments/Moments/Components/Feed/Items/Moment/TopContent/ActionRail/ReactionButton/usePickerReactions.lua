-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _MomentsCommon = require(MomentsParent.MomentsCommon)
local SignalsReact = require(MomentsParent.SignalsReact)

local reactionTypesFromEmojis = require(Moments.Utils.reactionTypesFromEmojis)
local FFlagMomentsEmojiSetsApi = require(Moments.Flags.FFlagMomentsEmojiSetsApi)

local useSignalState = SignalsReact.useSignalState
local MomentsGetMomentsReactionsStore = if FFlagMomentsEmojiSetsApi then require(MomentsParent.DataHydration.MomentsGetMomentsReactionsStore) else nil
local PICKER_REACTION_ORDER = reactionTypesFromEmojis.PICKER_REACTION_ORDER
local reactionTypesFromEmojis2 = reactionTypesFromEmojis.reactionTypesFromEmojis

local var1 = FFlagMomentsEmojiSetsApi and function(arg1)
    assert(MomentsGetMomentsReactionsStore ~= nil, "expected Moments reactions store when FFlagMomentsEmojiSetsApi is on")
    local getEmojis = MomentsGetMomentsReactionsStore(false).getEmojis
    assert(getEmojis ~= nil, "expected getEmojis when FFlagMomentsEmojiSetsApi is on")
    return reactionTypesFromEmojis2(getEmojis(arg1))
end or nil

local function usePickerReactions()
    local var2 = PICKER_REACTION_ORDER
    if FFlagMomentsEmojiSetsApi then
        var2 = useSignalState(var1)
    end
    return var2
end

return usePickerReactions
