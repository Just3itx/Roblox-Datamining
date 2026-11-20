-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local CorePackages = game:GetService("CorePackages")
local Observable = require(CorePackages.Workspace.Packages.Observable)
local VrSpatialUi = require(CorePackages.Workspace.Packages.VrSpatialUi)
local PanelType = VrSpatialUi.Constants.PanelType
local UIManager = VrSpatialUi.UIManager
local Theme = require(script.Parent.Theme)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local _UIBlox = require(CorePackages.Packages.UIBlox)
local GetStyleTokens = require(RobloxGui.Modules.Chrome.ChromeShared.Utility.GetStyleTokens)

local ChatSelector = require(RobloxGui.Modules.ChatSelector)

local engineFeature = game:GetEngineFeature("CoreScriptVersionEnabled")
local num1 = game:DefineFastInt("SpatialUIDarkenBackgroundTransparency", 0)
local num2 = game:DefineFastInt("SpatialUIVersionTextSizeScaled", 1400)

local InExperienceUIVRIXP = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).InExperienceUIVRIXP
local FFlagSpatialUIFixMenuPanelChatExclusive = require(RobloxGui.Modules.Settings.Flags.FFlagSpatialUIFixMenuPanelChatExclusive)
local bool1 = game:DefineFastFlag("SpatialUIFixGameInviteChatExclusive", false)

local var1 = nil
local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
    if var1 == nil then
        var1 = GetStyleTokens()
    end
    return var1
end

