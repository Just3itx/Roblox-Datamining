-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DsnUtils = require(script.Parent.DsnUtils)

local module = {}
module.__index = module

function module.new(_, str1: string, httpServiceImpl)
    local dsn, var2 = DsnUtils.parse_dsn(str1 or "")
    if not dsn then
        error("Invalid DSN: " .. (var2 or "Unknown error"))
    end

    return (setmetatable({
        httpServiceImpl = httpServiceImpl,
        dsn = dsn,
        endpoint = DsnUtils.build_ingest_url(dsn),
        headers = {
            ["X-Sentry-Auth"] = DsnUtils.build_auth_header(dsn)
        }
    }, module))
end

function module:send(arg1, callback: ((...any) -> (...any))?)
    local body = self.httpServiceImpl:JSONEncode(arg1)

    local success, result = pcall(function()
        self.httpServiceImpl:RequestInternal({ Url = self.endpoint, Method = "POST", Headers = self.headers, Body = body }):Start(
            function(arg2, body2)
                if not callback then
                    return
                end

                if arg2 then
                    callback(true, { error = nil, body = body2 })
                    return
                end

                local tbl1 = {
                    error = "HTTP request failed: " .. tostring(body2),
                    body = nil
                }

                callback(false, tbl1)
            end
        )
    end)

    if not success and callback then
        callback(false, { error = "Failed to create HTTP request: " .. tostring(result), body = nil })
    end
end

function module:send_attachments(eventId: string, tbl1, callback: ((...any) -> (...any))?)
    local httpServiceImpl = self.httpServiceImpl

    if not eventId or #tbl1 == 0 then
        if callback then
            callback(false, { error = "eventId and attachments are required", body = nil })
        end
        return
    end

    local tbl2 = { (httpServiceImpl:JSONEncode({ event_id = eventId, sent_at = os.date("!%Y-%m-%dT%H:%M:%SZ") })) }

    for _, value in ipairs(tbl1) do
        local tbl3 = {
            type = "attachment",
            length = string.len(value.data),
            filename = value.filename,
            content_type = value.content_type or "application/octet-stream"
        }
        table.insert(tbl2, (httpServiceImpl:JSONEncode(tbl3)))
        table.insert(tbl2, value.data)
    end

    local body = table.concat(tbl2, "\n")
    local url = DsnUtils.build_envelope_url(self.dsn)

    local success, result = pcall(function()
        httpServiceImpl:RequestInternal({ Url = url, Method = "POST", Headers = self.headers, Body = body }):Start(function(arg1, body2)
            if not callback then
                return
            end

            if arg1 then
                callback(true, { error = nil, body = body2 })
                return
            end
            local tbl3 = {
                error = "HTTP request failed: " .. tostring(body2),
                body = nil
            }

            callback(false, tbl3)
        end)
    end)

    if not success and callback then
        callback(false, { error = "Failed to create HTTP request: " .. tostring(result), body = nil })
    end
end

return module
