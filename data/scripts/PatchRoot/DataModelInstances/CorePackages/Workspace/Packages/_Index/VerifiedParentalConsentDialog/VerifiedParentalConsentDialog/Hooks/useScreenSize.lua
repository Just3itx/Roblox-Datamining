-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerifiedParentalConsentDialog = script:FindFirstAncestor("VerifiedParentalConsentDialog")
local VerifiedParentalConsentDialogParent = VerifiedParentalConsentDialog.Parent
local React = require(VerifiedParentalConsentDialogParent.React)
local ScreenSizeContext = require(VerifiedParentalConsentDialog.Hooks.ScreenSizeContext)

local function useScreenSize()
    return React.useContext(ScreenSizeContext)
end

return useScreenSize
