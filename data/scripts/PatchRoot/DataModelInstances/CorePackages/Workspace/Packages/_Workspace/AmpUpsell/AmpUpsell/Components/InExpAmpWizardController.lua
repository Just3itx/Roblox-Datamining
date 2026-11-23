-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent

local HttpService = game:GetService("HttpService")

local React = require(AmpUpsellParent.React)
local ReactRoblox = require(AmpUpsellParent.ReactRoblox)
local Roact = require(AmpUpsellParent.Roact)

local SetScreenSize = require(AmpUpsellParent.InExperienceContainer).SetScreenSize

local useDispatch = require(AmpUpsellParent.RoactUtils).Hooks.RoactRodux.useDispatch

local _Types = require(AmpUpsell.Common.Types)
local AppAmpWizardLaunchBridge = require(AmpUpsell.Common.AppAmpWizardLaunchBridge)
local _WizardContainer = require(AmpUpsell.Components.WizardContainer)
local InExpWizardNavigator = require(AmpUpsell.Components.InExpWizardNavigator)
local InExperienceProviderContainer = require(AmpUpsellParent.InExperienceContainer).InExperienceProviderContainer

game:DefineFastString("DummyAMPWizardAccessResponse", "Granted")
game:DefineFastString("DummyAMPWizardActionsTakenJSON", "{}")
local GetFFlagEnableDummyAMPWizard = require(AmpUpsell.Flags.GetFFlagEnableDummyAMPWizard)

local GetFFlagInExperienceContainerScreenSizeReducer = require(AmpUpsellParent.SharedFlags).GetFFlagInExperienceContainerScreenSizeReducer
local GetFFlagMoveAmpUpsellOffNavigateDown = require(AmpUpsellParent.SharedFlags).GetFFlagMoveAmpUpsellOffNavigateDown
local num1 = game:DefineFastInt("InExpAmpWizardDisplayOrder", 6)

local FFlagRouteStandaloneAmpThroughUniversalApp = require(AmpUpsellParent.SharedFlags).FFlagRouteStandaloneAmpThroughUniversalApp

local ApolloProvider = require(AmpUpsellParent.ApolloClient).ApolloProvider

local root = nil

local function WizardScreenGui(extraProps)
    local var1 = useDispatch()
    local num2 = num1
    if extraProps and extraProps.displayOrder then
        num2 = extraProps.displayOrder
    end

    local onTopOfCoreBlur = if extraProps and extraProps.onTopOfCoreBlur then true else nil

    local createElement = React.createElement
    local tbl1 = {
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        DisplayOrder = num2,
        Enabled = true,
        OnTopOfCoreBlur = onTopOfCoreBlur
    }

    tbl1[Roact.Change.AbsoluteSize] = function(arg1)
        var1(SetScreenSize(arg1.AbsoluteSize))
    end

    return createElement(
        "ScreenGui",
        tbl1,
        { React.createElement(InExpWizardNavigator, { screenProps = { extraProps = extraProps } }) }
    )
end

local function renderAmpWizard(tbl1: {completionCallback: (any, any) -> (), displayOrder: number?, entryPointEventCtx: string?, extraParameters: {[any]: any}?, featureName: string, isInExperienceEntry: boolean, nameSpace: string?, onTopOfCoreBlur: boolean?, prologueOptions: any, recourseData: any, usePrologue: boolean?}, client)
    if root == nil then
        local CoreGui = game:GetService("CoreGui")
        local ampWizard = Instance.new("Folder")
        ampWizard.Name = "AmpWizard"
        ampWizard.Parent = CoreGui

        root = ReactRoblox.createRoot(ampWizard)
    end

    local element = React.createElement(InExperienceProviderContainer, {}, React.createElement(WizardScreenGui, tbl1))
    if client then
        root:render(React.createElement(ApolloProvider, { client = client }, element))
        return
    end
    root:render(element)
end

return {
    OpenAmpWizardContainerInExp = function(featureName: string, completionCallback: (...any) -> (...any), recourseData, entryPointEventCtx: string?, extraParameters, nameSpace: string?, client, displayOrder: number?, onTopOfCoreBlur: boolean?, usePrologue: boolean?, prologueOptions)
        if GetFFlagEnableDummyAMPWizard() then
            task.delay(0.5, function()
                if not completionCallback then
                    return
                end

                local fastString = game:GetFastString("DummyAMPWizardAccessResponse")
                local fastString2 = game:GetFastString("DummyAMPWizardActionsTakenJSON")

                if not pcall(function()
                    HttpService:JSONDecode(fastString2)
                end) then
                    print("Failed to decode DummyWizardActionsTakenJSON, not calling completionCallback")
                    return
                end

                local var1 = HttpService:JSONDecode(fastString2)

                completionCallback(fastString, var1)
            end)

            return
        end

        if FFlagRouteStandaloneAmpThroughUniversalApp
            and AppAmpWizardLaunchBridge.requestOpen({
                featureName = featureName,
                nameSpace = nameSpace,
                recourseData = recourseData,
                entryPointEventCtx = entryPointEventCtx,
                extraParameters = extraParameters,
                usePrologue = usePrologue,
                prologueOptions = prologueOptions,
                completionCallback = completionCallback
            })
        then
            return
        end

        if not GetFFlagInExperienceContainerScreenSizeReducer() or not GetFFlagMoveAmpUpsellOffNavigateDown() then
            print("InExpAmpWizardController: OpenAmpWizardContainerInExp called without necessary flags")
            return
        end

        renderAmpWizard({
            isInExperienceEntry = true,
            nameSpace = nameSpace,
            featureName = featureName,
            completionCallback = function(arg1, arg2)
                if root then
                    root:render(nil)
                end
                if completionCallback then
                    completionCallback(arg1, arg2)
                end
            end,
            recourseData = recourseData,
            entryPointEventCtx = entryPointEventCtx,
            extraParameters = extraParameters,
            usePrologue = usePrologue,
            prologueOptions = prologueOptions,
            displayOrder = displayOrder,
            onTopOfCoreBlur = onTopOfCoreBlur
        }, client)
    end
}
