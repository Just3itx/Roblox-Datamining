-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")
local ReactionsParent = Reactions.Parent

local React = require(ReactionsParent.React)

local _ReactionType = require(Reactions.Enums.ReactionType)
local playReactionHoverHaptic = require(Reactions.Utils.playReactionHoverHaptic)
local toGuiSpace = require(Reactions.Utils.toGuiSpace)

local function containsPoint(arg1, vector2: Vector2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local absolutePosition = arg1.AbsolutePosition
    local var1 = absolutePosition + arg1.AbsoluteSize
    return vector2.X >= absolutePosition.X and vector2.X <= var1.X and vector2.Y >= absolutePosition.Y and vector2.Y <= var1.Y
end

local function findReactionAt(current, vector2: Vector2)
    for value, value2 in current do
        if containsPoint(value2, (toGuiSpace(vector2, value2))) then
            return value, value2
        end
    end
    return nil, nil
end

local function useReactionDragSelect(current: (...any) -> (...any))
    local var1 = React.useRef(current)
    var1.current = current

    local var2 = React.useRef({})
    local var3 = React.useRef({})

    local hoveredReaction, var5 = React.useState(nil)
    local var6 = React.useRef(nil)

    local var7 = React.useCallback(function(current2)
        if var6.current == current2 then
            return
        end
        var6.current = current2
        var5(current2)
        if current2 ~= nil then
            playReactionHoverHaptic()
        end
    end, {})

    return {
        hoveredReaction = hoveredReaction,
        getButtonRef = React.useCallback(function(arg1)
            local current2 = var3.current
            local func1 = current2[arg1]
            if func1 == nil then
                func1 = function(arg2)
                    var2.current[arg1] = arg2
                end
                current2[arg1] = func1
            end
            return func1
        end, {}),
        onDragMoved = React.useCallback(function(vector2: Vector2)
            local reactionAt = findReactionAt(var2.current, vector2)
            var7(reactionAt)
        end, { var7 }),
        onDragEnded = React.useCallback(function(vector2: Vector2?)
            var7(nil)
            if vector2 == nil then
                return
            end
            local var8, var9 = findReactionAt(var2.current, vector2)
            if var8 ~= nil and var9 ~= nil then
                var1.current(var8, var9.AbsolutePosition + var9.AbsoluteSize / 2)
            end
        end, { var7 })
    }
end

return useReactionDragSelect
