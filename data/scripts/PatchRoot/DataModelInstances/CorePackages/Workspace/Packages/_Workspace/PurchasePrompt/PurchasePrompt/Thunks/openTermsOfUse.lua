-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local UpsellFlow = require(scriptParentParent.Enums.UpsellFlow)
local getUpsellFlow = require(scriptParentParent.NativeUpsell.getUpsellFlow)
local ExternalSettings = require(scriptParentParent.Services.ExternalSettings)
local PlatformInterface = require(scriptParentParent.Services.PlatformInterface)
local Thunk = require(scriptParentParent.Thunk)
local AppPage = require(scriptParentParentParent.RobloxAppEnums).AppPage
local TermsOfUse = require(scriptParentParent.Misc.Constants).TermsOfUse
local AppContext = require(scriptParentParent.Utils.AppContext)
local getAppFeaturePolicies = require(scriptParentParentParent.UniversalAppPolicy).getAppFeaturePolicies

local tbl1 = { ExternalSettings, PlatformInterface }

local function openTermsOfUse(arg1)
    return Thunk.new(script.Name, tbl1, function(_, arg2)
        local var1 = arg2[ExternalSettings]
        local var2 = arg2[PlatformInterface]

        local upsellFlow = getUpsellFlow(var1.getPlatform())
        if not getAppFeaturePolicies().getShouldUseDMCCALegalDisclosureInApp() then
            if upsellFlow == UpsellFlow.Web then
                var2.openTermsOfUse()
            end
            return
        end

        if AppContext.get() ~= AppContext.Enum.IN_APP then
            var2.openTermsOfUseDMCCA()

            return
        end

        arg1.navigate(AppPage.GenericWebPage, { detail = TermsOfUse.DMCCAUrl, extraProps = { title = "" } })
    end)
end
return openTermsOfUse
