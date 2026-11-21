-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")

local useAdditionalAuditContent = require(AuthCommon.Stores.AuditContentContext.AuditContentContext).useAdditionalAuditContent

local GetFFlagEnableAuditSystem = require(AuthCommon.Flags.GetFFlagEnableAuditSystem)

local function RegisterAdditionalAuditContent(tbl1)
    if GetFFlagEnableAuditSystem() then
        useAdditionalAuditContent(tbl1.contentKey, tbl1.value)
    end
    return nil
end

return RegisterAdditionalAuditContent
