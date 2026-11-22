-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)
local FFlagMomentsReactFeatureGate = require(MomentsParent.SharedFlags).FFlagMomentsReactFeatureGate

local MomentContext = require(script.Parent.Parent.MomentContext)
local ReactionEffectsContext = require(script.Parent.ReactionEffectsContext)
local reactionTruthTable = require(script.Parent.reactionTruthTable)
local SignalActionType = require(Moments.Enums.SignalActionType)
local useFeedOptional = require(Moments.Components.Feed.FeedContext).useFeedOptional
local FFlagMomentsUseSharedReactions = require(Moments.Flags.FFlagMomentsUseSharedReactions)
local applyReactionTrigger = if FFlagMomentsUseSharedReactions then require(MomentsParent.Reactions.applyReactionTrigger) else nil
local ReactionTrigger = if FFlagMomentsUseSharedReactions then require(MomentsParent.Reactions.ReactionTrigger) else nil
local GetMomentsCapabilities = MomentsCommon.Stores.GetMomentsCapabilities
local useReactionEffects = ReactionEffectsContext.useReactionEffects

local function decideWithSharedRules(selectedReaction, arg1, arg2)
    assert(not (applyReactionTrigger == nil) and ReactionTrigger ~= nil, "expected the shared Reactions rules")
    local selectedReactions = ({})
    if selectedReaction ~= nil then
        selectedReactions[selectedReaction] = true
    end
    local var1 = applyReactionTrigger(
        {
            selectedReactions = selectedReactions,
            reactionCounts = {}
        },
        if arg1 == "tapButton" then ReactionTrigger.ButtonTap elseif arg1 == "doubleTap" then ReactionTrigger.DoubleTap else ReactionTrigger.PickerSelect,
        arg2
    )

    return {
        action = if var1.added ~= nil then "commit" elseif var1.removed == nil then "none" else "clear",
        reaction = var1.added,
        effectReaction = var1.celebratedReaction
    }
end

local function useReactionCommit()
    local store = MomentContext.useMoment().store
    local var1 = useReactionEffects()

    local var2 = useFeedOptional()

    local var3 = not FFlagMomentsReactFeatureGate or SignalsReact.useSignalState(GetMomentsCapabilities(false).getCanReactToMoments)

    return React.useCallback(function(arg1, vector2: Vector2?, arg2)
        if FFlagMomentsReactFeatureGate and not var3 then
            return
        end

        local selectedReaction = store.getSelectedReaction(false)
        local var4 = if FFlagMomentsUseSharedReactions then decideWithSharedRules(selectedReaction, arg1, arg2) else reactionTruthTable.decide(selectedReaction, arg1, arg2)

        if var4.action == "commit" and var4.reaction ~= nil then
            store.commitReaction(var4.reaction)
        elseif var4.action == "clear" then
            store.clearReaction()
        end

        if var2 ~= nil and var4.action ~= "none" then
            local data = store.getData(false)

            local feedItemId = data.feedItemId
            if feedItemId ~= nil and feedItemId ~= "" then
                local tbl1 = {
                    itemId = feedItemId,
                    tracingId = data.feedSessionId,
                    contentType = data.contentType
                }
                local success, result = pcall(function()
                    if var4.action == "commit" and var4.reaction ~= nil then
                        var2.logAction(SignalActionType.AddReaction, tbl1, { reactionType = var4.reaction })
                    elseif var4.action == "clear" then
                        var2.logAction(SignalActionType.RemoveReaction, tbl1, {})
                    end
                end)
                if not success then
                    warn("Failed to log reaction action event", result)
                end
            end
        end

        if var1 ~= nil and var4.effectReaction ~= nil then
            var1.spawnExplosion(var4.effectReaction, vector2)
        end
    end, {
        store,
        var1,
        var2,
        var3
    })
end
return useReactionCommit
