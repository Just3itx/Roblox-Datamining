-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function makeHttpServiceMock(arg1, arg2)
    return {
        RequestInternal = function(_)
            return {
                Start = function(_, callback)
                    callback(arg1, arg2)
                end
            }
        end
    }
end

return makeHttpServiceMock
