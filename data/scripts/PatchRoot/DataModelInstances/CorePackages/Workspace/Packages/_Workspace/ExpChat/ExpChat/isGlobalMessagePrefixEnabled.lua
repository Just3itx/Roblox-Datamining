-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local ExpChatGlobalTabDefaultExperimentation = require(ExpChatParent.SocialExperiments).ExpChatGlobalTabDefaultExperimentation

local isGlobalMessagePrefixEnabled = nil

local function isGlobalMessagePrefixEnabled2()
    if isGlobalMessagePrefixEnabled == nil then
        isGlobalMessagePrefixEnabled = ExpChatGlobalTabDefaultExperimentation.getIsGlobalMessagePrefixEnabled()
    end
    return isGlobalMessagePrefixEnabled
end

return isGlobalMessagePrefixEnabled2
