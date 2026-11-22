-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.Parent.types)

return function(callback)
    return function()
        local result = {}
        callback(function(arg1)
            local result2 = ({})
            for value, value2 in arg1 do
                if value2 and (value2.startTime == nil or value2.sent == true) then
                    result2[value] = value2
                else
                    table.insert(result, value)
                end
            end
            return result2
        end)
        return result
    end
end
