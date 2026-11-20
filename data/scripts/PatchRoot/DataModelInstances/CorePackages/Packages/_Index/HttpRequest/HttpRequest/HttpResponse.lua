-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module
function module.__tostring(arg1): string
    local tbl1 = {}

    for k, value in pairs(arg1) do
        table.insert(tbl1, string.format("%s = %s", tostring(k), tostring(value)))
    end
    table.sort(tbl1)

    return "<HttpResponse: " .. table.concat(tbl1, ", ") .. ">"
end

function module.success(responseCode, responseBody)
    return (setmetatable({ responseCode = responseCode, responseBody = responseBody }, module))
end

function module.error(httpError)
    return (setmetatable({ HttpError = httpError }, module))
end

return module
