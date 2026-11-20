-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2WizardParent = script:FindFirstAncestor("AmpV2Wizard").Parent

local React = require(AmpV2WizardParent.React)

local Foundation = require(AmpV2WizardParent.Foundation)
local Loading = Foundation.Loading
local IconSize = Foundation.Enums.IconSize

local function WizardSpinner()
    return React.createElement(
        Loading,
        {
            size = IconSize.Medium,
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }
    )
end
return WizardSpinner
