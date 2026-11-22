-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent
local Foundation = require(InlineRichTextParent.Foundation)
local var1 = require(InlineRichText.Logger):new(script.Name)

local isBuilderIcon = Foundation.Utility.isBuilderIcon

local IconElement = require(InlineRichText.Renderer.InlineElements.IconElement)

local _Types = require(InlineRichText.Types)

return function(arg1, arg2)
    local name = arg1.attributes.name
    if not name then
        var1:warning("IconRenderer: No name provided for icon")
        return {}
    end
    if not isBuilderIcon(name) then
        var1:warning(
            `IconRenderer: Icon {name} is not a builder icon. You must provide a Foundation builder icon name.`
        )
        return {}
    end

    return { IconElement.new({ name = name, size = tonumber(arg1.attributes.size) or arg2.styles.fontStyle.FontSize or 18 }) }
end
