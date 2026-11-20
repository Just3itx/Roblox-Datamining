-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)
local useNavigation = require(AmpV2WizardParent.Navigation).useNavigation
local AppPage = require(AmpV2WizardParent.RobloxAppEnums).AppPage
local _Types = require(AmpV2Wizard.Types)
local WizardSpinner = require(AmpV2Wizard.WizardSpinner)
local withAnalyticsSessionId = require(AmpV2Wizard.withAnalyticsSessionId)

local function RedirectNode(arg1)
    local report = arg1.report
    local props = arg1.props
    local analyticsSessionId = arg1.ctx.analyticsSessionId
    local var1 = useNavigation()

    React.useEffect(function()
        local url = props.url
        if type(url) ~= "string" or url == "" then
            report("__invalidRedirect__")
            return
        end

        local onTerminalRedirect = arg1.ctx.onTerminalRedirect
        if onTerminalRedirect ~= nil
            and arg1.transitions ~= nil
            and arg1.transitions.Done ~= nil
            and arg1.transitions.Done.kind == "Exit"
        then
            onTerminalRedirect(withAnalyticsSessionId(url, analyticsSessionId), props.title or "")

            report("Done")
            return
        end

        var1.push(AppPage.GenericWebPage, {
            detail = withAnalyticsSessionId(url, analyticsSessionId),
            extraProps = {
                title = props.title or "",
                onClose = function()
                    report("Done")
                end
            }
        })
    end, { props, report })

    return React.createElement(WizardSpinner)
end

return RedirectNode
