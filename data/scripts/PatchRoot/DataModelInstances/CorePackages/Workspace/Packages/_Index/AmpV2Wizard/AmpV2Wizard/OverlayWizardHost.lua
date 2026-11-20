-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local Foundation = require(AmpV2WizardParent.Foundation)
local View = Foundation.View
local FoundationProvider = Foundation.FoundationProvider
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local ColorMode = Foundation.Enums.ColorMode
local ThemeName = Foundation.Enums.ThemeName
local usePreferences = Foundation.Hooks.usePreferences
local useTokens = Foundation.Hooks.useTokens

local _Types = require(AmpV2Wizard.Types)
local useWizardWalker = require(AmpV2Wizard.useWizardWalker)
local ComponentRegistry = require(AmpV2Wizard.ComponentRegistry)
local WizardSpinner = require(AmpV2Wizard.WizardSpinner)
local GenericErrorModal = require(AmpV2Wizard.GenericErrorModal)
local UnknownNodeDebugView = require(AmpV2Wizard.UnknownNodeDebugView)
local getFFlagAmpV2WizardDebugUnknownNodes = require(AmpV2Wizard.getFFlagAmpV2WizardDebugUnknownNodes)
local isParentModeThemedNode = require(AmpV2Wizard.isParentModeThemedNode)
local FFlagAmpV2WizardParentModeNavTheme = require(AmpV2WizardParent.SharedFlags).FFlagAmpV2WizardParentModeNavTheme
local useSyncParentModeChromeTheme = if FFlagAmpV2WizardParentModeNavTheme then require(AmpV2Wizard.useSyncParentModeChromeTheme) else nil
local FFlagAmpV2WizardNoCanvasGroupDim = require(AmpV2Wizard.FFlagAmpV2WizardNoCanvasGroupDim)
local FFlagAmpV2WizardVendorOverlay = require(AmpV2Wizard.FFlagAmpV2WizardVendorOverlay)
local FFlagAmpV2WizardServerParentFacing = require(AmpV2Wizard.FFlagAmpV2WizardServerParentFacing)
local FFlagAmpV2WizardAuthorizationModal = require(AmpV2Wizard.FFlagAmpV2WizardAuthorizationModal)
local usePresentedOverPage = require(AmpV2Wizard.usePresentedOverPage)
local useWizardViewportLayout = require(AmpV2Wizard.useWizardViewportLayout)

local function noopReport(_: string, _) end

local function ParentModeTheme(tbl1)
    local var1 = usePreferences()
    local var2 = useTokens()
    local scale = var2.Config.UI.Scale

    local colorMode = if var2.Config.ColorMode.Name == ColorMode.Light then "Light" else "Dark"

    return React.createElement(View, {
        tag = "size-full",
        testId = "amp-v2-wizard-parent-mode-theme"
    }, {
        Theme = React.createElement(FoundationProvider, {
            themeName = ThemeName.Default,
            colorMode = colorMode,
            preferences = {
                preferredTextSize = var1.preferredTextSize,
                preferredTransparency = var1.preferredTransparency,
                reducedMotion = var1.reducedMotion,
                scale = scale
            }
        }, tbl1.children)
    })
end

local function LoadingScrim(tbl1)
    local var1 = useTokens()

    return React.createElement(View, {
        tag = "size-full",
        backgroundStyle = {
            Color3 = var1.Color.Common.Backdrop.Color3,
            Transparency = 0.5
        },
        testId = "amp-v2-wizard-loading-scrim"
    }, tbl1.children)
end

