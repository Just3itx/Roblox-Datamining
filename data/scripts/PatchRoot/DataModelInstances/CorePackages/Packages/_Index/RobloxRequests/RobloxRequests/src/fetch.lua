-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Promise = require(scriptParentParentParent.Promise)

function createFetch(arg1)
    local function fetch(arg2, arg3)
        arg3 = arg3 == nil and {} or arg3

        local method = arg3.method or "GET"
        arg3.method = nil
        arg3.data = arg3.body
        arg3.body = nil
        return arg1(method, arg2, arg3):andThen(function(arg4)
            local text = arg4.text
            function arg4.text()
                return Promise.resolve(text)
            end
            arg4.status = arg4.code
            return arg4
        end)
    end
    return fetch
end

return createFetch
