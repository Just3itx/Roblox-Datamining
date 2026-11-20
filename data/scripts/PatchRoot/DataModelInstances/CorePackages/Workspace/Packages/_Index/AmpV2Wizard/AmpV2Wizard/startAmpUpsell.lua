-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Promise = require(scriptParent.Parent.Promise)
local _LuauPolyfill = require(scriptParent.Parent.LuauPolyfill)
local _Types = require(scriptParent.Types)
local FFlagAmpV2WizardRateLimitedOutcome = require(scriptParent.FFlagAmpV2WizardRateLimitedOutcome)
local FFlagAmpV2WizardTerminalOutcome = require(scriptParent.FFlagAmpV2WizardTerminalOutcome)

local function errorResult() -- Luacid: Inlined by compiler; 4 call sites recovered
    return { reason = "Error", flowId = "" }
end

return function(arg1, arg2, func1: (...any) -> (...any), bool1: boolean)
    return Promise.new(function(callback: (...any) -> (...any))
        local bool2 = false
        local function finish(arg3, bool3: boolean) -- Luacid: Inlined by compiler; 6 call sites recovered
            if bool2 then
                return
            end
            bool2 = true
            callback(arg3)
            if bool3 and arg1.onComplete then
                arg1.onComplete(arg3)
            end
        end
        local tbl1 = {
            target = arg2.target,
            flow = arg2.flow,
            surface = arg1.surface,
            odpEventContext = arg1.odpEventContext,
            odpEventUniverseId = arg1.odpEventUniverseId,
            api = arg1.api,
            registry = arg1.registry,
            extraProps = if bool1 then nil else arg2.extraProps,
            onEvent = arg1.onEvent,
            onExit = 0
        }

        function tbl1.onExit(arg3)
            finish(arg3, true)
        end

        local function open(initialFragment) -- Luacid: Inlined by compiler; 2 call sites recovered
            tbl1.initialFragment = initialFragment
            if func1(tbl1) == false then
                finish(errorResult(), false)
            end
        end

        if not bool1 then
            open(nil)
            return
        end

        local api = arg1.api or require(scriptParent.FlowApiProvider)
        local registry = arg1.registry or require(scriptParent.ComponentRegistry).default
        local buildEntrypointRequest = require(scriptParent.buildEntrypointRequest)
        tbl1.api = api
        tbl1.registry = registry
        api.entrypoint(buildEntrypointRequest(arg2.target, arg2.flow, arg1.surface, registry, arg2.extraProps)):andThen(
            function(initialFragment)
                local bool3 = initialFragment.outcome == "Error"
                if FFlagAmpV2WizardRateLimitedOutcome and initialFragment.outcome == "RateLimited" then
                    bool3 = true
                end

                if initialFragment.entry ~= nil and initialFragment.entry ~= "" or bool3 then
                    open(initialFragment)
                    return
                end

                local tbl2 = {
                    reason = "Completed",
                    flowId = initialFragment.flowId,
                    outcome = if FFlagAmpV2WizardTerminalOutcome then initialFragment.outcome else nil
                }
                finish(tbl2, false)
            end
        ):catch(
            function()
                finish(errorResult(), false)
            end
        )
    end):catch(errorResult)
end
