-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = ({})
module.__index = module

function module.new()
    return (setmetatable({ _weakMap = setmetatable({}, { __mode = "k" }) }, module))
end

function module:get(arg1)
    return self._weakMap[arg1]
end

function module:set(arg1, arg2)
    self._weakMap[arg1] = arg2
    return self
end

function module:has(arg1): boolean
    return self._weakMap[arg1] ~= nil
end

return module
