-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint = require(ExpChatParent.SharedFlags).EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint

local _createPresetChatStore = require(ExpChat.Stores.GetPresetChatStore.createPresetChatStore)

local function hasPresetEmoji(tbl1)
    if not EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then
        return false
    end
    for _, value in tbl1 do
        for _, value2 in value.categories do
            for _, value3 in value2.contents or {} do
                if value3.kind == "Emoji" then
                    return true
                end
            end
        end
    end
    return false
end

return hasPresetEmoji
