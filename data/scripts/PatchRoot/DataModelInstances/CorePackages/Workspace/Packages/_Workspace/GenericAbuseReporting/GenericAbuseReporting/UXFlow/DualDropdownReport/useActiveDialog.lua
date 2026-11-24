-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)

local function useActiveDialog()
    local var1, var2 = React.useState("Form")
    return var1, var2
end

return useActiveDialog
