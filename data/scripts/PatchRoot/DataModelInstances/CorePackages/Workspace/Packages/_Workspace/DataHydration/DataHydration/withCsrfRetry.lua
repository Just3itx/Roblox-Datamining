-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local function getCsrfToken(tbl1)
    local headers = tbl1.headers
    if headers == nil then
        return nil
    end
    for k, header in headers do
        if string.lower(tostring(k)) == "x-csrf-token" then
            return header
        end
    end
    return nil
end

local function mergeHeaders(headers, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = ({})
    if headers then
        for k, header in headers do
            result[k] = header
        end
    end
    for value, value2 in tbl1 do
        result[value] = value2
    end
    return result
end

local function withCsrfRetry(arg1)
    return {
        request = function(arg2, callback: (...any) -> (...any))
            local bool1 = false
            local var1 = nil

            var1 = arg1.request(arg2, function(arg3, arg4)
                if bool1 then
                    return
                end

                if not arg3 or typeof(arg4) ~= "table" then
                    callback(arg3, arg4)
                    return
                end

                if arg4.statusCode ~= 403 then
                    callback(true, arg4)
                    return
                end

                local csrfToken = getCsrfToken(arg4)
                if csrfToken == nil then
                    callback(true, arg4)
                    return
                end

                local tbl1 = {
                    url = arg2.url,
                    method = arg2.method,
                    body = arg2.body,
                    headers = mergeHeaders(arg2.headers, { ["x-csrf-token"] = csrfToken })
                }
                var1 = arg1.request(tbl1, function(arg5, arg6)
                    if bool1 then
                        return
                    end
                    callback(arg5, arg6)
                end)
            end)

            return function()
                if bool1 then
                    return
                end
                bool1 = true
                if var1 then
                    var1()
                end
            end
        end
    }
end

return withCsrfRetry