local function OverlayWizardHost(tbl1)
    local var1 = tbl1.registry or ComponentRegistry.default
    local var2, var3 = useWizardViewportLayout()

    local var4 = useWizardWalker({
        initialFragment = tbl1.initialFragment,
        surface = tbl1.surface,
        target = tbl1.target,
        rootFlow = tbl1.rootFlow,
        api = tbl1.api,
        onExit = tbl1.onExit,
        onEvent = tbl1.onEvent
    })

    local var5 = React.useRef(false)
    local currentNode = var4.currentNode
    local var6 = if currentNode then ComponentRegistry.get(var1, currentNode.type) else nil

    React.useEffect(function()
        if getFFlagAmpV2WizardDebugUnknownNodes() then
            return
        end
        if currentNode ~= nil and var6 == nil and not (var4.exited or var5.current) then
            var5.current = true

            var4.report("__unrenderable__")
        end
    end, {
        currentNode,
        var6,
        var4.exited,
        var4.report
    })

    local var7 = not (currentNode == nil) and ComponentRegistry.ownsLoadingState(var1, currentNode.type)
    local var8 = not (currentNode == nil) and ComponentRegistry.fillsViewport(var1, currentNode.type)
    local var9 = if FFlagAmpV2WizardVendorOverlay then usePresentedOverPage(currentNode, var6, var8) else nil
    local bool1 = FFlagAmpV2WizardAuthorizationModal

    if bool1 then
        if currentNode == nil then
            bool1 = false
        else
            bool1 = currentNode.type == "SessionPolling"
        end
    end

    local bool2 = var9 ~= nil
    local var10 = var4.isLoading or bool2
    local bool3 = if bool2 then ComponentRegistry.ownsLoadingState(var1, var9.node.type) else var7

    if bool1 then
        bool3 = true
    end
    local var11, var12 = React.useBinding(0)
    React.useEffect(function()
        var12(if var10 and not bool3 then 0.5 else 0)
    end, { var10, bool3 })

    if FFlagAmpV2WizardParentModeNavTheme then
        useSyncParentModeChromeTheme(var4.exited, var4.presentingError, currentNode, var4.currentNodeId, var6, var9)
    end

    if var4.exited then
        return nil
    elseif var4.presentingError then
        return React.createElement(
            View,
            { tag = "col align-x-center align-y-center size-full padding-large" },
            {
                ErrorModal = React.createElement(GenericErrorModal, { onClose = var4.acknowledgeError })
            }
        )
    else
        local fFlagAmpV2WizardDebugUnknownNodes = getFFlagAmpV2WizardDebugUnknownNodes()

        if fFlagAmpV2WizardDebugUnknownNodes then
            if currentNode == nil then
                fFlagAmpV2WizardDebugUnknownNodes = false
            else
                fFlagAmpV2WizardDebugUnknownNodes = var6 == nil
            end
        end

        if currentNode == nil or var6 == nil and not fFlagAmpV2WizardDebugUnknownNodes then
            return React.createElement(WizardSpinner)
        end

        local var13 = if bool2 then var9.node else currentNode
        local var14 = if bool2 then var9.component else var6
        local flowProps = tbl1.flowProps
        if tbl1.odpEventUniverseId ~= nil and tbl1.odpEventUniverseId ~= "" then
            flowProps = flowProps == nil and {} or table.clone(flowProps)
            flowProps.universeId = tbl1.odpEventUniverseId
        end

        local ctx = {
            onTerminalRedirect = tbl1.onTerminalRedirect,
            analytics = var4.eventContext,
            logEvent = var4.logEvent,
            odpEventContext = tbl1.odpEventContext,
            launchProps = flowProps,
            analyticsStrings = var4.analyticsStrings,
            analyticsSessionId = var4.analyticsSessionId
        }
        local element

        if fFlagAmpV2WizardDebugUnknownNodes then
            element = React.createElement(UnknownNodeDebugView, {
                nodeType = currentNode.type,
                details = currentNode.details,
                transitions = currentNode.transitions,
                report = var4.report
            })
        else
            element = React.createElement(var14, {
                props = var13.details,
                ctx = ctx,
                report = if bool2 then noopReport else var4.report,
                transitions = var13.transitions,
                dismiss = if bool1 then var4.dismissPresentation else nil
            })
        end

        if bool2 then
            var8 = ComponentRegistry.fillsViewport(var1, var13.type)
        end

        local var15

        if bool2 then
            local createElement = React.createElement
            local str1 = "Frame"
            local tbl3 = {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                Visible = bool1,
                ZIndex = if bool1 then 3 else nil
            }
            local tbl4 = { Node = 0 }
            local createElement2 = React.createElement
            local tbl5 = {
                props = currentNode.details,
                ctx = ctx,
                report = var4.report,
                transitions = currentNode.transitions,
                dismiss = if bool1 then var4.dismissPresentation else nil
            }
            tbl4.Node = createElement2(var6, tbl5)
            var15 = createElement(str1, tbl3, tbl4)
        else
            var15 = nil
        end

        if not var8 then
            var2 = nil
        end

        local tbl3 = {
            Position = if var2 then var2.contentPosition else nil,
            Size = if var2 then var2.contentSize else nil,
            ZIndex = if var8 then 1 else nil,
            tag = {
                ["size-full"] = true,
                col = not var8,
                ["align-x-center"] = not var8,
                ["align-y-center"] = not var8,
                ["padding-large"] = not var8
            },
            GroupTransparency = 0
        }
        if FFlagAmpV2WizardNoCanvasGroupDim then
            var11 = nil
        end

        tbl3.GroupTransparency = var11

        local tbl4 = {
            Background = if var8 then React.createElement(View, {
                tag = "size-full bg-surface-0",
                Position = if var2 then var2.backgroundPosition else nil,
                Size = if var2 then var2.backgroundSize else nil,
                ZIndex = 0,
                testId = "amp-v2-wizard-viewport-background"
            }) else nil,
            Content = React.createElement(View, tbl3, { Node = element }),
            LoadingOverlay = 0
        }
        local var16

        if var10 and (not bool1 or bool2) then
            local createElement = React.createElement
            local var17 = View
            local tbl5 = {
                tag = "size-full",
                Position = if var2 then var2.backgroundPosition else nil,
                Size = if var2 then var2.backgroundSize else nil,
                ZIndex = 2,
                onActivated = 0,
                stateLayer = 0,
                testId = "amp-v2-wizard-loading-overlay"
            }

            function tbl5.onActivated() end
            tbl5.stateLayer = {
                affordance = StateLayerAffordance.None
            }
            var16 = createElement(var17, tbl5, {
                Spinner = if bool3 or FFlagAmpV2WizardNoCanvasGroupDim then nil else React.createElement(WizardSpinner),
                Scrim = if bool1 then React.createElement(LoadingScrim, { children = {} }) elseif FFlagAmpV2WizardNoCanvasGroupDim and not bool3 then React.createElement(LoadingScrim, { children = { Spinner = React.createElement(WizardSpinner) } }) else nil
            })
        else
            var16 = nil
        end

        tbl4.LoadingOverlay = var16

        if var15 ~= nil then
            tbl4.PresentingNode = var15
        end

        local element3 = React.createElement(
            View,
            {
                tag = "size-full",
                ref = var3,
                onAbsolutePositionChanged = var3,
                onAbsoluteSizeChanged = var3
            },
            tbl4
        )

        if FFlagAmpV2WizardServerParentFacing then
            if var13.behavior ~= nil and var13.behavior.parentFacing == true then
                return React.createElement(ParentModeTheme, nil, element3)
            end
            return element3
        elseif isParentModeThemedNode(var13.type, var4.currentNodeId) then
            return React.createElement(ParentModeTheme, nil, element3)
        else
            return element3
        end
    end
end

return OverlayWizardHost
