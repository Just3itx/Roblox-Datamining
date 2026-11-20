-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local _AdapterTypes = require(script.Parent.AdapterTypes)
local _CommonMark = require(MarkdownParent.CommonMark)

local var1 = table.freeze({ PARAGRAPH = true, HEADING = true, QUOTE = true })

local var2 = table.freeze(
    {
        BOLD = true,
        BOLD_2 = true,
        ITALIC = true,
        ITALIC_2 = true,
        UNDERLINE = true,
        STRIKE = true,
        INLINE_CODE = true
    }
)

local var3 = table.freeze({ form = "children" })
local var4 = table.freeze({ form = "drop" })

local function policyRule(str1: string, str2: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    if str1 == "children" then
        return var3
    elseif str1 == "drop" then
        return var4
    end
    error(`{str2} must be "children" or "drop", not {str1}`)
end

local function commonRule(str1: string, handler)
    if handler == "children" then
        return var3
    elseif handler == "drop" then
        return var4
    end

    if type(handler) == "function" then
        return table.freeze({ form = "handler", handler = handler })
    end

    if type(handler) ~= "table" then
        error(`The rule for {str1} must be "children", "drop", a function or a table`)
    end
    return nil
end

local function inlineRule(str1: string, handler)
    local var5 = commonRule(str1, handler)
    if var5 ~= nil then
        return var5
    end

    if handler.style ~= nil then
        if not var2[handler.style] then
            error(`The rule for {str1} has an unknown style {handler.style}`)
        end
        return table.freeze({ form = "style", style = handler.style })
    end

    if type(handler.text) == "function" then
        return table.freeze({ form = "text", text = handler.text })
    end
    error(`The inline rule for {str1} needs a style or a text function`)
end

local function blockRule(str1: string, handler)
    local var5 = commonRule(str1, handler)
    if var5 ~= nil then
        return var5
    end

    if not var1[handler.as] then
        error(
            `The block rule for {str1} needs \`as\` a renderer block name that holds its children (PARAGRAPH, HEADING or QUOTE), not {handler.as}`
        )
    elseif handler.attributes ~= nil and type(handler.attributes) ~= "function" then
        error(`The block rule for {str1} has attributes that aren't a function`)
    end
    return table.freeze({ form = "as", as = handler.as, attributes = handler.attributes })
end

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new()
    return (setmetatable({
        _registry = {
            inline = {},
            block = {},
            unknownInline = var3,
            unknownBlock = var3,
            blockInText = "flatten",
            passes = { mergeText = true, dropEmpty = true }
        }
    }, tbl1))
end

function tbl1:inline(str1: string, handler)
    self._registry.inline[str1] = inlineRule(str1, handler)
end

function tbl1:block(str1: string, handler)
    self._registry.block[str1] = blockRule(str1, handler)
end

function tbl1:fallback(arg1)
    local _registry = self._registry
    if arg1.unknownInline ~= nil then
        local unknownInline = arg1.unknownInline
        local var5

        if unknownInline == "children" then
            var5 = policyRule("children", nil)
        elseif unknownInline == "drop" then
            var5 = policyRule("drop", nil)
        else
            error(`unknownInline must be "children" or "drop", not {unknownInline}`)
            var5 = nil
        end

        _registry.unknownInline = var5
    end
    if arg1.unknownBlock ~= nil then
        local unknownBlock = arg1.unknownBlock
        local var5

        if unknownBlock == "children" then
            var5 = policyRule("children", nil)
        elseif unknownBlock == "drop" then
            var5 = policyRule("drop", nil)
        else
            error(`unknownBlock must be "children" or "drop", not {unknownBlock}`)
            var5 = nil
        end

        _registry.unknownBlock = var5
    end
    local blockInText = arg1.blockInText
    if blockInText == nil then
        return
    end

    if blockInText ~= "flatten" and blockInText ~= "drop" then
        error(`blockInText must be "flatten" or "drop", not {blockInText}`)
    end
    _registry.blockInText = blockInText
end

function tbl1:pass(arg1, bool1: boolean)
    local passes = self._registry.passes
    if arg1 == "mergeText" then
        passes.mergeText = bool1
    elseif arg1 == "dropEmpty" then
        passes.dropEmpty = bool1
    else
        error(`Unknown adapter pass {arg1}`)
    end
end

local module = {}

function module.build(callback: (...any) -> (...any), tbl2)
    local var5 = tbl1.new()

    callback(var5)
    for _, value in tbl2 do
        local extendAdapter = value.extendAdapter
        if extendAdapter ~= nil then
            extendAdapter(var5)
        end
    end
    local _registry = var5._registry
    table.freeze(_registry.inline)
    table.freeze(_registry.block)
    table.freeze(_registry.passes)
    return table.freeze(_registry)
end

return module
