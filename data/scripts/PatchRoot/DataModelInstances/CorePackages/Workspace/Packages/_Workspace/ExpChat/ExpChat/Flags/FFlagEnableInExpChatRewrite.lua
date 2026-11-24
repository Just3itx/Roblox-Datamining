-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local SocialExperiments = require(ExpChatParent.SocialExperiments)

local engineFeature = game:GetEngineFeature("EnableInExpChatRewrite")
local deviceNameBlackListString = game:DefineFastString("InExpChatRewriteDeviceNameBlackList", "")
local osVersionBlackListString = game:DefineFastString("InExpChatRewriteOsVersionBlackList", "")
local enabled = game:DefineFastFlag("EnableDeviceGateForInExpChatRewrite", false)

if not (engineFeature and enabled) then
    return engineFeature
end

return not SocialExperiments.GetIsDeviceGated({
    enabled = enabled,
    featureName = SocialExperiments.DeviceGateFeature.InExpChatRewrite,
    deviceNameBlackListString = deviceNameBlackListString,
    osVersionBlackListString = osVersionBlackListString
})
