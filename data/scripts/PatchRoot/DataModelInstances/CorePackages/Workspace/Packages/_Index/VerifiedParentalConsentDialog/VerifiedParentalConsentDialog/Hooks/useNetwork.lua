-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerifiedParentalConsentDialog = script:FindFirstAncestor("VerifiedParentalConsentDialog")
local VerifiedParentalConsentDialogParent = VerifiedParentalConsentDialog.Parent
local React = require(VerifiedParentalConsentDialogParent.React)

local NetworkContext = require(VerifiedParentalConsentDialog.Hooks.NetworkContext)

local function useNetwork()
    return React.useContext(NetworkContext)
end

return useNetwork
