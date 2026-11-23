-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local _React = require(UserListParent.React)
local _Types = require(UserList.Common.Types)

local useCtaRenderRow = require(UserList.Hooks.useCtaRenderRow)

local function CtaRenderRowBridge(tbl1)
    local var1 = useCtaRenderRow(tbl1.ctaConfig, tbl1.renderRow)
    return tbl1.render(var1)
end

return CtaRenderRowBridge
