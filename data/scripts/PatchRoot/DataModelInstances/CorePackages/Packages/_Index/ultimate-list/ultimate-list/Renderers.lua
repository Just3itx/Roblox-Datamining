-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ultimateList = script:FindFirstAncestor("ultimate-list")

local _React = require(ultimateList.Parent.React)

local module = {}

function module.byState(callback: (...any) -> (...any), config)
    return {
        type = "byState",
        callback = callback,
        config = config or {}
    }
end

function module.byBinding(callback: (...any) -> (...any))
    return { type = "byBinding", callback = callback }
end

return module
