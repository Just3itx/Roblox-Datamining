-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)
local useNavigation = require(AmpV2WizardParent.Navigation).useNavigation
local useNavigationProps = require(AmpV2WizardParent.RobloxAppNavigation).useNavigationProps

local _Types = require(AmpV2Wizard.Types)
local AppPage = require(AmpV2WizardParent.RobloxAppEnums).AppPage
local UrlBase = require(AmpV2WizardParent.UrlBuilder).UrlBase
local OverlayWizardHost = require(AmpV2Wizard.OverlayWizardHost)
local WizardSpinner = require(AmpV2Wizard.WizardSpinner)
local FlowApiProvider = require(AmpV2Wizard.FlowApiProvider)
local ComponentRegistry = require(AmpV2Wizard.ComponentRegistry)
local buildEntrypointRequest = require(AmpV2Wizard.buildEntrypointRequest)

local function rootFlowOf(flow) -- Luacid: Inlined by compiler; 1 call site recovered
    return if flow == nil or flow.name == "" then nil else flow.name
end

local function AmpV2WizardRoute(_)
    local var1 = useNavigation()
    local var2 = useNavigationProps(function(_, arg1)
        return {
            initialFragment = arg1.initialFragment,
            target = arg1.target,
            flow = arg1.flow,
            surface = arg1.surface or "DeepLink",
            odpEventContext = arg1.odpEventContext,
            odpEventUniverseId = arg1.odpEventUniverseId,
            api = arg1.api,
            registry = arg1.registry,
            extraProps = arg1.extraProps,
            onExit = arg1.onExit,
            onEvent = arg1.onEvent
        }
    end)

    local api = var2.api or FlowApiProvider
    local registry = var2.registry or ComponentRegistry.default

    local initialFragment = var2.initialFragment
    local var5, var6 = React.useState(nil)
    local var3 = initialFragment or var5
    local bool1 = not (var2.flow == nil) and var2.flow.name == "OdpCheckpointResume"
    local var8 = React.useRef(nil)
    local var9 = React.useMemo(function()
        if not bool1 then
            return nil
        end

        local resumeSourcePage = if var3 then var3.resumeSourcePage else nil
        local str1 = "my/account#!/parental-controls"

        if type(resumeSourcePage) == "string"
            and resumeSourcePage ~= ""
            and #resumeSourcePage <= 16384
            and not string.find(resumeSourcePage, "%c")
            and string.sub(resumeSourcePage, 1, 1) ~= "/"
            and not string.find(resumeSourcePage, "\\", 1, true)
            and not string.match(resumeSourcePage, "^[^?#]*:")
        then
            str1 = resumeSourcePage
        end

        return UrlBase.new("www") .. "/" .. str1
    end, { bool1, var3 })
    local var10 = React.useCallback(function(url: string, title: string)
        var8.current = { url = url, title = title }
    end, {})

    local onExit = var2.onExit
    local var11 = React.useCallback(function(arg1)
        if var9 then
            local current = var8.current
            var1.replace(AppPage.GenericWebPage, {
                detail = if current then current.url else var9,
                extraProps = {
                    title = if current then current.title else nil,
                    titleKey = if current then nil else "CommonUI.Features.Label.Settings"
                }
            })
        else
            var1.pop()
        end
        if onExit then
            onExit(arg1)
        end
    end, { var1, onExit, var9 })

    local var12 = React.useRef(var11)
    var12.current = var11

    local var13 = React.useMemo(function()
        return buildEntrypointRequest(var2.target, var2.flow, var2.surface, registry, var2.extraProps)
    end, {
        var2.target,
        var2.flow,
        var2.surface,
        registry,
        var2.extraProps
    })
    React.useEffect(function()
        if initialFragment ~= nil then
            return
        end

        local bool2 = false
        api.entrypoint(var13):andThen(function(arg1)
            if not bool2 then
                var6(arg1)
            end
        end):catch(function()
            if not bool2 then
                var12.current({ reason = "Error", flowId = "" })
            end
        end)
        return function()
            bool2 = true
        end
    end, { initialFragment, api, var13 })

    if var3 == nil then
        return React.createElement(WizardSpinner)
    end

    local createElement = React.createElement
    local var14 = OverlayWizardHost
    local tbl1 = {
        initialFragment = var3,
        onTerminalRedirect = 0,
        target = 0,
        rootFlow = 0,
        flowProps = 0,
        surface = 0,
        odpEventContext = 0,
        odpEventUniverseId = 0,
        api = 0,
        registry = 0,
        onExit = 0,
        onEvent = 0
    }

    if not bool1 then
        var10 = nil
    end

    tbl1.onTerminalRedirect = var10
    tbl1.target = var2.target
    tbl1.rootFlow = var3.resumeRootFlow or rootFlowOf(var2.flow)
    tbl1.flowProps = if var2.flow then var2.flow.props else nil
    tbl1.surface = var3.resumeSurface or var2.surface
    tbl1.odpEventContext = var2.odpEventContext
    tbl1.odpEventUniverseId = var2.odpEventUniverseId
    tbl1.api = api
    tbl1.registry = registry
    tbl1.onExit = var11
    tbl1.onEvent = var2.onEvent
    return createElement(var14, tbl1)
end

return AmpV2WizardRoute
