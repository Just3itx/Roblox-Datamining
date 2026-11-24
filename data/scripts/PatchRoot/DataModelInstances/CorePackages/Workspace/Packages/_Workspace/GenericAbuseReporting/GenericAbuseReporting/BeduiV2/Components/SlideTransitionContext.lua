-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)

local binding = React.createBinding(false)
local context = React.createContext(binding)

return {
    Provider = context.Provider,
    useIsSlideAnimating = function()
        return React.useContext(context)
    end
}
