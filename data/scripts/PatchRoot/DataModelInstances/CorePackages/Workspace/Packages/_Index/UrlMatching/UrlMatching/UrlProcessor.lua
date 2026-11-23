-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local UrlMatcher = require(script.Parent.UrlMatcher)
local UrlValidation = require(script.Parent.UrlValidation)
local _Types = require(script.Parent.Types)
local Cryo = require(scriptParentParent.Cryo)

local module = {}
module.__index = module

function module.new(arg1, _urlMap)
    local var1 = Cryo.Dictionary.union(arg1 or {}, { pathPatterns = Cryo.Dictionary.keys(_urlMap) })
    local tbl1 = {
        _urlMatcher = UrlMatcher.new(var1),
        _urlMap = _urlMap
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:process(str1: string)
    local var1 = self._urlMatcher:match(str1)
    return Cryo.List.filterMap(var1, function(arg1): {endIndex: any, result: any, startIndex: any}?
        local var2, var3 = UrlValidation.validateUrlMatch(arg1, self._urlMap)
        return if var2 then {
            startIndex = arg1.startIndex,
            endIndex = arg1.endIndex,
            result = var3
        } else nil
    end)
end

return module
