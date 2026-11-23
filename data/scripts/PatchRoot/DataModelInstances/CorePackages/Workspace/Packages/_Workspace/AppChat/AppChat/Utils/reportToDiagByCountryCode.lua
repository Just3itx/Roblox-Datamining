-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local ReportToDiagByCountryCode = require(AppChatParent.Analytics).ReportToDiagByCountryCode

return function(arg1, arg2, num1: number)
    ReportToDiagByCountryCode(arg1, arg2, num1 * 1000, 100)
end
