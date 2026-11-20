-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)
local _Types = require(AmpV2Wizard.Types)
local WizardSpinner = require(AmpV2Wizard.WizardSpinner)
local AuthorizationLoadingModal = require(AmpV2Wizard.AuthorizationLoadingModal)
local FFlagAmpV2WizardAuthorizationModal = require(AmpV2Wizard.FFlagAmpV2WizardAuthorizationModal)

local function SessionPollingNode(arg1)
    local report = arg1.report
    local props = arg1.props
    local pollIntervalMs = props.pollIntervalMs or 2000

    React.useEffect(function()
        local var1 = task.delay(pollIntervalMs / 1000, function()
            report("Poll")
        end)
        return function()
            task.cancel(var1)
        end
    end, { props, pollIntervalMs, report })

    if FFlagAmpV2WizardAuthorizationModal and arg1.dismiss ~= nil then
        return React.createElement(AuthorizationLoadingModal, { onCancel = arg1.dismiss })
    end

    return React.createElement(WizardSpinner)
end

return SessionPollingNode
