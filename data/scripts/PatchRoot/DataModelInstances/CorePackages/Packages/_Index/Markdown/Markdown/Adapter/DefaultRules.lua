-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local _AdapterTypes = require(script.Parent.AdapterTypes)
local _CommonMark = require(MarkdownParent.CommonMark)
local Rules = require(script.Parent.Rules)

local function literalOf(arg1)
    return arg1.literal or ""
end

local function softLineBreak(_): string
    return "\n"
end

local module = {}

function module.register(arg1)
    arg1:block("Paragraph", { as = "PARAGRAPH" })
    arg1:block("Heading", {
        as = "HEADING",
        attributes = function(arg2)
            return {
                depth = arg2.level
            }
        end
    })

    arg1:block("ThematicBreak", Rules.divider())
    arg1:block("FencedCodeBlock", Rules.codeBlock())
    arg1:block("IndentedCodeBlock", Rules.codeBlock())
    arg1:block("HtmlBlock", Rules.htmlBlock())
    local var1 = Rules.list()
    arg1:block("BulletList", var1)
    arg1:block("OrderedList", var1)
    arg1:block("BlockQuote", Rules.quote())
    arg1:block("LinkReferenceDefinition", "drop")

    arg1:inline("Text", { text = literalOf })
    arg1:inline("HtmlInline", { text = literalOf })
    arg1:inline("SoftLineBreak", { text = softLineBreak })
    arg1:inline("HardLineBreak", Rules.hardLineBreak())
    arg1:inline("Code", Rules.code())
    arg1:inline("Link", Rules.link())
    arg1:inline("Image", Rules.image())
    arg1:inline("Emphasis", { style = "ITALIC" })
    arg1:inline("StrongEmphasis", { style = "BOLD_2" })
    arg1:inline("Strikethrough", { style = "STRIKE" })
end

return module
