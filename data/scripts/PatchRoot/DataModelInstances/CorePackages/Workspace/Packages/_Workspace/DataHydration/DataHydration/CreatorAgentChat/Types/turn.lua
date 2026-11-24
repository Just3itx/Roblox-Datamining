-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
local _common = require(script.Parent.common)
local _model = require(script.Parent.model)
local _acpSession = require(script.Parent.acpSession)

return {
    RequestFailureKind = table.freeze(
        {
            Timeout = "timeout",
            Transport = "transport",
            Http = "http",
            RpcError = "rpc_error",
            Unknown = "unknown"
        }
    )
}
