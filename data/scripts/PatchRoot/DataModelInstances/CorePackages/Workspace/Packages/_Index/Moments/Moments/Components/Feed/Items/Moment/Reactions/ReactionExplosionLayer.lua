-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local View = Foundation.View
local useSignalState = SignalsReact.useSignalState

local ReactionEffectsContext = require(script.Parent.ReactionEffectsContext)
local reactionsConstants = require(script.Parent.reactionsConstants)
local ReactionExplosion = if require(Moments.Flags.FFlagMomentsUseSharedReactions) then require(MomentsParent.Reactions.ReactionExplosion) else require(script.Parent.ReactionExplosion)
local useReactionEffects = ReactionEffectsContext.useReactionEffects
local EXPLOSION_LAYER_ZINDEX = reactionsConstants.EXPLOSION_LAYER_ZINDEX

local signal = Signals.createSignal({})

return React.memo(function() -- name: ReactionExplosionLayer
    local var1 = useReactionEffects()
    local var2 = if var1 ~= nil then var1.getExplosions else signal
    local tbl1 = ({})

    for _, value in (useSignalState(var2)) do
        local str1 = `explosion_{value.id}`
        local createElement = React.createElement
        local var3 = ReactionExplosion
        local tbl2 = {
            reactionType = value.reactionType,
            position = UDim2.fromOffset(value.originLocal.X, value.originLocal.Y),
            onComplete = 0
        }

        function tbl2.onComplete()
            if var1 ~= nil then
                var1.onExplosionComplete(value.id)
            end
        end

        tbl1[str1] = createElement(var3, tbl2)
    end

    return React.createElement(View, {
        ref = if var1 == nil then nil else var1.layerRef,
        tag = "size-full",
        BackgroundTransparency = 1,
        ZIndex = EXPLOSION_LAYER_ZINDEX
    }, tbl1)
end)
