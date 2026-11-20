-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CorePackages = game:GetService("CorePackages")

local Modules = CoreGui:WaitForChild("RobloxGui"):WaitForChild("Modules")

local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)
local SettingsPageFactory = require(Modules.Settings.SettingsPageFactory)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local onBlockButtonActivated = require(script:FindFirstAncestor("Settings").onBlockButtonActivated)
local BlockingAnalytics = require(script:FindFirstAncestor("Settings").Analytics.BlockingAnalytics)
local Utility = require(Modules.Settings.Utility)
local Theme = require(Modules.Settings.Theme)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.ChildAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local blockingAnalytics = BlockingAnalytics.new(LocalPlayer.UserId, { EventStream = RbxAnalyticsService })

local textSize = Theme.textSize(36)
local textSize2 = Theme.textSize(24)
local textSize3 = Theme.textSize(16)

local function Initialize()
    local var1 = SettingsPageFactory:CreateNewPage()

    var1.TabHeader = nil
    var1.PageListLayout.Parent = nil
    var1.ShouldShowBottomBar = false
    var1.ShouldShowHubBar = false
    var1.IsPageClipped = false
    var1.Page.Name = "ReportSentPage"
    var1.Page.Size = UDim2.fromScale(1, 0)
    var1.Page.AutomaticSize = Enum.AutomaticSize.Y

    var1.Root = Create("Frame")(
        {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Name = "ReportSentContents",
            Parent = var1.Page
        }
    )
    var1.RootLayout = Create("UIListLayout")({
        Name = "RootLayout",
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = var1.Root
    })

    local function createTextLabel(str1: string, text, textSize4, layoutOrder: number)
        return Create("TextLabel")({
            Name = str1,
            LayoutOrder = layoutOrder,
            Size = UDim2.fromScale(1, 0),
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            Text = text,
            TextSize = textSize4,
            Font = Theme.font(Enum.Font.SourceSansBold, "Bold"),
            TextWrap = true,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Center,
            Parent = var1.Root
        })
    end

    local function createButton(str1: string, arg1, layoutOrder: number, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var2, var3 = Utility:MakeStyledButton(str1, arg1, UDim2.new(1, 0, 0, 50), arg2)

        var2.LayoutOrder = layoutOrder
        var2.Parent = var1.Root
        return var2, var3
    end

    local function createSpacer(yOffset: number, layoutOrder: number)
        return Create("Frame")({
            LayoutOrder = layoutOrder,
            Name = "Spacer" .. tostring(layoutOrder),
            Size = UDim2.fromOffset(0, yOffset),
            Parent = var1.Root
        })
    end

    var1.TitleLabel = createTextLabel(
        "TitleLabel",
        RobloxTranslator:FormatByKey("Feature.SettingsHub.Heading.Report.ThanksForReport"),
        textSize,
        0
    )
    var1.BodyLabel = createTextLabel(
        "BodyLabel",
        RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.Report.ReceivedReportBody"),
        textSize2,
        1
    )
    var1.TopSpacer = createSpacer(10, 2)

    var1.ActionHeader = createTextLabel(
        "ActionHeader",
        RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.Report.OtherActionsHeader"),
        textSize3,
        3
    )
    var1.ActionHeader.TextXAlignment = Enum.TextXAlignment.Left

    local blockButton, blockLabel = createButton("BlockButton", RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.Block"), 4, function()
        var1:HandleBlock()
    end)

    var1.BlockButton = blockButton
    var1.BlockLabel = blockLabel

    var1.MiddleSpacer = createSpacer(20, 6)

    local doneButton, _ = createButton("DoneButton", RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.Report.Done"), 7, function()
        var1:HandleDone()
    end)

    var1.DoneButton = doneButton

    return var1
end

local var1 = Initialize()

function var1.UpdateActions(arg1)
    if not arg1.ReportedPlayer then
        arg1.TopSpacer.Visible = false
        arg1.ActionHeader.Visible = false
        arg1.BlockButton.Visible = false

        return
    end

    arg1.TopSpacer.Visible = true
    arg1.ActionHeader.Visible = true

    local isPlayerBlockedByUserId = BlockingUtility:IsPlayerBlockedByUserId(arg1.ReportedPlayer.UserId)
    arg1.BlockButton.Visible = not isPlayerBlockedByUserId

    local displayName = arg1.ReportedPlayer.DisplayName
    local reportedPlayerName = arg1.ReportedPlayer.Name
    local var2 = RobloxTranslator:FormatByKey(
        "Feature.SettingsHub.Label.Report.BlockDisplayName",
        { DISPLAY_NAME = displayName, RBX_NAME = reportedPlayerName }
    )
    arg1.BlockLabel.Text = var2
end

function var1.ShowReportedPlayer(arg1, reportedPlayer)
    arg1.ReportedPlayer = reportedPlayer
    arg1:UpdateActions()

    arg1.HubRef:SwitchToPage(var1, true)
end

function var1.HandleBlock(arg1)
    if arg1.ReportedPlayer then
        onBlockButtonActivated(arg1.ReportedPlayer, blockingAnalytics)
    end
    arg1:HandleDone()
end

function var1.HandleDone(arg1)
    arg1.HubRef:SetVisibility(false, true)
end

return var1
