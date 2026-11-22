-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent

local Cryo = require(InlineRichTextParent.Cryo)
local _Types = require(InlineRichText.Types)

return function(arg1, arg2)
    local tbl1 = {
        name = arg1.name,
        attributes = arg1.attributes
    }
    local var1 = arg2.processChildren(arg1, arg2)

    return Cryo.List.map(var1, function(arg3)
        return {
            text = arg3.text,
            engineTags = Cryo.List.join(arg3.engineTags, { tbl1 })
        }
    end)
end
