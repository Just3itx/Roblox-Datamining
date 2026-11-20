-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)
local _Types = require(AmpV2Wizard.Types)
local WizardSpinner = require(AmpV2Wizard.WizardSpinner)
local OdpSessionApiContext = require(AmpV2Wizard.OdpSessionApiContext)

local function CreateOdpSessionNode(arg1)
    local report = arg1.report
    local props = arg1.props
    local var1 = React.useContext(OdpSessionApiContext)

    React.useEffect(function()
        local bool1 = false

        local tbl1 = {
            requestType = props.requestType,
            requestDetails = props.requestDetails,
            isOdpInitiatedRequest = props.isOdpInitiated,
            odpProfileId = props.odpProfileId
        }

        var1.startOdpSession(tbl1):andThen(function(arg2)
            if not bool1 then
                report("Success", { odpSessionId = arg2.odpSessionId })
            end
        end):catch(function()
            if not bool1 then
                report("Error")
            end
        end)

        return function()
            bool1 = true
        end
    end, {})

    return React.createElement(WizardSpinner)
end

return CreateOdpSessionNode
