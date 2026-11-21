-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local Foundation = require(ChatUIPrimitivesParent.Foundation)

local formatInlineIcon = require(ChatUIPrimitives.Utils.formatInlineIcon)

local IconName = Foundation.Enums.IconName

local function ceilToEven(num1: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return math.max(0, math.ceil(num1 / 2) * 2)
end

local function getPresetIconSize(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return ceilToEven(num1 * 3 / 4)
end

local function getPresetIconRichText(num1: number)
    return formatInlineIcon(IconName.LightningBolt, { weight = "700", size = tostring((getPresetIconSize(num1))) })
end

return getPresetIconRichText
