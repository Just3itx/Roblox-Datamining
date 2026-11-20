-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local function func1(...)
    error("Not implemented. Dependencies used upstream aren't implemented")
end

return {
    default = function(arg1)
        local result = ({})

        for _, supportedCommand in ipairs(arg1.supportedCommands) do
            result[supportedCommand] = function(arg2, ...)
                func1(arg2, supportedCommand, ...)
            end
        end

        return result
    end
}
