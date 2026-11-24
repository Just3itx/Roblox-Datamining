-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local CoreGui = game:GetService("CoreGui")

local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")
local LocalizationService = game:GetService("LocalizationService")

local React = require(scriptParent.React)
local Roact = require(scriptParent.Roact)
local StyleProviderWithDefaultTheme = require(scriptParent.Style).StyleProviderWithDefaultTheme
local LayerCollectorProvider = require(scriptParent.UIBlox).Core.Layout.LayerCollector.LayerCollectorProvider
local FoundationProvider = require(scriptParent.Foundation).FoundationProvider

local Localization = require(scriptParent.InExperienceLocales).Localization
local LocalizationProvider = require(scriptParent.Localization).LocalizationProvider

local FFlagHighlightModePreciseSelectionEnabled = require(scriptParent.SharedFlags).FFlagHighlightModePreciseSelectionEnabled

local MessageBusService = game:GetService("MessageBusService")
local messageId = MessageBusService:GetMessageId("CaptureMode", "sceneSelectionExitReason")

local SceneAnalysis = require(script.Analysis.SceneAnalysis)
local InGameAssetReportMode = require(script.InGameAssetReportUI.Components.InGameAssetReportMode)

local InGameAssetReportModePreciseSelection = require(script.InGameAssetReportUI.Components.PreciseSelection.InGameAssetReportModePreciseSelection)
local getHighlightModeVariant = require(script.Utility.getHighlightModeVariant)
local HighlightModeVariants = require(script.InGameAssetReportUI.Resources.Constants).HighlightModeVariants

local tbl1 = {
    [HighlightModeVariants.Default] = InGameAssetReportMode,
    [HighlightModeVariants.NoPreview] = InGameAssetReportModePreciseSelection
}

local module = {
    interpretAnnotation = SceneAnalysis.interpretAnnotation,
    extractItemsFromInterpretations = SceneAnalysis.extractItemsFromInterpretations,
    __setRandomGenerator = SceneAnalysis.__setRandomGenerator
}

function module.initialize()
    local var1 = InGameAssetReportMode

    if FFlagHighlightModePreciseSelectionEnabled then
        local highlightModeVariant = getHighlightModeVariant()

        if highlightModeVariant ~= HighlightModeVariants.Default and tbl1[highlightModeVariant] ~= nil then
            game:GetService("ExperienceStateCaptureService").SelectionMode = Enum.ExperienceStateCaptureSelectionMode.SafetyHighlightMode

            var1 = tbl1[highlightModeVariant]
        end
    end

    local element = React.createElement(
        "ScreenGui",
        {
            IgnoreGuiInset = true,
            OnTopOfCoreBlur = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        },
        {
            LayerCollectorProvider = React.createElement(LayerCollectorProvider, {}, {
                FoundationProvider = React.createElement(FoundationProvider, { colorMode = "Dark" }, {
                    LocalizationProvider = Roact.createElement(
                        LocalizationProvider,
                        {
                            localization = Localization.new(LocalizationService.RobloxLocaleId)
                        },
                        {
                            StyleProvider = React.createElement(StyleProviderWithDefaultTheme, {
                                withDarkTheme = true
                            }, {
                                InGameAssetReportUI = Roact.createElement(var1, {
                                    backAction = function()
                                        MessageBusService:Publish(messageId, { reason = "back" })
                                        ExperienceStateCaptureService:ToggleCaptureMode()
                                    end,
                                    onReportComplete = function()
                                        MessageBusService:Publish(messageId, { reason = "submit" })
                                        ExperienceStateCaptureService:ToggleCaptureMode()
                                    end,
                                    getIsSmallPortraitMode = function(arg1): boolean
                                        return arg1.X < arg1.Y and arg1.X < 800
                                    end
                                })
                            })
                        }
                    )
                })
            })
        }
    )

    if game:GetEngineFeature("ExperienceStateCaptureHiddenSelection") then
        ExperienceStateCaptureService.HiddenSelectionEnabled = true
    end
    Roact.mount(element, CoreGui, "InGameAssetReportMode")
end

module.getHighlightModeVariant = getHighlightModeVariant
module.HighlightModeVariants = HighlightModeVariants
module["jest.config"] = script["jest.config"]
return module
