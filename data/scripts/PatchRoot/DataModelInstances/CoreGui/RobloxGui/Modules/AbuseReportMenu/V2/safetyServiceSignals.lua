-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SafetyService = game:GetService("SafetyService")

local module = {}

function module.reportMenuTabOpen()
    SafetyService:ReportMenuTabOpen()
end

function module.reportMenuTabClose()
    SafetyService:ReportMenuTabClose()
end

return module
