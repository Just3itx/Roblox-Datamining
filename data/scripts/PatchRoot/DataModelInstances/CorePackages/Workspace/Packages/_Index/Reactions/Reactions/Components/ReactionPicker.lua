-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")
local ReactionsParent = Reactions.Parent

local Foundation = require(ReactionsParent.Foundation)
local React = require(ReactionsParent.React)

local Constants = require(Reactions.Constants)
local ReactionButton = require(Reactions.Components.ReactionButton)
local _ReactionSize = require(Reactions.Enums.ReactionSize)
local _ReactionType = require(Reactions.Enums.ReactionType)

local Radius = Foundation.Enums.Radius
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function ReactionPicker(tbl1)
    local var1 = useTokens()
    local var2 = tbl1.reactions or Constants.PossibleReactions
    local testId = tbl1.testId or "reaction-picker"
    local selectedReactions = tbl1.selectedReactions
    local var3 = tbl1.radius or Radius.Circle

    local var4 = React.useMemo(function()
        local result = ({})
        for layoutOrder, reactionType in var2 do
            local createElement = React.createElement
            local var4 = ReactionButton
            local tbl2 = {
                reactionType = reactionType,
                isActive = not (selectedReactions == nil) and selectedReactions[reactionType] == true,
                isHovered = tbl1.hoveredReaction == reactionType,
                reactionSize = tbl1.reactionSize,
                buttonRef = if tbl1.getButtonRef then tbl1.getButtonRef(reactionType) else nil,
                onActivated = 0,
                entryDelay = 0,
                layoutOrder = 0,
                testId = 0
            }

            function tbl2.onActivated(vector2: Vector2)
                tbl1.onReactionSelected(reactionType, vector2)
            end
            tbl2.entryDelay = (layoutOrder - 1) * 0.04
            tbl2.layoutOrder = layoutOrder
            tbl2.testId = `{testId}--{reactionType}`
            result[reactionType] = createElement(var4, tbl2)
        end

        return result
    end, {
        var2,
        selectedReactions,
        tbl1.hoveredReaction,
        tbl1.reactionSize,
        tbl1.getButtonRef,
        tbl1.onReactionSelected,
        testId
    })

    return React.createElement(View, {
        tag = {
            ["row gap-xxsmall auto-xy padding-small stroke-standard stroke-default"] = true,
            ["radius-small"] = var3 == Radius.Small,
            ["radius-medium"] = var3 == Radius.Medium,
            ["radius-circle"] = var3 == Radius.Circle
        },
        backgroundStyle = tbl1.backgroundStyle or var1.Color.Surface.Surface_200,
        LayoutOrder = tbl1.layoutOrder,
        testId = testId
    }, var4)
end

return ReactionPicker
