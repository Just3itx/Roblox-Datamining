-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CorePackages = game:GetService("CorePackages")

local PerfUtils = require(RobloxGui.Modules.Common.PerfUtils)
local Utility = require(RobloxGui.Modules.Settings.Utility)
local LinkingProtocol = require(CorePackages.Workspace.Packages.LinkingProtocol)
local DeepLinkSource = LinkingProtocol.Enums.DeepLinkSource
local LinkingProtocol2 = LinkingProtocol.LinkingProtocol
local Theme = require(RobloxGui.Modules.Settings.Theme)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local FFlagResponsiveUnitsDeprecateTenFoot = require(CorePackages.Workspace.Packages.SharedFlags).FFlagResponsiveUnitsDeprecateTenFoot
local var1 = require(RobloxGui.Modules.TenFootInterface):IsEnabled() and not FFlagResponsiveUnitsDeprecateTenFoot

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local GetFFlagEnableInGameMenuDurationLogger = require(RobloxGui.Modules.Common.Flags.GetFFlagEnableInGameMenuDurationLogger)
local fFlag = settings():GetFFlag("CollectAnalyticsForSystemMenu")

local GetDefaultQualityLevel = require(CorePackages.Workspace.Packages.AppCommonLib).GetDefaultQualityLevel

local Constants = if fFlag then require(RobloxGui.Modules:WaitForChild("InGameMenu"):WaitForChild("Resources"):WaitForChild("Constants")) else nil

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local function Initialize()
    local var2 = require(RobloxGui.Modules.Settings.SettingsPageFactory):CreateNewPage()

    var2.playsessionid = ""
    if engineFeature then
        var2.playsessionid = RbxAnalyticsService:GetPlaySessionId()
    end

    function var2.LeaveFunc()
        if GetFFlagEnableInGameMenuDurationLogger() then
            PerfUtils.leavingGame()
        end
        GuiService.SelectedCoreObject = nil

        if fFlag then
            RbxAnalyticsService:SetRBXEventStream(
                Constants.AnalyticsTargetName,
                Constants.AnalyticsInGameMenuName,
                Constants.AnalyticsLeaveGameName,
                {
                    confirmed = Constants.AnalyticsConfirmedName,
                    universeid = tostring(game.GameId),
                    source = Constants.AnalyticsLeaveToHomeSource,
                    playsessionid = var2.playsessionid
                }
            )
        end

        if LinkingProtocol2.default:isInternalDlicEnabled() then
            local var3 = LinkingProtocol2.default:createInternalDlic("roblox://navigation/home", DeepLinkSource.LuaInternal)

            LinkingProtocol2.default:detectDeeplinkIntent(var3)
        else
            LinkingProtocol2.default:detectURL("roblox://navigation/home")
        end

        RunService.RenderStepped:wait()
        RunService.RenderStepped:wait()

        game:Shutdown()

        settings().Rendering.QualityLevel = GetDefaultQualityLevel()
    end
    function var2.DontLeaveFunc(arg1)
        if var2.HubRef then
            var2.HubRef:PopMenu(arg1, true)
        end

        if not fFlag then
            return
        end

        RbxAnalyticsService:SetRBXEventStream(
            Constants.AnalyticsTargetName,
            Constants.AnalyticsInGameMenuName,
            Constants.AnalyticsLeaveGameName,
            {
                confirmed = Constants.AnalyticsCancelledName,
                universeid = tostring(game.GameId),
                source = Constants.AnalyticsLeaveToHomeSource,
                playsessionid = var2.playsessionid
            }
        )
    end

    function var2.DontLeaveFromHotkey(_, userInputState, arg1)
        if userInputState == Enum.UserInputState.Begin then
            local bool1 = arg1.UserInputType == Enum.UserInputType.Gamepad1
                or arg1.UserInputType == Enum.UserInputType.Gamepad2
                or arg1.UserInputType == Enum.UserInputType.Gamepad3
                or arg1.UserInputType == Enum.UserInputType.Gamepad4

            var2.DontLeaveFunc(bool1)
        end
    end
    function var2.DontLeaveFromButton(arg1)
        var2.DontLeaveFunc(arg1)
    end

    var2.TabHeader = nil

    var2.Page.Name = "LeaveGameToHomePage"
    var2.ShouldShowBottomBar = false
    var2.ShouldShowHubBar = false

    local var3 = RobloxTranslator:FormatByKey(
        if fFlag then Constants.ConfirmLeaveGameLocalizedKey else "CoreScripts.InGameMenu.Prompt.ConfirmLeaveGame"
    )

    local var4 = Create("TextLabel")({
        Name = "LeaveGameText",
        Text = var3,
        Font = Theme.font(Enum.Font.SourceSansBold, "Confirmation"),
        FontSize = Theme.fontSize(Enum.FontSize.Size36, "Confirmation"),
        TextColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 200),
        TextWrapped = true,
        ZIndex = 2,
        Parent = var2.Page,
        Position = var1 and UDim2.new(0, 0, 0, 100) or UDim2.new(0, 0, 0, 0)
    })

    local var5 = Create("Frame")({
        Name = "LeaveButtonContainer",
        Parent = var4,
        Size = UDim2.new(1, 0, 0, 400),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 1, 0)
    })

    Create("UIGridLayout")({
        Name = "LeavetButtonsLayout",
        CellSize = var1 and UDim2.new(0, 300, 0, 80) or UDim2.new(0, 200, 0, 50),
        CellPadding = UDim2.new(0, 20, 0, 20),
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Parent = var5
    })

    if Utility:IsSmallTouchScreen() then
        var4.FontSize = Enum.FontSize.Size24
        var4.Size = UDim2.new(1, 0, 0, 100)
    elseif var1 then
        var4.FontSize = Enum.FontSize.Size48
    end

    var2.LeaveGameButton = Utility:MakeStyledButton("LeaveGame", "Leave", nil, var2.LeaveFunc)
    var2.LeaveGameButton.NextSelectionRight = nil
    var2.LeaveGameButton.Parent = var5

    local var6 = Utility:MakeStyledButton(
        "DontLeaveGame",
        RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.DontLeaveButton"),
        nil,
        var2.DontLeaveFromButton
    )
    var6.NextSelectionLeft = nil
    var6.Parent = var5

    var2.Page.Size = UDim2.new(1, 0, 0, var6.AbsolutePosition.Y + var6.AbsoluteSize.Y)

    return var2
end

local var2 = Initialize()

var2.Displayed.Event:connect(function()
    GuiService.SelectedCoreObject = var2.LeaveGameButton
    ContextActionService:BindCoreAction("LeaveGameCancelAction", var2.DontLeaveFromHotkey, false, Enum.KeyCode.ButtonB)
end)

var2.Hidden.Event:connect(function()
    ContextActionService:UnbindCoreAction("LeaveGameCancelAction")
end)

return var2
