-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local textLabel = Instance.new("TextLabel")
textLabel.RichText = true
local function getContentText(textLabelText): string -- Luacid: Inlined by compiler; 1 call site recovered
    textLabel.Text = textLabelText
    return textLabel.ContentText
end

local function isWhitespaceOnly(text): boolean
    local contentText = getContentText(text)
    return string.find(contentText, "%S") == nil
end

return isWhitespaceOnly
