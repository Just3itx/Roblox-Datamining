-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local Utility = require(RobloxGui.Modules.Settings.Utility)
local BuilderIcons = require(CorePackages.Packages.BuilderIcons)
local uiblox = BuilderIcons.Migration.uiblox
local Foundation = require(CorePackages.Packages.Foundation)
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant

local LegacyAbuseReportMenu = require(RobloxGui.Modules.AbuseReportMenu).LegacyAbuseReportMenu
local AbuseReportMenuV2 = require(RobloxGui.Modules.AbuseReportMenu).AbuseReportMenuV2
local ReportAbuseAnalytics = require(RobloxGui.Modules.AbuseReportMenu).ReportAbuseAnalytics

local Chrome = RobloxGui.Modules.Chrome
local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local Service = if var1 then require(Chrome.Service) else nil
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagInExperienceReportClosingBugfix = SharedFlags.FFlagInExperienceReportClosingBugfix
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)

local FFlagHideShortcutsOnReportDropdown = require(RobloxGui.Modules.AbuseReportMenu.Flags.FFlagHideShortcutsOnReportDropdown)
local FFlagReportFocusNavIEMButtons = require(RobloxGui.Modules.AbuseReportMenu.Flags.FFlagReportFocusNavIEMButtons)
local FFlagReportFocusNavCloseButton = require(RobloxGui.Modules.AbuseReportMenu.Flags.FFlagReportFocusNavCloseButton)
local FFlagStandardizeSafetyIcon = SharedFlags.FFlagStandardizeSafetyIcon
local ShouldDisableDefaultScroll = game:DefineFastFlag("SwitchOverToAbuseReportMenuV2", false)

local function Initialize()
    local var2 = require(RobloxGui.Modules.Settings.SettingsPageFactory):CreateNewPage()

    function var2._onHiddenCallback() end
    function var2._onDisplayedCallback() end
    function var2._onDisplayingCallback() end
    function var2._onSettingsHiddenCallback() end
    function var2._setNextPlayerToReportCallback() end
    function var2._onMenuWidthChange() end

    function var2.SetHub(_, hubRef)
        var2.HubRef = hubRef

        var2.HubRef.SettingsShowSignal:connect(function(arg1)
            if not arg1 then
                var2:onSettingsHidden()
            end
        end)

        return var2
    end

    function var2.showAlert(_, arg1, arg2, arg3)
        Utility:ShowAlert(arg1, arg2, var2.HubRef, arg3)
    end

    function var2.showReportSentPage(_, arg1)
        var2.HubRef.ReportSentPageV2:ShowReportedPlayer(arg1, true)
    end

    function var2.HideMenu(_)
        var2.HubRef:SetVisibility(false, true)
    end

    function var2.ShowMenu(_)
        var2.HubRef:SetVisibility(true, true, var2, nil, "ScreenshotUnhide")
    end

    function var2.onHidden(_)
        var2._onHiddenCallback()
    end

    function var2.onSettingsHidden(_)
        var2._onSettingsHiddenCallback()
    end

    function var2.onDisplayed(_)
        var2._onDisplayedCallback()
    end

    function var2.onDisplaying(_)
        var2._onDisplayingCallback()
    end

    function var2.setNextPlayerToReport(_, arg1)
        var2._setNextPlayerToReportCallback(arg1)
    end

    var2.TabHeader.Name = "ReportAbuseTab"
    local iconsActionsFeedback = uiblox["icons/actions/feedback"]
    local var3 = FFlagStandardizeSafetyIcon and {
        name = IconName.Flag,
        variant = IconVariant.Regular
    } or iconsActionsFeedback

    var2.TabHeader.TabLabel.Icon.Text = var3.name
    var2.TabHeader.TabLabel.Icon.FontFace = BuilderIcons.Font[var3.variant]
    var2.TabHeader.TabLabel.Title.Text = "Report"

    var2.Page.Name = "ReportAbuseMenuNewContainerPage"
    var2.ShouldShowBottomBar = not isSideSheetEnabled
    var2.ShouldShowHubBar = true
    var2.ShouldDisableDefaultScroll = ShouldDisableDefaultScroll

    local element = Roact.createElement(if ShouldDisableDefaultScroll then AbuseReportMenuV2 else LegacyAbuseReportMenu, {
        hideReportTab = function()
            var2:HideMenu()
        end,
        showReportTab = function()
            var2:ShowMenu()
        end,
        registerOnReportTabHidden = function(_onHiddenCallback)
            var2._onHiddenCallback = _onHiddenCallback
        end,
        registerOnReportTabDisplayed = function(_onDisplayedCallback)
            var2._onDisplayedCallback = _onDisplayedCallback
        end,
        registerOnReportTabDisplaying = function(_onDisplayingCallback)
            var2._onDisplayingCallback = _onDisplayingCallback
        end,
        registerOnMenuWidthChange = function(_onMenuWidthChange)
            var2._onMenuWidthChange = _onMenuWidthChange
        end,
        registerSetNextPlayerToReport = function(_setNextPlayerToReportCallback)
            var2._setNextPlayerToReportCallback = _setNextPlayerToReportCallback
        end,
        registerOnSettingsHidden = function(_onSettingsHiddenCallback)
            var2._onSettingsHiddenCallback = _onSettingsHiddenCallback
        end,
        showReportSentPage = function(arg1)
            var2:showReportSentPage(arg1)
        end,
        onReportComplete = function(arg1)
            if FFlagInExperienceReportClosingBugfix and var1 then
                Service:setShortcutBar(nil)
            end
            var2:showAlert(arg1, "Ok", function()
                var2:HideMenu()
            end)
        end,
        onDropdownMenuOpenChange = if FFlagHideShortcutsOnReportDropdown then var1 and function(arg1)
            Service:setHideShortcutBar("InExperienceReportDropdown", arg1)
        end or nil else nil,
        getSettingsHubRef = FFlagReportFocusNavIEMButtons and function()
            return var2.HubRef
        end or FFlagReportFocusNavCloseButton and function()
            return var2.HubRef
        end or nil
    })

    Roact.mount(element, var2.Page, "AbuseReportMenu")

    var2.Page.Size = UDim2.new(1, 0, 0, 0)
    var2.Page.AutomaticSize = Enum.AutomaticSize.Y

    var2.Page:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
        var2._onMenuWidthChange(var2.Page.AbsoluteSize.X)
    end)

    return var2
end

local var2 = Initialize()

var2.Displayed.Event:connect(function()
    var2:onDisplayed()
end)

var2.Displaying.Event:connect(function()
    var2:onDisplaying()
end)

var2.Hidden.Event:connect(function()
    var2:onHidden()
end)

function var2.ReportPlayer(_, arg1, arg2)
    if not arg1 then
        return
    end

    ReportAbuseAnalytics:startAbuseReportSession(arg2)
    var2:setNextPlayerToReport(arg1)

    if not var2.HubRef:GetVisibility() then
        var2.HubRef:SetVisibility(true, false, var2)
        return
    end
    var2.HubRef:SwitchToPage(
        var2,
        false,
        nil,
        nil,
        nil,
        {
            entrypoint = ReportAbuseAnalytics:getAbuseReportSessionEntryPoint()
        }
    )
end

return var2
