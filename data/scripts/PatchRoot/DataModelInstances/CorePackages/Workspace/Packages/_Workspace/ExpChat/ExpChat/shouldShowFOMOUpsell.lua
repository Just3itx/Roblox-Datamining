-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local FFlagExpChatUseGuacForFOMOUpsell = require(ExpChatParent.SharedFlags).FFlagExpChatUseGuacForFOMOUpsell

local UniversalAppPolicy = if FFlagExpChatUseGuacForFOMOUpsell then require(ExpChatParent.UniversalAppPolicy) else nil

local IXPServiceWrapper = require(ExpChat.IXPServiceWrapper)

local str1 = game:DefineFastString("ExpChatFOMOUpsellIXPLayerName", "User.Communication.NonAgeCheckedUser")
local str2 = game:DefineFastString("ExpChatFOMOUpsellIXPLayerValue", "FOMOUpsellEnabled")

local var1 = nil
local var2 = nil
local function fetchIXPData()
    var1, var2 = pcall(function()
        return IXPServiceWrapper:GetLayerData(str1)
    end)

    if not var1 or not var2 or var2[str2] == nil then
        return false
    end

    IXPServiceWrapper:LogUserLayerExposure(str1)
    return var2[str2]
end

return function()
    if not (FFlagExpChatUseGuacForFOMOUpsell and UniversalAppPolicy.getAppFeaturePolicies().getShowFOMOUpsell()) then
        return false
    elseif var1 and var2 then
        return var2[str2]
    end
    return (fetchIXPData())
end
