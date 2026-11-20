-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local _Adapter = require(Markdown.Adapter)
local Parent = require(script.Parent)
local _Types = require(Markdown.Types)

local module = {}

function module.parse(str1: string, arg1)
    return (Parent.toRendererAst(Parent.parse(str1), arg1))
end

function module.safeParse(str1: string, arg1)
    if arg1 == nil then
        return pcall(module.parse, str1)
    end
    return pcall(module.parse, str1, arg1)
end

return module
