-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local VRService = game:GetService("VRService")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local _GamepadService = game:GetService("GamepadService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui.RobloxGui
local Modules = RobloxGui:WaitForChild("Modules")
local Panel3D = require(CorePackages.Workspace.Packages.VrCommon).Panel3D
local VRHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub
local VirtualKeyboard = require(RobloxGui.Modules.VR.VirtualKeyboard)
local InGameMenuConstants = require(RobloxGui.Modules.InGameMenuConstants)
local IsSpatialRobloxGuiEnabled = require(RobloxGui.Modules.VR.IsSpatialRobloxGuiEnabled)

local CorePackages2 = game:GetService("CorePackages")
local VRConstants = require(CorePackages2.Workspace.Packages.VrCompatibility).VRConstants

local _UserInputService = game:GetService("UserInputService")
local _RunService = game:GetService("RunService")

local isInExperienceUIVREnabled = require(CorePackages2.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local PanelType, UIManager

if require(CorePackages2.Workspace.Packages.SharedFlags).FFlagEnableUIManagerPackgify then
    local vrSpatialUi = require(CorePackages2.Workspace.Packages.VrSpatialUi)
    PanelType = vrSpatialUi.Constants.PanelType
    UIManager = vrSpatialUi.UIManager
else
    local uiManager = Modules:WaitForChild("UIManager")
    PanelType = require(uiManager.Constants).PanelType
    UIManager = require(uiManager.UIManager)
end

local var1 = (require(RobloxGui.Modules.Flags.GetFIntVRScaleGuiDistance) or 100)() * 0.01
local bool1 = game:DefineFastFlag("FixVRActionBinding", false)
local bool2 = game:DefineFastFlag("FixUserGuiRenderingAfterVRDisabled", false)

if not VRService.VREnabled then
    warn("UserGui should not be required while not in VR")
    return nil
end

VRService.QuestDisplayRefreshRate = 90

local module = {
    ModuleName = "UserGui",
    KeepVRTopbarOpen = false,
    VRIsExclusive = false,
    VRClosesNonExclusive = false,
    SetVisible = nil
}
VRHub:RegisterModule(module)

local _vector2 = Vector2.new(4, 3)
local vector2 = Vector2.new(2.66 * var1, 2 * var1)

local bool3 = false

local var2 = Panel3D.Get(module.ModuleName)
var2:SetType(Panel3D.Type.NewStandard)
var2:GetPart().CanQuery = false

local vector2_2 = Vector2.new(2.7978, 2.09835)
var2:ResizeStuds(vector2_2.x, vector2_2.y, 128)

var2:SetVisible(false)
local getPanel

if IsSpatialRobloxGuiEnabled then
    getPanel = Panel3D.Get(VRConstants.PositionLockedPanelName)
    config = {}
    local tbl1 = {
        panelType = PanelType.RobloxGui
    }
    config.uiManagerPanelPart = UIManager.getInstance():createUI(tbl1).panelObject
    local uiManagerManaged = Panel3D.Type.UIManagerManaged
    local config = config
    getPanel:SetType(uiManagerManaged, config)
else
    getPanel = Panel3D.Get(VRConstants.PositionLockedPanelName)
    local positionLocked = Panel3D.Type.PositionLocked
    getPanel:SetType(positionLocked)
end

getPanel:GetPart().CanQuery = false

local x = vector2.x
local y = vector2.y
getPanel:ResizeStuds(x, y, 128)
getPanel:SetVisible(false)
getPanel.showCursor = true

VRHub.ModuleOpened.Event:connect(function(moduleName)
    if moduleName ~= module.ModuleName and VRHub:GetModule(moduleName).VRClosesNonExclusive and var2:IsVisible() then
        module:SetVisible(false, nil)
    end
end)

local bool4 = false
local IsVisible = false

function module.SetVisible(_, arg1, arg2)
    IsVisible = arg1
    if arg2 then
        arg2:SetVisible(IsVisible)
    end

    if IsVisible then
        VRHub:FireModuleOpened(module.ModuleName)
    else
        VRHub:FireModuleClosed(module.ModuleName)
    end

    local var4 = IsVisible and not bool4
    if IsSpatialRobloxGuiEnabled then
        CoreGui:SetUserGuiRendering(true, var4 and arg2 and arg2:GetPart() or nil, Enum.NormalId.Back)
        return
    end
    CoreGui:SetUserGuiRendering(true, var4 and arg2 and arg2:GetPart() or nil, Enum.NormalId.Front)
end

function module.IsVisible(_)
    return IsVisible
end

function module.Update(arg1)
    arg1:SetVisible(IsVisible)
end

local function onGuiSelection()
    if bool2 and not VRService.VREnabled then
        return
    end

    VRHub.LaserPointer:updateInputUserCFrame()

    if not VRHub.ShowTopBar then
        getPanel:StartLerp(vector2 * 0.25)
        module:SetVisible(false, getPanel)

        GuiService.SelectedObject = nil
        bool3 = false
        return
    end

    module:SetVisible(true, getPanel)
    getPanel.initialCFLerp = 1
    getPanel:ForcePositionUpdate(true)
    getPanel.distance = 2.5 * var1

    if not bool3 then
        getPanel:StartLerp(vector2)
        bool3 = true
    end
end

VRHub.ShowTopBarChanged.Event:connect(onGuiSelection)
GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(onGuiSelection)
VRService.UserCFrameEnabled:Connect(onGuiSelection)
GuiService.PurchasePromptShown:Connect(function()
    if not VRHub.ShowTopBar then
        VRHub:SetShowTopBar(true)
    end
end)

local function onGuiSelectedObjectChanged(_)
    if (GuiService.SelectedObject or GuiService.SelectedCoreObject) and not VRHub.ShowTopBar then
        VRHub:SetShowTopBar(true)
    end
    GuiService.SelectedObject = nil
    GuiService.SelectedCoreObject = nil
end

GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(onGuiSelectedObjectChanged)
GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(onGuiSelectedObjectChanged)

local InGameMenu = require(RobloxGui.Modules.InGameMenu)

local function onVRMenuClicked(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == "OpenVRMenu" then
        if not VRHub.ShowTopBar then
            VRHub:SetShowTopBar(true)

            RbxAnalyticsService:ReportCounter("VR-BindAction-ToggleGui-On")
        else
            VRHub:SetShowTopBar(false)
            InGameMenu.closeInGameMenu()

            RbxAnalyticsService:ReportCounter("VR-BindAction-ToggleGui-Off")
        end
    end

    if str1 ~= "OpenIGMenu" then
        return
    end

    if not VRHub.ShowTopBar then
        VRHub:SetShowTopBar(true)
    end

    if not InGameMenu.getOpen() then
        InGameMenu.openInGameMenu(InGameMenuConstants.MainPagePageKey)
    end
end

local function handleAction(str1: string, userInputState: Enum.UserInputState, _inputObject: InputObject)
    if userInputState == Enum.UserInputState.Begin then
        onVRMenuClicked(str1)
    end
end

if isInExperienceUIVREnabled then
    local inputHandlers = require(CorePackages2.Packages.InputHandlers)
    local bool6 = false
    local bool7 = false

    function module.isInputNeededForOpenVRMenu(_, arg1): boolean
        return arg1.KeyCode == Enum.KeyCode.ButtonSelect
    end

    function module.getOpenVRMenuHandler(_)
        local var4 = inputHandlers.handleInput({
            onPress = function()
                bool6 = true
                bool7 = false
            end,
            hold = {
                durationSeconds = 1,
                onComplete = function()
                    bool7 = true
                    UIManager.getInstance():resetDragAndDrop()
                end,
                allowReleaseAfterHold = true
            },
            onRelease = function()
                if not bool7 then
                    onVRMenuClicked("OpenVRMenu")
                end

                bool6 = false
                bool7 = false
            end
        })
        return function(_, userInputState, _)
            var4({ eventData = { UserInputState = userInputState } })
        end
    end
end

if bool1 or isInExperienceUIVREnabled then
    if isInExperienceUIVREnabled then
        ContextActionService:BindCoreAction("OpenVRMenu", module:getOpenVRMenuHandler(), false, Enum.KeyCode.ButtonSelect)
    else
        ContextActionService:BindCoreAction("OpenVRMenu", handleAction, false, Enum.KeyCode.ButtonSelect)
    end
else
    ContextActionService:BindAction("OpenVRMenu", handleAction, false, Enum.KeyCode.ButtonSelect)
end
ContextActionService:BindAction("OpenIGMenu", handleAction, false, Enum.KeyCode.ButtonStart)

local function OnVREnabledChanged()
    if not VRService.VREnabled then
        var2:SetVisible(false)
        CoreGui:SetUserGuiRendering(false, nil, Enum.NormalId.Front)
        return
    end
    module:SetVisible(false, var2)
    module:SetVisible(true, getPanel)
    VRHub:SetShowTopBar(true)
end

VRService:GetPropertyChangedSignal("VREnabled"):connect(OnVREnabledChanged)
OnVREnabledChanged()

VirtualKeyboard.OpenedEvent:connect(function()
    bool4 = true
    module:Update()
end)

VirtualKeyboard.ClosedEvent:connect(function()
    bool4 = false
    module:Update()
end)

VRHub:SetShowTopBar(true)
onGuiSelection()

function module.getPanel(_)
    return getPanel
end

return module
