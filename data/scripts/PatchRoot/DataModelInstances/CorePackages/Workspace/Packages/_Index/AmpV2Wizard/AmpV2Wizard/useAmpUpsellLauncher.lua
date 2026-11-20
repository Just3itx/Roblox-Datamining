-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)
local Promise = require(AmpV2WizardParent.Promise)
local useNavigation = require(AmpV2WizardParent.Navigation).useNavigation
local AppPage = require(AmpV2WizardParent.RobloxAppEnums).AppPage

local _Types = require(AmpV2Wizard.Types)
local FFlagAmpV2WizardSharedLauncher = require(AmpV2Wizard.FFlagAmpV2WizardSharedLauncher)
local FlowApiProvider = if FFlagAmpV2WizardSharedLauncher then nil else require(AmpV2Wizard.FlowApiProvider)
local ComponentRegistry = if FFlagAmpV2WizardSharedLauncher then nil else require(AmpV2Wizard.ComponentRegistry)
local buildEntrypointRequest = if FFlagAmpV2WizardSharedLauncher then nil else require(AmpV2Wizard.buildEntrypointRequest)

if not FFlagAmpV2WizardSharedLauncher then
    require(AmpV2Wizard.useWizardWalker)
end
local FFlagAmpV2WizardRateLimitedOutcome = require(AmpV2Wizard.FFlagAmpV2WizardRateLimitedOutcome)
local FFlagAmpV2WizardTerminalOutcome = require(AmpV2Wizard.FFlagAmpV2WizardTerminalOutcome)

local function fragmentHasEntry(initialFragment): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (initialFragment.entry == nil) and initialFragment.entry ~= ""
end

local function useAmpUpsellLauncher(arg1)
    if FFlagAmpV2WizardSharedLauncher then
        local var1 = useNavigation()
        local api = arg1.api
        local registry = arg1.registry
        local surface = arg1.surface
        local onEvent = arg1.onEvent
        local onComplete = arg1.onComplete
        local odpEventContext = arg1.odpEventContext
        local odpEventUniverseId = arg1.odpEventUniverseId
        return React.useCallback(function(arg2)
            return require(AmpV2Wizard.startAmpUpsell)({
                api = api,
                registry = registry,
                surface = surface,
                onEvent = onEvent,
                onComplete = onComplete,
                odpEventContext = odpEventContext,
                odpEventUniverseId = odpEventUniverseId
            }, arg2, function(extraProps)
                return var1.push(AppPage.AmpV2Wizard, { extraProps = extraProps })
            end, true)
        end, {
            api,
            var1,
            onComplete,
            onEvent,
            registry,
            surface,
            odpEventContext,
            odpEventUniverseId
        })
    end

    local api = arg1.api or FlowApiProvider
    local registry = arg1.registry or ComponentRegistry.default
    local surface = arg1.surface
    local odpEventContext = arg1.odpEventContext
    local odpEventUniverseId = arg1.odpEventUniverseId
    local onEvent = arg1.onEvent
    local onComplete = arg1.onComplete

    local var3 = useNavigation()

    return (React.useCallback(function(arg2)
        local target = arg2.target
        local flow = arg2.flow
        local extraProps = arg2.extraProps

        return Promise.new(function(callback)
            api.entrypoint(buildEntrypointRequest(target, flow, surface, registry, extraProps)):andThen(function(initialFragment)
                local bool1 = initialFragment.outcome == "Error"
                if FFlagAmpV2WizardRateLimitedOutcome and initialFragment.outcome == "RateLimited" then
                    bool1 = true
                end

                if not (fragmentHasEntry(initialFragment) or bool1) then
                    callback({
                        reason = "Completed",
                        flowId = initialFragment.flowId,
                        outcome = if FFlagAmpV2WizardTerminalOutcome then initialFragment.outcome else nil
                    })
                    return
                end

                var3.push(AppPage.AmpV2Wizard, {
                    extraProps = {
                        initialFragment = initialFragment,
                        target = target,
                        flow = flow,
                        surface = surface,
                        odpEventContext = odpEventContext,
                        odpEventUniverseId = odpEventUniverseId,
                        api = api,
                        registry = registry,
                        onEvent = onEvent,
                        onExit = function(arg3)
                            callback(arg3)
                            if onComplete then
                                onComplete(arg3)
                            end
                        end
                    }
                })
            end):catch(function()
                callback({ reason = "Error", flowId = "" })
            end)
        end)
    end, {
        api,
        var3,
        onComplete,
        onEvent,
        registry,
        surface,
        odpEventContext,
        odpEventUniverseId
    }))
end
return useAmpUpsellLauncher
