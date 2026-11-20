-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local OdpSessionApiProvider = require(AmpV2Wizard.OdpSessionApiProvider)

return (React.createContext(OdpSessionApiProvider))