local function setFieldWithBackup(clippingShield, _originalShieldConfig, str1: string, arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if _originalShieldConfig ~= nil then
        _originalShieldConfig[str1] = clippingShield[str1]
        clippingShield[str1] = arg1
    end
end

local function restoreFieldFromBackup(clippingShield, _originalShieldConfig, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    if _originalShieldConfig ~= nil then
        clippingShield[str1] = _originalShieldConfig[str1]
    end
end

local module = {}
module.__index = module

function module.new(_settingsHub)
    local tbl1 = {
        _settingsHub = _settingsHub,
        _originalShieldConfig = nil,
        _backgroundUICorner = nil,
        _vrEnabled = false,
        _surfaceGuiEnabledConnection = nil,
        _topBarConnection = nil,
        _userGui = nil,
        _windowsVisibilityValues = {},
        _windowsDisconnectCallbacks = {},
        _openVRMenuHandler = nil,
        _originalVersionTextSizes = {}
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:enableVR()
    local tbl1 = {
        panelType = PanelType.MoreMenu,
        screenGuiProps = {
            Name = "MoreMenu",
            ResetOnSpawn = false,
            DisplayOrder = -1,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        }
    }
    local var2 = UIManager.getInstance():createUI(tbl1)
    if var2 == nil then
        return
    end
    local panelObject = var2.panelObject
    local observableValue = Observable.ObservableValue.new(self._settingsHub.Visible)
    self._surfaceGuiEnabledConnection = observableValue:connect(function()
        panelObject.Enabled = observableValue:get()
    end)
    self:connectWindowsVisibility(observableValue)
    UIManager.getInstance():connectPanelVisibility(PanelType.MoreMenu, observableValue)
    self._originalShieldConfig = {}
    setFieldWithBackup(self._settingsHub.ClippingShield, self._originalShieldConfig, "Parent", panelObject)
    setFieldWithBackup(self._settingsHub.ClippingShield, self._originalShieldConfig, "Size", UDim2.new(1, 0, 1, 0))
    setFieldWithBackup(self._settingsHub.ClippingShield, self._originalShieldConfig, "Position", UDim2.new(0, 0, 0, 0))
    if self._settingsHub.DarkenBackground then
        self._backgroundUICorner = Create("UICorner")({ CornerRadius = Theme.MenuContainerCornerRadius, Parent = self._settingsHub.DarkenBackground })
    end

    self._vrEnabled = true
    if self._topBarConnection == nil then
        local vrHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub
        local observableValue2 = Observable.ObservableValue.new(vrHub.ShowTopBar)
        self._topBarConnection = vrHub.ShowTopBarChanged.Event:connect(function()
            observableValue2:set(vrHub.ShowTopBar)
        end)
        UIManager.getInstance():connectTopBarVisibility(observableValue2)

        local chrome = RobloxGui.Modules.Chrome
        local service = require(chrome.ChromeShared.Service)
        service:onTriggerVRToggleButton():connect(function(arg1)
            vrHub:SetShowTopBar(arg1)
        end)
        service:connectTopBarVisibility(observableValue2)
    end
    self:setVersionTextSize()
end

function module:isInputEventNeededBySettings(arg1, arg2, arg3)
    if self._vrEnabled then
        if self._userGui == nil then
            self._userGui = require(RobloxGui.Modules.VR.UserGui)
        end
        if self._userGui:isInputNeededForOpenVRMenu(arg3) then
            if self._openVRMenuHandler == nil then
                self._openVRMenuHandler = self._userGui:getOpenVRMenuHandler()
            end
            self._openVRMenuHandler(arg1, arg2, arg3)
            return false
        end

        if arg3.KeyCode == Enum.KeyCode.Thumbstick2 then
            return true
        end
    end
    return false
end

function module:disableVR()
    if not self._vrEnabled then
        return
    end
    restoreFieldFromBackup(self._settingsHub.ClippingShield, self._originalShieldConfig, "Parent")
    restoreFieldFromBackup(self._settingsHub.ClippingShield, self._originalShieldConfig, "Size")
    restoreFieldFromBackup(self._settingsHub.ClippingShield, self._originalShieldConfig, "Position")
    self._originalShieldConfig = nil
    if self._backgroundUICorner then
        self._backgroundUICorner.Parent = nil
        self._backgroundUICorner = nil
    end
    if self._surfaceGuiEnabledConnection ~= nil then
        self._surfaceGuiEnabledConnection:disconnect()
    end
    self._openVRMenuHandler = nil
    self:disconnectWindowsVisibility()
    UIManager.getInstance():disconnectPanelVisibility(PanelType.MoreMenu)
    self:restoreVersionTextSize()
    self._vrEnabled = false
end

function module:getAspectRatio()
    if not self._vrEnabled then
        return 4 / 3
    end

    local panelSizeInPixel = UIManager.getInstance():getPanelSizeInPixel(PanelType.MoreMenu)
    return panelSizeInPixel.X / panelSizeInPixel.Y
end

function module:getHubBarSize()
    if not self._vrEnabled then
        return 800
    end

    local var2 = Theme.HubPadding()
    local num3 = 0
    if var2 and var2.PaddingLeft then
        num3 += var2.PaddingLeft.Offset
    end
    if var2 and var2.PaddingRight then
        num3 += var2.PaddingRight.Offset
    end
    return UIManager.getInstance():getPanelSizeInPixel(PanelType.MoreMenu).X - num3
end

function module:getMenuContainerPositionOverride()
    if not self._vrEnabled then
        return nil
    end

    return {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X
    }
end

function module:getFullScreenSize()
    if self._vrEnabled then
        return UIManager.getInstance():getPanelSizeInPixel(PanelType.MoreMenu).Y
    end

    return RobloxGui.AbsoluteSize.y
end

function module:getDarkBackgroundTheme()
    if not self._vrEnabled then
        return {
            Color = Theme.color("DarkenBackground"),
            Transparency = Theme.transparency("DarkenBackground")
        }
    end

    return {
        Color = func1().Color.OverMedia.OverMedia_100.Color3,
        Transparency = math.min(math.max(num1, 0), 100) / 100
    }
end

function module:getBottomButtonSize(arg1)
    if self._vrEnabled then
        return math.min(arg1, 233)
    end
    return arg1
end

function module:updatePanelVisibility(arg1)
    for _, value in self._windowsVisibilityValues do
        if not value then
            continue
        end

        if InExperienceUIVRIXP:isMovePanelToCenter() and FFlagSpatialUIFixMenuPanelChatExclusive then
            ChatSelector:HideTemp(PanelType.MoreMenu, true)
        end
        arg1:set(true)
        return
    end

    if InExperienceUIVRIXP:isMovePanelToCenter() and FFlagSpatialUIFixMenuPanelChatExclusive then
        ChatSelector:HideTemp(PanelType.MoreMenu, false)
    end
    arg1:set(false)
end

local function func2(callback)
    local connection = require(CorePackages.Workspace.Packages.GameInvite).GameInviteModalManager.ToggleGameInviteModalEvent.Event:Connect(
        function(arg1)
            callback("GameInvite", arg1)

            if not InExperienceUIVRIXP:isMovePanelToCenter() or not bool1 then
                return
            end

            if arg1 then
                ChatSelector:HideTemp("SettingsMenu", true)
                return
            end
            ChatSelector:HideTemp("SettingsMenu", false)
        end
    )

    return function()
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

local function func3(callback)
    local GuiService = game:GetService("GuiService")

    local connection = GuiService.InspectPlayerFromUserIdWithCtxRequest:Connect(function()
        callback("InspectAndBuy", true)
    end)
    local connection2 = GuiService.CloseInspectMenuRequest:Connect(function()
        callback("InspectAndBuy", false)
    end)
    local connection3 = GuiService.InspectMenuEnabledChangedSignal:Connect(function(enabled: boolean)
        if not enabled then
            callback("InspectAndBuy", false)
        end
    end)

    return function()
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if connection2 then
            connection2:Disconnect()
            connection2 = nil
        end
        if connection3 then
            connection3:Disconnect()
            connection3 = nil
        end
    end
end

function module:connectWindowsVisibility(arg1)
    local function func4(str1: string, bool2: boolean)
        self._windowsVisibilityValues[str1] = bool2
        self:updatePanelVisibility(arg1)
    end

    for _, value in {
        function(callback)
            local connection = self._settingsHub.SettingsShowSignal:connect(function(arg2)
                callback("SettingsHub", arg2)
            end)

            return function()
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
            end
        end,
        func2,
        func3
    } do
        table.insert(self._windowsDisconnectCallbacks, (value(func4)))
    end
end

function module:disconnectWindowsVisibility()
    for _, _windowsDisconnectCallback in self._windowsDisconnectCallbacks do
        _windowsDisconnectCallback()
    end
    self._windowsDisconnectCallbacks = {}
    self._windowsVisibilityValues = {}
end

function module:isOpenCloseAnimationAllowed(): boolean
    return not self._vrEnabled
end

function module:getMenuContainerExtraSpace()
    if not self._vrEnabled then
        return 0
    end

    local menuContainerPadding = self._settingsHub.MenuContainerPadding
    return menuContainerPadding.PaddingTop.Offset + menuContainerPadding.PaddingBottom.Offset
end

local function refreshVersionTextLabelSize(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local uDim2 = UDim2.new(0.2, -6, 1, 0)
    if engineFeature then
        uDim2 = UDim2.new(0, arg1.TextBounds.X + 6, 1, 0)
    end

    arg1.Size = uDim2
end

function module:setVersionTextSize()
    for _, child in (self._settingsHub.VersionContainer:GetChildren()) do
        if child:IsA("TextLabel") then
            self._originalVersionTextSizes[child] = child.TextSize
            child.TextSize = Theme.textSize(num2 / 100)
            refreshVersionTextLabelSize(child)
        end
    end
end

function module:restoreVersionTextSize()
    for _, child in (self._settingsHub.VersionContainer:GetChildren()) do
        if child:IsA("TextLabel") and self._originalVersionTextSizes[child] then
            child.TextSize = self._originalVersionTextSizes[child]
            refreshVersionTextLabelSize(child)
            self._originalVersionTextSizes[child] = nil
        end
    end
    self._originalVersionTextSizes = {}
end

return module
