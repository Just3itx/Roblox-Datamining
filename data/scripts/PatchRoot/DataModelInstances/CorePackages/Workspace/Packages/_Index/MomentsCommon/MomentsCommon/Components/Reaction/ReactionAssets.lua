-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local ReactionSize = require(MomentsCommon.Enums.ReactionSize)
local ReactionType = require(MomentsCommon.Enums.ReactionType)

local tbl1 = {
    [ReactionType.ThumbsUp] = "thumbs-up",
    [ReactionType.Heart] = "heart",
    [ReactionType.LaughJoy] = "laugh-joy",
    [ReactionType.Wow] = "wow",
    [ReactionType.Cry] = "crying",
    [ReactionType.Fire] = "fire",
    [ReactionType.Skull] = "skull"
}

local tbl2 = {
    [ReactionSize.XSmall] = "xsmall",
    [ReactionSize.Small] = "small",
    [ReactionSize.Medium] = "medium",
    [ReactionSize.Large] = "large"
}

local tbl3 = {
    [ReactionSize.XSmall] = 20,
    [ReactionSize.Small] = 24,
    [ReactionSize.Medium] = 32,
    [ReactionSize.Large] = 48
}

local bool1 = game:DefineFastFlag("MomentsUpdateReactionIllustrationQuality", false)

local function getScaleSuffix(num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if num1 > 2.5 then "@3x" elseif num1 > 1.5 then "@2x" else ""
end

local function getAssetKey(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return tbl1[arg1]
end

local function getSizeKey(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl2[arg1]
end

return {
    getAssetKey = getAssetKey,
    getAnimatedImageUri = function(str1: string): string
        return `rbxasset://textures/ui/Moments/Reactions/Animated/{str1}.png`
    end,
    getSizeKey = getSizeKey,
    getSizePixels = function(arg1)
        return tbl3[arg1]
    end,
    getStaticImageUri = function(arg1, arg2, num1: number?)
        local assetKey = getAssetKey(arg1)

        local sizeKey = getSizeKey(arg2)

        if assetKey == nil or sizeKey == nil then
            return nil
        end

        return `rbxasset://textures/ui/Moments/Reactions/{assetKey}-{sizeKey}{if bool1 then getScaleSuffix(num1 or GuiService:GetResolutionScale()) else ""}.png`
    end,
    getStickerImageUri = function(arg1)
        local assetKey = getAssetKey(arg1)

        if assetKey == nil then
            return nil
        end

        return `rbxasset://textures/ui/Moments/Reactions/{assetKey}-large@3x.png`
    end
}
