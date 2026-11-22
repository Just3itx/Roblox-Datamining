-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")
local ReactionsParent = Reactions.Parent

local Foundation = require(ReactionsParent.Foundation)
local React = require(ReactionsParent.React)

local Constants = require(Reactions.Constants)
local ReactionSize = require(Reactions.Enums.ReactionSize)
local _ReactionType = require(Reactions.Enums.ReactionType)

local Image = Foundation.Image
local useTokens = Foundation.Hooks.useTokens

local function getSizeToken(arg1, size) -- Luacid: Inlined by compiler; 1 call site recovered
    if size == ReactionSize.XSmall then
        return arg1.Size.Size_500
    end

    if size == ReactionSize.Small then
        return arg1.Size.Size_600
    end

    if size == ReactionSize.Large then
        return arg1.Size.Size_1200
    end

    return arg1.Size.Size_800
end

return React.memo(function(tbl1) -- name: Reaction
    local var1 = useTokens()

    local image = if typeof(tbl1.reactionType) == "string" then Constants.ReactionIconMappings[tbl1.reactionType] else tbl1.reactionType:map(function(str1: string)
        return Constants.ReactionIconMappings[str1] or ""
    end)

    local sizeToken = getSizeToken(var1, tbl1.size)

    return React.createElement(Image, {
        Image = image,
        Size = tbl1.Size or UDim2.fromOffset(sizeToken, sizeToken),
        imageStyle = tbl1.imageStyle,
        LayoutOrder = tbl1.LayoutOrder,
        Position = tbl1.Position,
        Rotation = tbl1.Rotation,
        scale = tbl1.scale,
        AnchorPoint = tbl1.AnchorPoint,
        ZIndex = tbl1.ZIndex,
        testId = tbl1.testId
    })
end)
