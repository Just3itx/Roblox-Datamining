-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent

local Cryo = require(InlineRichTextParent.Cryo)
local InlineLayout = require(InlineRichTextParent.InlineLayout)
local TextElement = InlineLayout.Components.InlineLayoutElements.TextElement
local LinkElement = InlineLayout.Components.InlineLayoutElements.LinkElement
local LinkBehavior = require(InlineRichText.Enums.LinkBehavior)
local InlineCustomRenderer = require(InlineRichText.Renderer.NodeRenderers.InlineCustomRenderer)

local _Types = require(InlineRichText.Types)

return function(arg1, arg2)
    local tbl1 = {
        textStyle = arg2.styles.textStyle,
        showUnderline = true
    }

    local var1 = Cryo.Dictionary.union(tbl1, arg2.nodeProps or {})

    local href = arg1.attributes.href or ""
    local linkBehavior = arg2.linker.evaluateLinkBehavior(href)
    if linkBehavior == LinkBehavior.Hide then
        return {}
    end

    if linkBehavior == LinkBehavior.Disable then
        return InlineCustomRenderer(Cryo.Dictionary.join(arg1, { name = "TEXT_SPAN" }), arg2)
    end

    local var3 = arg2.processChildren(arg1, arg2)
    local var4 = Cryo.List.map(var3, function(arg3, layoutOrder)
        return TextElement.new({
            LayoutOrder = layoutOrder,
            EngineTags = if var1.showUnderline then Cryo.List.join({{ name = "u", attributes = {} }}, arg3.engineTags) else arg3.engineTags,
            Text = arg3.text,
            fontStyle = arg2.styles.fontStyle,
            textStyle = Cryo.Dictionary.union(tbl1.textStyle, var1.textStyle)
        })
    end)
    return if #var4 > 0 then {
        LinkElement.new(var4, {
            onActivated = function()
                arg2.linker.onActivated({ url = href, linkBehavior = linkBehavior })
            end
        })
    } else {}
end
