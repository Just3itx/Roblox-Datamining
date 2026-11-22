-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.Parent.types)

return function(callback): (string) -> ()
    return function(str1: string)
        callback(function(arg1)
            if arg1[str1] == nil then
                return arg1
            end

            local var1 = table.clone(arg1)
            var1[str1] = nil
            return var1
        end)
    end
end
