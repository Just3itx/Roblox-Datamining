-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent

local EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint = require(ChatUIPrimitivesParent.SharedFlags).EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint
local _Types = require(script.Parent.Types)
local _Types2 = require(script.Parent.Parent.UniversalMessage.Types)

local function presetMessageToContent(arg1): {kind: string, presetId: any, presetVersion: number, text: number}? -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.presetId == "" then
        return nil
    end

    return {
        kind = "preset",
        presetId = arg1.presetId,
        text = if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then arg1.text else arg1.value,
        presetVersion = arg1.presetVersion
    }
end
return {
    presetMessageToContent = presetMessageToContent,
    presetMessageToExpressionItem = function(arg1): {content: any}?
        local content = presetMessageToContent(arg1)
        return if content == nil then nil else { content = content }
    end
}
