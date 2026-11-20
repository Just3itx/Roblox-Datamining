-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Flags = require(script.Flags)
local _MarkdownViewer = require(script.Components.MarkdownViewer)
local _NodeType = require(script.Enums.NodeType)
local _Types = require(script.Types)
local lazyMembers = require(script.lazyMembers)

local function profile() -- Luacid: Inlined by compiler; 4 call sites recovered
    return require(script.Parsers.RobloxMarkdown)
end

local tbl1 = {
    Components = require(script.Components),
    Enums = require(script.Enums),
    Parsers = require(script.Parsers),
    Utils = require(script.Utils),
    parse = nil,
    safeParse = nil,
    toRendererAst = function(arg1)
        return (profile().toRendererAst(arg1))
    end,
    parseOptions = nil,
    createParser = nil,
    Adapter = nil,
    Flags = Flags
}

lazyMembers(tbl1, {
    parse = function()
        return profile().parse
    end,
    safeParse = function()
        return profile().safeParse
    end,
    parseOptions = function()
        return profile().parseOptions
    end,
    createParser = function()
        return require(script.Adapter.createParser)
    end,
    Adapter = function()
        return table.freeze({ Rules = require(script.Adapter).Rules })
    end
})

return tbl1
