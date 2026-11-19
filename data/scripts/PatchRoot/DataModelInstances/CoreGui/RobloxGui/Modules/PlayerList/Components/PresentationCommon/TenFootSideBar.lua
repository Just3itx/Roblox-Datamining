-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParentParent = script.Parent.Parent.Parent
local ClosePlayerDropDown = require(scriptParentParentParent.Actions.ClosePlayerDropDown)
local SetPlayerListVisibility = require(scriptParentParentParent.Actions.SetPlayerListVisibility)

local isNewInGameMenuEnabled = require(CoreGui.RobloxGui.Modules.isNewInGameMenuEnabled)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local var1 = Roact.PureComponent:extend("TenFootSideBar")

function var1.init(arg1)
    arg1.sideBar = nil
end

function var1.render(_)
    return nil
end

function var1.openSidebar(arg1, localPlayer)
    local bool1 = not RunService:IsStudio() and localPlayer ~= Players.LocalPlayer

    if not bool1 then
        arg1.props.closeSideBar()
        return
    end

    local selectedCoreObject = GuiService.SelectedCoreObject
    local screenManager = RobloxGui.Modules:FindFirstChild("ScreenManager") or RobloxGui.Modules.Shell.ScreenManager
    local var2 = require(screenManager)
    local localizedStrings = RobloxGui.Modules:FindFirstChild("LocalizedStrings") or RobloxGui.Modules.Shell.LocalizedStrings
    local var3 = require(localizedStrings)

    if not arg1.sideBar then
        local sideBar = RobloxGui.Modules:FindFirstChild("SideBar") or RobloxGui.Modules.Shell.SideBar
        arg1.sideBar = require(sideBar)()
    end

    arg1.sideBar:RemoveAllItems()

    if bool1 then
        local var4 = var3:LocStringUA("Xbox.Old.ReportPlayer")
        arg1.sideBar:AddItem(var4, function()
            arg1.props.closePlayerList()
            GuiService.SelectedCoreObject = nil
            if isNewInGameMenuEnabled() then
                require(RobloxGui.Modules.InGameMenuInit).openReportDialog(localPlayer, arg1.__componentName)
                return
            end
            require(RobloxGui.Modules.Settings.Pages.ReportAbuseMenuContainerPage):ReportPlayer(localPlayer, arg1.__componentName)
        end)
    end

    local connection = nil

    connection = arg1.sideBar.Closed:connect(function()
        connection:disconnect()
        arg1.props.closeSideBar()
        if not arg1.props.playerListVisible then
            return
        end

        if selectedCoreObject and selectedCoreObject.Parent then
            GuiService.SelectedCoreObject = selectedCoreObject
            return
        end

        arg1.props.closePlayerList()
        arg1.props.openPlayerList()
    end)

    var2:OpenScreen(arg1.sideBar, false)
end

function var1.didMount(arg1)
    if arg1.props.sideBarVisible then
        arg1:openSidebar(arg1.props.selectedPlayer)
    end
end

function var1.didUpdate(arg1, arg2)
    if arg1.props.sideBarVisible and arg1.props.sideBarVisible ~= arg2.sideBarVisible then
        arg1:openSidebar(arg1.props.selectedPlayer)
    end
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        selectedPlayer = arg1.playerDropDown.selectedPlayer,
        sideBarVisible = arg1.displayOptions.isTenFootInterface and arg1.playerDropDown.isVisible,
        playerListVisible = arg1.displayOptions.isVisible
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        closeSideBar = function()
            return arg1(ClosePlayerDropDown())
        end,
        closePlayerList = function()
            return arg1(SetPlayerListVisibility(false))
        end,
        openPlayerList = function()
            return arg1(SetPlayerListVisibility(true))
        end
    }
end)(var1)
