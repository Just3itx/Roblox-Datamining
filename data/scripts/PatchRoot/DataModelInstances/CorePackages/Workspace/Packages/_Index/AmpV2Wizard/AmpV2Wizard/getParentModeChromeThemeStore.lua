-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2WizardParent = script:FindFirstAncestor("AmpV2Wizard").Parent

local Signals = require(AmpV2WizardParent.Signals)

return Signals.createComputed(function() -- name: createParentModeChromeThemeStore
    local getIsActive, setIsActive = Signals.createSignal(false)
    return { getIsActive = getIsActive, setIsActive = setIsActive }
end)
