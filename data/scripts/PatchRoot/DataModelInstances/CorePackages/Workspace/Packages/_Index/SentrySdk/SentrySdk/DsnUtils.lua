-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Version = require(script.Parent.Version)

local module = {}

function module.parse_dsn(str1: string)
    if not str1 or str1 == "" then
        return nil, "DSN is required"
    end

    local protocol, var2, var3 = str1:match("^(https?)://([^@]+)@(.+)$")

    if not (protocol and var2 and var3) then
        return nil, "Invalid DSN format"
    end

    local var4, var5 = var2:match("^([^:]+):(.+)$")
    if var4 then
        var2 = var4
    else
        var5 = ""
    end

    if not var2 or var2 == "" then
        return nil, "Invalid DSN format"
    end

    local host, path = var3:match("^([^/]+)(.*)$")
    if not host or not path or path == "" then
        return nil, "Invalid DSN format"
    end

    local projectId = path:match("/([%d]+)$")
    if not projectId then
        return nil, "Could not extract project ID from DSN"
    end

    return {
        protocol = protocol,
        public_key = var2,
        secret_key = var5 or "",
        host = host,
        path = path,
        project_id = projectId
    }, nil
end

function module.build_ingest_url(tbl1): string
    return `https://{tbl1.host}/api/{tbl1.project_id}/store/`
end

function module.build_envelope_url(tbl1): string
    return `https://{tbl1.host}/api/{tbl1.project_id}/envelope/`
end

function module.build_auth_header(tbl1): string
    return `Sentry sentry_version={Version.SENTRY_VERSION}, sentry_key={tbl1.public_key}, sentry_client=sentry-lua/{Version.SDK_VERSION}`
end

return module
