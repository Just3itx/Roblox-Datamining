-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent

local var1 = require(InlineRichText.Logger):new(script.Name)
local _Types = require(InlineRichText.Types)

local Cryo = require(InlineRichTextParent.Cryo)

return function(arg1, arg2)
    local inlineCustomRenderer = arg2.inlineCustomRenderers[arg1.name]
    if inlineCustomRenderer and typeof(inlineCustomRenderer) == "function" then
        return inlineCustomRenderer(arg1, Cryo.Dictionary.join(arg2, { nodeProps = arg2.nodeProps[arg1.name] or {} }))
    end

    var1:warning(
        `Node {arg1.name}: No custom renderer found. For custom tags, you must provide a renderer function in the renderers prop`
    )
    return {}
end
