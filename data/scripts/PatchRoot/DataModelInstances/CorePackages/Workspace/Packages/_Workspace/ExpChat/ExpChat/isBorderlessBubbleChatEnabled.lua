-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local ExpChatPresetChatEmojiTabExperimentation = require(ExpChatParent.SocialExperiments).ExpChatPresetChatEmojiTabExperimentation

local ExpChatPresetChatEmojiEffectExperimentation = require(ExpChatParent.SocialExperiments).ExpChatPresetChatEmojiEffectExperimentation

local FFlagExpChatMessageEffectBorderlessBubbleChatRolloutEnabled = require(ExpChat.Flags.FFlagExpChatMessageEffectBorderlessBubbleChatRolloutEnabled)

local var1 = nil

local function isBorderlessBubbleChatEnabled()
    if var1 == nil then
        var1 = FFlagExpChatMessageEffectBorderlessBubbleChatRolloutEnabled
            or ExpChatPresetChatEmojiTabExperimentation.getIsEmphasizedRenderingEnabled()
            or ExpChatPresetChatEmojiEffectExperimentation.getHasBorderlessBubbleChatEffect()
    end
    return var1
end

return isBorderlessBubbleChatEnabled
