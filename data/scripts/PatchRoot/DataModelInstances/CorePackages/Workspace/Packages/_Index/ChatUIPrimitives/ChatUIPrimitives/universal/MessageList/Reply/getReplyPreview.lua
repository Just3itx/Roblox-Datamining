-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _projectMessageEnvelope = require(script.Parent.Parent.projectMessageEnvelope)

local function getReference(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local repliesTo = arg1.repliesTo
    return if repliesTo == nil then nil else repliesTo[1]
end

local function getReplyText(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local reference = getReference(arg1)
    local preview = if reference == nil then nil else reference.preview
    return if preview == nil or preview.fallbackText == "" then nil else preview.fallbackText
end

return {
    getReplyText = getReplyText,
    getReplyLabel = function(arg1)
        local reference = getReference(arg1)

        if reference == nil or getReplyText(arg1) == nil then
            return nil
        end
        local label = reference.label
        return if label == nil or label == "" then nil else label
    end
}
