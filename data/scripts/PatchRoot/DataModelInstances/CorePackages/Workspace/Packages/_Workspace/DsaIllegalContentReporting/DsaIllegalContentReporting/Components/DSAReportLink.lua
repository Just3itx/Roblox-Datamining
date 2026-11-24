-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:06:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DsaIllegalContentReporting = script:FindFirstAncestor("DsaIllegalContentReporting")

local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local Constants = require(DsaIllegalContentReporting.Utility.Constants)

local DsaIllegalContentReportingParent = DsaIllegalContentReporting.Parent
local UIBlox = require(DsaIllegalContentReportingParent.UIBlox)
local React = require(DsaIllegalContentReportingParent.React)
local StyleProviderWithDefaultTheme = require(DsaIllegalContentReportingParent.Style).StyleProviderWithDefaultTheme
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local Responsive = require(DsaIllegalContentReportingParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local isInExperienceUIVREnabled = require(DsaIllegalContentReportingParent.SharedExperimentDefinition).isInExperienceUIVREnabled
local useLocalization = require(DsaIllegalContentReportingParent.Localization).Hooks.useLocalization

local LinkButton = UIBlox.App.Button.LinkButton
local useStyle = UIBlox.Core.Style.useStyle

function DSAReportLink()
    local var1 = useStyle()
    local bool1 = usePreferredInput() == Responsive.Input.Directional
    local var2 = if isInExperienceUIVREnabled then Responsive.useIsSpatial() else false

    if bool1 then
        var2 = bool1
    elseif not isInExperienceUIVREnabled then
        var2 = false
    end
    local var3 = useLocalization({
        reportLinkText = "Feature.ReportAbuse.DSAIllegal.ReportLink",
        readonlyLinkText = "Feature.DynamicUI.Translation.Reporting.IllegalContentEUBody"
    })
    local element

    if var2 then
        element = React.createElement(StyledTextLabel, {
            layoutOrder = 2,
            size = UDim2.new(0, 500, 0, 60),
            lineHeight = 1,
            text = var3.readonlyLinkText,
            textXAlignment = Enum.TextXAlignment.Center,
            textYAlignment = Enum.TextYAlignment.Center,
            fontStyle = var1.Font.Body,
            colorStyle = var1.Theme.TextEmphasis,
            fluidSizing = true,
            richText = false
        })
    else
        element = React.createElement(LinkButton, {
            fontStyle = if bool1 then "CaptionBody" else "Footer",
            size = UDim2.new(0, 100, 0, 20),
            text = var3.reportLinkText,
            layoutOrder = 2,
            onActivated = function()
                local str1 = HttpService:JSONEncode(
                    {
                        title = Constants.HELP_PAGE_TITLE,
                        presentationStyle = nil,
                        visible = true,
                        url = Constants.DSA_REPORT_LINK
                    }
                )
                GuiService:BroadcastNotification(str1, 20)
            end
        })
    end
    return React.createElement("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1
    }, {
        Layout = React.createElement(
            "UIListLayout",
            {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        Padding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 16) }),
        Divider = React.createElement("Frame", {
            BackgroundColor3 = var1.Theme.Divider.Color,
            BackgroundTransparency = var1.Theme.Divider.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            LayoutOrder = 0
        }),
        Link = element
    })
end

function WrapperContainer()
    return React.createElement(
        StyleProviderWithDefaultTheme,
        { withDarkTheme = true },
        {
            Button = React.createElement(DSAReportLink)
        }
    )
end
return WrapperContainer
