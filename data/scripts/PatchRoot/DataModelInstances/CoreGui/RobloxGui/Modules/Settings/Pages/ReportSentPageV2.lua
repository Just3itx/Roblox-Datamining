-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Modules = RobloxGui:WaitForChild("Modules")

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local EventIngestService = game:GetService("EventIngestService")
local var1 = require(CorePackages.Workspace.Packages.Analytics).Analytics.new(RbxAnalyticsService)
local EventIngest = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventIngest
local Roact = require(CorePackages.Packages.Roact)
local Settings = script:FindFirstAncestor("Settings")
local SettingsPageFactory = require(Modules.Settings.SettingsPageFactory)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local ReportAbuseAnalytics = require(RobloxGui.Modules.AbuseReportMenu).ReportAbuseAnalytics
local BlockingAnalytics = require(Settings.Analytics.BlockingAnalytics)
local CoreScriptsRootProvider = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).CoreScriptsRootProvider
local FocusNavigationUtils = require(CorePackages.Workspace.Packages.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local ReportConfirmationContainer = require(Settings.Components.ReportConfirmation.ReportConfirmationContainer)

local Chrome = RobloxGui.Modules.Chrome
local var2 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local Service = if var2 then require(Chrome.Service) else nil
local FFlagEnableConsoleExpControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableConsoleExpControls

local var3 = nil
local function func1() -- Luacid: Inlined by compiler; 2 call sites recovered
    if var3 ~= nil then
        Roact.unmount(var3)
        var3 = nil
    end
end

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.ChildAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local reportAbuseAnalytics = ReportAbuseAnalytics.new(
    EventIngest.new(EventIngestService),
    var1.Diag,
    ReportAbuseAnalytics.MenuContexts.LegacySentPage
)

local blockingAnalytics = BlockingAnalytics.new(LocalPlayer.UserId, { EventStream = RbxAnalyticsService })

local function Initialize()
    local var4 = SettingsPageFactory:CreateNewPage()

    var4.TabHeader = nil
    var4.PageListLayout.Parent = nil
    var4.ShouldShowBottomBar = false
    var4.ShouldShowHubBar = false
    var4.IsPageClipped = false
    var4.Page.Name = "ReportSentPageV2"
    var4.Page.Size = UDim2.fromScale(1, 0)
    var4.Page.AutomaticSize = Enum.AutomaticSize.Y

    var4.Root = Create("Frame")(
        {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Name = "ReportSentContents",
            Parent = var4.Page
        }
    )
    return var4
end

local var4 = Initialize()

function var4.UpdateMenu(arg1)
    local reportedPlayer = arg1.ReportedPlayer
    func1()

    if arg1.settingsShowChangedSignal then
        arg1.settingsShowChangedSignal:disconnect()
        arg1.settingsShowChangedSignal = nil
    end

    arg1.settingsShowChangedSignal = arg1.HubRef.SettingsShowSignal:connect(function(arg2)
        if not arg2 then
            arg1:HandleDone()
        end
    end)

    local bindableEvent = Instance.new("BindableEvent")
    arg1.SizeChangedSignal = arg1.Root:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        bindableEvent:Fire(arg1.Root.AbsoluteSize)
    end)

    local tbl1 = {
        player = {
            UserId = reportedPlayer.UserId,
            Name = reportedPlayer.Name,
            DisplayName = reportedPlayer.DisplayName
        },
        closeMenu = function()
            arg1:HandleDone()
        end,
        isVoiceReport = arg1.isVoiceReport,
        ZIndex = arg1.HubRef.Shield.ZIndex + 1,
        reportAbuseAnalytics = reportAbuseAnalytics,
        blockingAnalytics = blockingAnalytics,
        onSizeChanged = bindableEvent.Event
    }

    local element = Roact.createElement(CoreScriptsRootProvider, {}, {
        FocusRoot = Roact.createElement(
            FocusRoot,
            {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.RouterView,
                isIsolated = true,
                isAutoFocusRoot = true
            },
            {
                ThankYouScreenRoot = Roact.createElement(ReportConfirmationContainer, tbl1)
            }
        )
    })
    if var2 and FFlagEnableConsoleExpControls then
        Service:setHideShortcutBar("ReportSentPageV2", true)
    end

    var3 = Roact.mount(element, arg1.Root, "ReportSentPageV2")
end

function var4.ShowReportedPlayer(arg1, reportedPlayer, isVoiceReport)
    arg1.ReportedPlayer = reportedPlayer
    arg1.isVoiceReport = isVoiceReport
    arg1:UpdateMenu()

    arg1.HubRef:SwitchToPage(var4, true)
end

function var4.HandleDone(arg1)
    if var2 and FFlagEnableConsoleExpControls then
        Service:setHideShortcutBar("ReportSentPageV2", false)
    end

    func1()

    if arg1.settingsShowChangedSignal then
        arg1.settingsShowChangedSignal:disconnect()
        arg1.settingsShowChangedSignal = nil
    end

    if arg1.SizeChangedSignal then
        arg1.SizeChangedSignal:disconnect()
        arg1.SizeChangedSignal = nil
    end

    arg1.HubRef:SetVisibility(false, true)
end

return var4
