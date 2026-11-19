-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local UIBlox = require(CorePackages.Packages.UIBlox)
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local StandardButtonSize = UIBlox.App.Button.Enum.StandardButtonSize
local useStyle = UIBlox.Core.Style.useStyle

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local Cryo = require(CorePackages.Packages.Cryo)

local HighlightModeVariants = require(CorePackages.Workspace.Packages.InGameAssetReporting).HighlightModeVariants
local FFlagHighlightModePreciseSelectionEnabled = require(CorePackages.Workspace.Packages.SharedFlags).FFlagHighlightModePreciseSelectionEnabled

local var1 = nil
if FFlagHighlightModePreciseSelectionEnabled then
    local LocalizationService = game:GetService("LocalizationService")
    var1 = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization.new(LocalizationService.RobloxLocaleId)
end

local function func1(default, arg1)
    local tbl1 = { RobloxTranslator:FormatByKey("Feature.ReportAbuse.Label.SelectInSceneDescription1"), RobloxTranslator:FormatByKey("Feature.ReportAbuse.Label.SelectInSceneDescription2"), RobloxTranslator:FormatByKey("Feature.ReportAbuse.Label.SelectInSceneDescription3") }

    local tbl2 = default ~= HighlightModeVariants.Default
        and { var1:Format("Feature.ReportAbuse.Label.SelectInSceneDescriptionPrecise1"), RobloxTranslator:FormatByKey("Feature.ReportAbuse.Label.SelectInSceneDescription2"), RobloxTranslator:FormatByKey("Feature.ReportAbuse.Label.SelectInSceneDescription3") }
        or tbl1

    local var2 = Cryo.List.map(tbl2, function(arg2, layoutOrder)
        return React.createElement(StyledTextLabel, {
            text = "• " .. arg2,
            fontStyle = arg1.Font.Body,
            colorStyle = arg1.Theme.TextEmphasis,
            layoutOrder = layoutOrder,
            automaticSize = Enum.AutomaticSize.XY
        })
    end)
    local tbl3 = {
        Layout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 30)
            }
        )
    }

    for i, value in ipairs(var2) do
        tbl3["Subheading" .. i] = value
    end
    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
        Position = UDim2.new(0.5, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0),
        LayoutOrder = 1
    }, tbl3)
end

local function SelectInSceneReportMenu(tbl1)
    local var2 = useStyle()

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0)
    }
    local tbl3 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 30)
        }),
        Padding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 15) }),
        Title = React.createElement(StyledTextLabel, {
            text = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Heading.ReportUsingSelectInScene"),
            fontStyle = var2.Font.Header1,
            colorStyle = var2.Theme.TextEmphasis,
            layoutOrder = 0,
            automaticSize = Enum.AutomaticSize.XY
        }),
        SubheadingFrame = 0,
        EnterSelectInSceneButton = 0
    }
    local element

    if tbl1.variant then
        element = func1(tbl1.variant, var2)
    else
        element = React.createElement("Frame", {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            Position = UDim2.new(0.5, 0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0),
            LayoutOrder = 1
        }, {
            Layout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 30)
                }
            ),
            Subheading1 = React.createElement(StyledTextLabel, {
                text = "• " .. RobloxTranslator:FormatByKey("Feature.ReportAbuse.Label.SelectInSceneDescription1"),
                fontStyle = var2.Font.Body,
                colorStyle = var2.Theme.TextEmphasis,
                layoutOrder = 0,
                automaticSize = Enum.AutomaticSize.XY
            }),
            Subheading2 = React.createElement(StyledTextLabel, {
                text = "• " .. RobloxTranslator:FormatByKey("Feature.ReportAbuse.Label.SelectInSceneDescription2"),
                fontStyle = var2.Font.Body,
                colorStyle = var2.Theme.TextEmphasis,
                layoutOrder = 1,
                automaticSize = Enum.AutomaticSize.XY
            }),
            Subheading3 = React.createElement(StyledTextLabel, {
                text = "• " .. RobloxTranslator:FormatByKey("Feature.ReportAbuse.Label.SelectInSceneDescription3"),
                fontStyle = var2.Font.Body,
                colorStyle = var2.Theme.TextEmphasis,
                layoutOrder = 2,
                automaticSize = Enum.AutomaticSize.XY
            })
        })
    end

    tbl3.SubheadingFrame = element

    tbl3.EnterSelectInSceneButton = React.createElement(Button, {
        text = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Action.EnterSceneReporting"),
        buttonType = ButtonType.PrimarySystem,
        standardSize = StandardButtonSize.Small,
        layoutOrder = 2,
        position = UDim2.new(0.5, 0, 0, 0),
        anchorPoint = Vector2.new(0.5, 0),
        fitContent = true,
        onActivated = function()
            local SafetyService = game:GetService("SafetyService")
            local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")

            if game:GetEngineFeature("ExperienceStateCaptureIsInBackground") then
                local connection = nil
                connection = ExperienceStateCaptureService:GetPropertyChangedSignal("IsInBackground"):Connect(function()
                    if not connection.Connected then
                        return
                    end

                    if not ExperienceStateCaptureService.IsInBackground then
                        tbl1.hideReportTab()
                        connection:Disconnect()
                    end
                end)
            end

            SafetyService.IsCaptureModeForReport = true
            ExperienceStateCaptureService:ToggleCaptureMode()
        end
    })

    return createElement(str1, tbl2, tbl3)
end

return SelectInSceneReportMenu
