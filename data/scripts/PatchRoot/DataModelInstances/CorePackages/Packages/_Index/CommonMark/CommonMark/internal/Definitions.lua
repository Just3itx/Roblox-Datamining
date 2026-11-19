-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:20:33Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _DefinitionMap = require(CommonMark.node.DefinitionMap)

local module = {}
module.__index = module

function module.new()
    return (setmetatable({ _definitionsByType = {} }, module))
end

function module:addDefinitions(arg1)
    local map = self:getMap(arg1:getType())
    if map == nil then
        self._definitionsByType[arg1:getType()] = arg1
        return
    end
    map:addAll(arg1)
end

function module.getDefinition(arg1, str1: string, str2: string)
    local map = arg1:getMap(str1)
    if map == nil then
        return nil
    end
    return map:get(str2)
end

function module:getMap(str1: string)
    return self._definitionsByType[str1]
end

return module
