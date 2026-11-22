-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.Parent.types)

return function(callback): (string) -> ()
    return function(str1: string)
        callback(function(arg1)
            local var1 = arg1[str1]
            if var1 == nil then
                return arg1
            end

            local var2 = table.clone(arg1)
            var2[str1] = {
                startTime = nil,
                endTime = nil,
                deltaMs = nil,
                sent = nil,
                metadata = table.clone(var1.metadata)
            }
            return var2
        end)
    end
end
