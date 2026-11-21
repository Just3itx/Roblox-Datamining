-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")

local _Types = require(ChatUIPrimitives.Types)

local function shouldOfferTranslation(arg1, bool1: boolean): boolean
    if not bool1 then
        return false
    end
    local translation = arg1.translation
    return not (translation == nil or translation == "") and translation ~= arg1.content
end

return shouldOfferTranslation
