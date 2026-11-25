-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local DataHydration = require(SduiSharedContentParent.DataHydration)
local Foundation = require(SduiSharedContentParent.Foundation)
local React = require(SduiSharedContentParent.React)
local Reactions = require(SduiSharedContentParent.Reactions)

local _ContentReactionsStoreTypes = require(SduiSharedContent.Stores.ContentReactionsStoreTypes)
local AddReactionButton = require(SduiSharedContent.Components.AddReactionButton)
local useOptimisticReactions = require(SduiSharedContent.Components.useOptimisticReactions)

local getLocalPlayerUserId = DataHydration.DataHydrationUtils.getLocalPlayerUserId

local View = Foundation.View

local function findReaction(tbl1, tbl2)
    local reactionType = tbl1.reactionType
    local var1 = nil
    for _, value in tbl2 do
        if value.reactionType ~= reactionType then
            continue
        end

        if value.hasUserAppliedReaction then
            return value
        end

        var1 = var1 or value
    end

    return var1 or {
        emoteId = tbl1.emoteId,
        reactionType = reactionType,
        hasUserAppliedReaction = false
    }
end

local function SduiReactions(tbl1)
    local onReactionActivated = tbl1.onReactionActivated
    local bool1 = not (onReactionActivated == nil or getLocalPlayerUserId() == nil) and not tbl1.isDisabled
    local var1, var2 = useOptimisticReactions(tbl1.id, tbl1.reactions, onReactionActivated)

    local var3 = React.useMemo(function()
        local reactionTypes = {}
        local availableByType = ({})
        for _, value in tbl1.availableReactions or {} do
            local reactionType = value.reactionType
            if Reactions.Constants.ReactionIconMappings[reactionType] then
                availableByType[reactionType] = value
                table.insert(reactionTypes, reactionType)
            end
        end
        return { reactionTypes = reactionTypes, availableByType = availableByType }
    end, { tbl1.availableReactions })

    local selectedReactions = React.useMemo(function()
        local result = {}
        for _, value in var1 do
            if value.hasUserAppliedReaction then
                result[value.reactionType] = true
            end
        end
        return result
    end, { var1 })

    local function selectReaction(arg1)
        var2((findReaction(var3.availableByType[arg1], var1)))
    end

    local tbl2 = {}
    local num1 = 0
    local bool2 = false

    for _, value in var1 do
        if not Reactions.Constants.ReactionIconMappings[value.reactionType] then
            continue
        end

        local reactionCount = if tbl1.areReactionCountsVisible then value.reactionCount or 0 else nil
        num1 += 1

        local str1 = `Reaction_{value.emoteId}`

        tbl2[str1] = React.createElement(Reactions.ReactionPill, {
            reactionType = value.reactionType,
            count = reactionCount,
            isSelected = value.hasUserAppliedReaction,
            onActivated = bool1 and function()
                var2(value)
            end or nil,
            layoutOrder = num1,
            testId = `reaction-{value.emoteId}`
        })

        bool2 = bool2 or reactionCount ~= 0
    end

    if bool1 and #var3.reactionTypes > 0 then
        tbl2.AddReaction = React.createElement(AddReactionButton, {
            layoutOrder = 0,
            reactions = var3.reactionTypes,
            selectedReactions = selectedReactions,
            onReactionSelected = selectReaction
        })
    elseif not bool2 then
        return nil
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            testId = "reactions",
            tag = "row wrap align-y-center gap-small size-full-0 auto-y"
        },
        tbl2
    )
end

return SduiReactions
