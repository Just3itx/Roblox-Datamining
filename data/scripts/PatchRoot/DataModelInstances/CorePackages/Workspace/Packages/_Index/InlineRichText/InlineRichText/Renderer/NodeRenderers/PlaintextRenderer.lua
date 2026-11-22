-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")

local _Types = require(InlineRichText.Types)

return function(arg1, _)
    return {{
        text = arg1.text,
        engineTags = {}
    }}
end
