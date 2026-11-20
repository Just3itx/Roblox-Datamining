-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local UIBlox = require(scriptParentParentParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local Localization = require(scriptParentParentParent.Localization)
local Promise = require(scriptParentParentParent.Promise)
local RobloxAppHooks = require(scriptParentParentParent.RobloxAppHooks)
local RoactUtils = require(scriptParentParentParent.RoactUtils)
local RoactServiceTags = require(scriptParentParentParent.RoactServiceTags)

local ControlState = UIBlox.Core.Control.Enum.ControlState
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation

local Image = require(scriptParentParentParent.Foundation).Image
local FFlagCoreUiMigrateUIBloxToFoundation = require(scriptParentParentParent.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local useLocalization = Localization.Hooks.useLocalization
local useRoactService = RobloxAppHooks.useRoactService
local useEffectOnce = RoactUtils.Hooks.useEffectOnce
local AppEventIngestService = RoactServiceTags.AppEventIngestService

local Constants = require(scriptParentParent.Constants)

local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/logo/studiologo" else Images["icons/logo/studiologo"]

local engineFeature = game:GetEngineFeature("WebViewRedesignEnabled")

local function StudioCTAIcon(tbl1)
    local theme = useStyle().Theme

    local var2, var3 = React.useState(false)
    local var4 = useRoactService(AppEventIngestService)

    local var5 = useLocalization(
        {
            titleText = "CommonUI.Features.StudioCTA.Tooltip.Title",
            bodyText = "CommonUI.Features.StudioCTA.Tooltip.Body"
        }
    )

    local var6 = React.useRef(nil)

    useEffectOnce(function()
        var4:setRBXEventStream(Constants.STUDIO_CTA_EVENT_CONTEXT, Constants.STUDIO_CTA_EVENT_NAME_MOUNT)
    end, {})

    if tbl1.controlState ~= ControlState.Hover and tbl1.controlState ~= ControlState.Selected then
        if var6.current then
            var6.current:cancel()
            var6.current = nil
        end
        if var2 then
            var3(false)
        end
    elseif not var6.current then
        var6.current = Promise.delay(0.4):andThenCall(function()
            var6.current = nil
            var3(true)
        end)
    end

    local tbl2 = {
        headerText = var5.titleText,
        bodyText = var5.bodyText
    }

    local tbl3 = {
        preferredOrientation = TooltipOrientation.Top,
        guiTarget = CoreGui,
        active = 0,
        DisplayOrder = 10
    }

    if engineFeature then
        var2 = tbl1.showTooltip and var2
    end

    tbl3.active = var2

    return withTooltip(tbl2, tbl3, function(arg1)
        if FFlagCoreUiMigrateUIBloxToFoundation then
            return React.createElement(Image, {
                Size = UDim2.fromScale(1, 1),
                Image = var1,
                ScaleType = Enum.ScaleType.Fit,
                imageStyle = {
                    Color3 = theme.IconEmphasis.Color,
                    Transparency = 0
                },
                onAbsoluteSizeChanged = arg1,
                onAbsolutePositionChanged = arg1
            })
        end
        return React.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Image = var1,
            ScaleType = Enum.ScaleType.Fit,
            ImageColor3 = theme.IconEmphasis.Color,
            [React.Change.AbsoluteSize] = arg1,
            [React.Change.AbsolutePosition] = arg1
        })
    end)
end

return StudioCTAIcon
