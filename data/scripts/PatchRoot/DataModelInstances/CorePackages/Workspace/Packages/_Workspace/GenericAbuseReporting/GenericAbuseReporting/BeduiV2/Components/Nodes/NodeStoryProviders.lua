-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local View = Foundation.View

local AbuseReportAnalyticsProvider = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext).AbuseReportAnalyticsProvider
local ArTranslationProvider = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).ArTranslationProvider
local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)
local LoaderContext = require(GenericAbuseReporting.BeduiV2.Loaders.LoaderContext)

local inlineSlots = LayoutSlots.inlineSlots
local LayoutSlotsProvider = LayoutSlots.LayoutSlotsProvider
local OverlaidControlsProvider = LayoutSlots.OverlaidControlsProvider
local LoaderProvider = LoaderContext.LoaderProvider

local uDim2 = UDim2.new(0, 468, 0, 560)
local tbl1 = {}
local tbl2 = {}

local analytics = {
    sendEvent = function(...)
        print("Analytics:", ...)
    end
}

local function NodeStoryProviders(tbl4)
    local gui, ref = React.useState(nil)

    return React.createElement(AbuseReportAnalyticsProvider, { analytics = analytics }, {
        Translation = React.createElement(ArTranslationProvider, {
            translations = tbl4.translations or tbl2
        }, {
            LoaderCtx = React.createElement(LoaderProvider, {
                loaders = tbl4.loaders or tbl1,
                open = true
            }, {
                Layout = React.createElement(LayoutSlotsProvider, { slots = inlineSlots }, {
                    Orientation = React.createElement(OverlaidControlsProvider, { value = true }, {
                        Container = React.createElement(
                            View,
                            {
                                Size = tbl4.containerSize or uDim2,
                                ClipsDescendants = true,
                                ref = ref,
                                tag = "col"
                            },
                            {
                                Overlay = gui and React.createElement(Foundation.OverlayProvider, { gui = gui }, tbl4.children) or nil
                            }
                        )
                    })
                })
            })
        })
    })
end
return NodeStoryProviders
