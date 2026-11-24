-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local ExpChatShared = require(ExpChatParent.ExpChatShared)

local ExpChatGlobalTabDefaultExperimentation = require(ExpChatParent.SocialExperiments).ExpChatGlobalTabDefaultExperimentation

local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs

local isGlobalTabDefault = nil

local function isGlobalTabFirst()
    if isGlobalTabDefault == nil then
        isGlobalTabDefault = GetFFlagTextChatEnableUniverseChatTabs() and ExpChatGlobalTabDefaultExperimentation.getIsGlobalTabDefault()
    end
    return isGlobalTabDefault
end

return isGlobalTabFirst
