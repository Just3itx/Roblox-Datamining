-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlainTextContentModel = require(script.Parent.Parent.ContentKinds.PlainText.PlainTextContentModel)

local module = {}

function module.fromText(str1: string)
    return PlainTextContentModel.fromText(str1)
end

return module
