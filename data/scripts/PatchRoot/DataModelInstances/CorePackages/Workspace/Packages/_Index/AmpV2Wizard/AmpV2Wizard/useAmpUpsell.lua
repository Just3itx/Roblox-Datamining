-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local _Types = require(AmpV2Wizard.Types)
local FFlagAmpV2WizardSharedLauncher = require(AmpV2Wizard.FFlagAmpV2WizardSharedLauncher)
local FlowApiProvider = if FFlagAmpV2WizardSharedLauncher then nil else require(AmpV2Wizard.FlowApiProvider)
local ComponentRegistry = if FFlagAmpV2WizardSharedLauncher then nil else require(AmpV2Wizard.ComponentRegistry)
local buildEntrypointRequest = if FFlagAmpV2WizardSharedLauncher then nil else require(AmpV2Wizard.buildEntrypointRequest)
local useAmpUpsellLauncher = require(AmpV2Wizard.useAmpUpsellLauncher)
if not FFlagAmpV2WizardSharedLauncher then
    require(AmpV2Wizard.useWizardWalker)
end

local function fragmentHasEntry(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (arg1.entry == nil) and arg1.entry ~= ""
end

local function useAmpUpsell(tbl1)
    local var1 = if FFlagAmpV2WizardSharedLauncher then require(AmpV2Wizard.FlowApiProvider) else FlowApiProvider
    local var2 = if FFlagAmpV2WizardSharedLauncher then require(AmpV2Wizard.ComponentRegistry) else ComponentRegistry
    local api = tbl1.api or var1
    local registry = tbl1.registry or var2.default
    local surface = tbl1.surface
    local target = tbl1.target
    local flow = tbl1.flow
    local extraProps = tbl1.extraProps

    local availability, var6 = React.useState({ available = false, isLoading = true })

    local var7 = React.useCallback(function()
        local var7 = if FFlagAmpV2WizardSharedLauncher then require(AmpV2Wizard.buildEntrypointRequest) else buildEntrypointRequest
        var6({ available = false, isLoading = true })
        api.entrypoint(var7(target, flow, surface, registry, extraProps)):andThen(function(arg1)
            var6({
                available = fragmentHasEntry(arg1),
                isLoading = false,
                chosenFlow = if arg1.chosenFlow == "" then nil else arg1.chosenFlow
            })
        end):catch(function()
            var6({ available = false, isLoading = false })
        end)
    end, {
        api,
        target,
        flow,
        surface,
        registry,
        extraProps
    })

    React.useEffect(function()
        var7()
    end, { var7 })

    local onComplete = React.useCallback(function()
        var7()
    end, { var7 })

    local var9 = useAmpUpsellLauncher(
        {
            surface = surface,
            registry = registry,
            api = api,
            onEvent = tbl1.onEvent,
            onComplete = onComplete
        }
    )

    return {
        availability = availability,
        start = React.useCallback(function()
            return var9({ target = target, flow = flow, extraProps = extraProps })
        end, {
            var9,
            target,
            flow,
            extraProps
        })
    }
end
return useAmpUpsell
