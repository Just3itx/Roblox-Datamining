-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local ExpChatGlobalTabDefaultExperimentation = require(ExpChatParent.SocialExperiments).ExpChatGlobalTabDefaultExperimentation

local globalWelcomeMessageKey = nil

local function getGlobalWelcomeMessageKey()
    if globalWelcomeMessageKey == nil then
        globalWelcomeMessageKey = ExpChatGlobalTabDefaultExperimentation.getGlobalWelcomeMessageKey()
    end
    return globalWelcomeMessageKey
end

return getGlobalWelcomeMessageKey
