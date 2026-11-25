-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)

local function createSduiErrorLogger(arg1, arg2, str1: string?)
    local var1 = table.clone(arg1)

    local var2 = var1.__sduiReportError or arg1.reportError
    local var3 = arg2 or var1.__sduiErrorContext
    var1.__sduiReportError = var2
    var1.__sduiErrorContext = var3
    function var1.reportError(arg3, arg4, str2: string, ...)
        local var4 = table.clone(arg4)

        if not arg4.fullName and not arg4.rctPath and not arg4.templateId and var3 then
            addSduiErrorContextFields(var4, var3)
        end
        var4.name = var4.name or str1
        var2(arg3, var4, str2, ...)
    end
    return var1
end

return createSduiErrorLogger
