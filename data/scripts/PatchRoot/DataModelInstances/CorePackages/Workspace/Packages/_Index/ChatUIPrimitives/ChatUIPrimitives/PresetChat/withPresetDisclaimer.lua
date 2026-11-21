-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local _Types = require(ChatUIPrimitives.UniversalMessage.Types)

local function hasPreset(arg1)
    for _, value in arg1.categories do
        for _, item in value.items do
            if item.content.kind == "preset" then
                return true
            end
        end
    end
    return false
end

local function withPresetDisclaimer(tbl1, func1: (...any) -> (...any))
    local result = {}
    for _, value in tbl1 do
        if value.footerText == nil and hasPreset(value) then
            value = table.clone(value)
            value.footerText = func1("Feature.Chat.PresetChat.Disclaimer")
        end
        table.insert(result, value)
    end
    return result
end

return withPresetDisclaimer
