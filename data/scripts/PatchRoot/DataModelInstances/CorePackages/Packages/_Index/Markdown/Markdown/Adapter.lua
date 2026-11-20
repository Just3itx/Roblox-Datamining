-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local _AdapterTypes = require(script.AdapterTypes)
local _CommonMark = require(MarkdownParent.CommonMark)
local DefaultRules = require(script.DefaultRules)
local Engine = require(script.Engine)
local Registry = require(script.Registry)
local Rules = require(script.Rules)
local _Types = require(Markdown.Types)

local module = { Rules = Rules }

function module.build(tbl1)
    local var1 = Registry.build(DefaultRules.register, tbl1 or {})
    return table.freeze({
        toRendererAst = function(arg1, arg2)
            return Engine.adapt(var1, arg1, arg2)
        end
    })
end

return module
