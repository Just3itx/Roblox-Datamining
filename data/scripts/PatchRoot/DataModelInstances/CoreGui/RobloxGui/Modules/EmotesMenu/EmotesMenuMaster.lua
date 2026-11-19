-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:02:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")
local StarterGui = game:GetService("StarterGui")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Signals = require(CorePackages.Packages.Signals)
local InExperienceTopBar = require(CorePackages.Workspace.Packages.InExperienceTopBar)

local ColorMode = require(CorePackages.Packages.Foundation).Enums.ColorMode

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Actions = scriptParent.Actions
local Components = scriptParent.Components
local Reducers = scriptParent.Reducers
local Thunks = scriptParent.Thunks
local Utility = scriptParent.Utility

local FFlagEnableNewBackpack = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableNewBackpack
local Features = if FFlagEnableNewBackpack then require(CorePackages.Workspace.Packages.System).Features else nil
local BackpackScript = if FFlagEnableNewBackpack then nil else require(scriptParentParent.BackpackScript)
local ChatSelector = require(scriptParentParent.ChatSelector)
local TenFootInterface = require(scriptParentParent.TenFootInterface)
local Constants = require(scriptParentParent.TopBar.Constants)
local InExperienceAppChatModal = require(CorePackages.Workspace.Packages.AppChat.InExperienceAppChatModal)
local FFlagTopBarSignalizeSetCores = InExperienceTopBar.Flags.FFlagTopBarSignalizeSetCores

local Constants2 = UIBlox.App.Style.Constants
local UiModeStyleProvider = require(CorePackages.Workspace.Packages.Style).UiModeStyleProvider

local CanPlayEmotes = require(Utility.CanPlayEmotes)
local Constants3 = require(scriptParent.Constants)
local FFlagFixEmotesMenuAvailability = require(scriptParent.Flags.FFlagFixEmotesMenuAvailability)

local EmotesMenu = require(Components.EmotesMenu)
local EmotesMenuReducer = require(Reducers.EmotesMenuReducer)

local OpenMenu = require(Thunks.OpenMenu)
local HideMenu = require(Actions.HideMenu)

local EmotesChanged = require(Actions.EmotesChanged)
local EquippedEmotesChanged = require(Actions.EquippedEmotesChanged)
local NumberEmotesLoadedChanged = require(Actions.NumberEmotesLoadedChanged)
local SetGuiInset = require(Actions.SetGuiInset)
local SetLayout = require(Actions.SetLayout)
local SetLocale = require(Actions.SetLocale)

local bool1 = game:DefineFastFlag("EmotesStayOpenWithChat", false)

local tbl1 = {}
tbl1.__index = tbl1

local function isClient(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return RunService:IsClient() and not (RunService:IsEdit() or RunService:IsRunMode())
end

function tbl1:isOpen()
    return self.store:getState().displayOptions.menuVisible
end

function tbl1:isEmotesLoaded(): boolean
    return self.store:getState().emotesPage.numberEmotesLoaded > 0
end

function tbl1:open()
    self.store:dispatch(OpenMenu())
end

function tbl1:close()
    self.store:dispatch(HideMenu())
end

function tbl1:setTopBarEnabled(topBarEnabled)
    self.topBarEnabled = topBarEnabled

    local coreGuiEnabled = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu)
    if topBarEnabled and coreGuiEnabled and self.canPlayEmotes then
        self:_mount()
        return
    end
    self:_unmount()
end

function tbl1:_connectCoreGuiListeners()
    if FFlagEnableNewBackpack then
        Features.onVisibilityChanged(Features.FeatureName.Backpack, function(arg1)
            if not arg1 then
                return
            end

            if self:isOpen() then
                self:close()
            end
        end)
    else
        BackpackScript.StateChanged.Event:Connect(function(arg1)
            if not arg1 then
                return
            end

            if self:isOpen() then
                self:close()
            end
        end)
    end

    if not bool1 then
        ChatSelector.VisibilityStateChanged:connect(function(arg1)
            if not arg1 then
                return
            end

            if self:isOpen() then
                self:close()
            end
        end)
    end

    if bool1 then
        return
    end

    InExperienceAppChatModal.default.visibilitySignal.Event:Connect(function(arg1)
        if arg1 and self:isOpen() then
            self:close()
        end
    end)
end

function tbl1:_connectApiListeners()
    StarterGui.CoreGuiChangedSignal:connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
        if not self.topBarEnabled
            or not self.canPlayEmotes
            or coreGuiType ~= Enum.CoreGuiType.EmotesMenu and coreGuiType ~= Enum.CoreGuiType.All
        then
            return
        end

        if enabled then
            self:_mount()
            return
        end
        self:_unmount()
    end)

    GuiService.EmotesMenuOpenChanged:Connect(function(isOpen: boolean)
        if isOpen then
            if not self:isOpen() then
                self:open()
            end
        elseif self:isOpen() then
            self:close()
        end
    end)
end

function tbl1:_onEquippedEmotesChanged(arg1)
    self.store:dispatch(EquippedEmotesChanged(arg1))
end

function tbl1:_onEmotesChanged(arg1)
    self.store:dispatch(EmotesChanged(arg1))
end

function tbl1:_onNumberEmotesLoadedChanged(arg1)
    self.store:dispatch(NumberEmotesLoadedChanged(arg1))
    self.EmotesLoaded:Fire(arg1 > 0)
end

function tbl1:_onHumanoidDescriptionChanged(humanoidDescription)
    if self.equippedEmotesChangedConn then
        self.equippedEmotesChangedConn:Disconnect()
        self.equippedEmotesChangedConn = nil
    end

    if self.emotesChangedConn then
        self.emotesChangedConn:Disconnect()
        self.emotesChangedConn = nil
    end

    if self.numberEmotesLoadedChangedConn then
        self.numberEmotesLoadedChangedConn:Disconnect()
        self.numberEmotesLoadedChangedConn = nil
    end

    if self.humanoidDescriptionAncestryConn then
        self.humanoidDescriptionAncestryConn:Disconnect()
        self.humanoidDescriptionAncestryConn = nil
    end

    if not humanoidDescription then
        self:_onEquippedEmotesChanged({})
        self:_onEmotesChanged({})
        self:_onNumberEmotesLoadedChanged(-1)

        return
    end

    self.equippedEmotesChangedConn = humanoidDescription.EquippedEmotesChanged:Connect(function(arg1)
        self:_onEquippedEmotesChanged(arg1)
    end)
    self:_onEquippedEmotesChanged(humanoidDescription:GetEquippedEmotes())

    self.emotesChangedConn = humanoidDescription.EmotesChanged:Connect(function(arg1)
        self:_onEmotesChanged(arg1)
    end)

    self:_onEmotesChanged(humanoidDescription:GetEmotes())

    self.numberEmotesLoadedChangedConn = humanoidDescription:GetPropertyChangedSignal("NumberEmotesLoaded"):Connect(function(arg1)
        if FFlagFixEmotesMenuAvailability then
            self:_onNumberEmotesLoadedChanged(humanoidDescription.NumberEmotesLoaded)
            return
        end
        self:_onNumberEmotesLoadedChanged(arg1)
    end)

    self:_onNumberEmotesLoadedChanged(humanoidDescription.NumberEmotesLoaded)

    self.humanoidDescriptionAncestryConn = humanoidDescription.AncestryChanged:Connect(function(child: Instance, parent: Instance)
        if child == humanoidDescription and parent == nil then
            self:_onHumanoidDescriptionChanged(nil)
        end
    end)
end

function tbl1:_onHumanoidChanged(arg1)
    if self.humanoidChildAddedConn then
        self.humanoidChildAddedConn:Disconnect()
        self.humanoidChildAddedConn = nil
    end

    if self.humanoidAncestryChangedConn then
        self.humanoidAncestryChangedConn:Disconnect()
        self.humanoidAncestryChangedConn = nil
    end

    if not arg1 then
        self:_onHumanoidDescriptionChanged(nil)

        return
    end

    self.humanoidChildAddedConn = arg1.ChildAdded:Connect(function(child: Instance)
        if child:IsA("HumanoidDescription") then
            self:_onHumanoidDescriptionChanged(child)
        end
    end)

    local humanoidDescription = arg1:FindFirstChildOfClass("HumanoidDescription")
    if humanoidDescription then
        self:_onHumanoidDescriptionChanged(humanoidDescription)
    end

    self.humanoidAncestryChangedConn = arg1.AncestryChanged:Connect(function(child: Instance, parent: Instance)
        if child == arg1 and parent == nil then
            self:_onHumanoidChanged(nil)
        end
    end)
end

function tbl1:_onCharacterAdded(arg1)
    if self.characterChildAddedConn then
        self.characterChildAddedConn:Disconnect()
        self.characterChildAddedConn = nil
    end

    self.characterChildAddedConn = arg1.ChildAdded:Connect(function(child: Instance)
        if child:IsA("Humanoid") then
            self:_onHumanoidChanged(child)
        end
    end)

    local humanoid = arg1:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        self:_onHumanoidChanged(humanoid)
    end
end

function tbl1:_connectListeners()
    self:_connectCoreGuiListeners()
    self:_connectApiListeners()

    LocalPlayer.CharacterAdded:Connect(function(character: Model)
        self:_onCharacterAdded(character)
    end)

    if LocalPlayer.Character then
        self:_onCharacterAdded(LocalPlayer.Character)
    end

    LocalizationService:GetPropertyChangedSignal("RobloxLocaleId"):Connect(function()
        self.store:dispatch(SetLocale(LocalizationService.RobloxLocaleId))
    end)

    CanPlayEmotes.ChangedEvent.Event:connect(function(canPlayEmotes)
        self.canPlayEmotes = canPlayEmotes
        local coreGuiEnabled = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu)

        if canPlayEmotes and self.topBarEnabled and coreGuiEnabled then
            self:_mount()
            return
        end
        self:_unmount()
    end)

    if not FFlagTopBarSignalizeSetCores then
        return
    end

    self.disposeEffect = Signals.createEffect(function(arg1)
        local getTopBarStore = InExperienceTopBar.Stores.GetTopBarStore
        if getTopBarStore then
            self:setTopBarEnabled(getTopBarStore(arg1).getTopBarCoreGuiEnabled(arg1))
        end
    end)
end

function tbl1:_onStateChanged(arg1, arg2)
    if arg2.displayOptions.menuVisible ~= arg1.displayOptions.menuVisible then
        self.EmotesMenuToggled:Fire(arg1.displayOptions.menuVisible)

        GuiService:SetEmotesMenuOpen(arg1.displayOptions.menuVisible)
    end
end

function tbl1:_mount()
    local style = {
        themeName = ColorMode.Dark,
        fontName = Constants2.FontName.Gotham
    }

    if self.instance then
        return
    end

    local element = Roact.createElement(RoactRodux.StoreProvider, {
        store = self.store
    }, {
        StyleProvider = Roact.createElement(UiModeStyleProvider, { style = style }, { EmotesMenu = Roact.createElement(EmotesMenu) })
    })

    local element2 = Roact.createElement("Folder", { Name = "EmotesMenu" }, element)

    self.instance = Roact.mount(element2, RobloxGui, "EmotesMenu")

    self.MenuIsVisible = true
    self.MenuVisibilityChanged:Fire(true)
end

function tbl1:_unmount()
    if self.instance then
        Roact.unmount(self.instance)
        self.instance = nil

        self.MenuIsVisible = false
        self.MenuVisibilityChanged:Fire(false)
    end
end

function tbl1.new()
    local self = setmetatable({}, tbl1)

    self.canPlayEmotes = CanPlayEmotes.Value
    self.topBarEnabled = true

    self.EmotesMenuToggled = Instance.new("BindableEvent")

    self.MenuIsVisible = false

    self.MenuVisibilityChanged = Instance.new("BindableEvent")

    self.EmotesLoaded = Instance.new("BindableEvent")

    self.store = Rodux.Store.new(EmotesMenuReducer, {}, { Rodux.thunkMiddleware })

    if not isClient() then
        return self
    end

    self.store.changed:connect(function(arg1, arg2)
        self:_onStateChanged(arg1, arg2)
    end)

    self.store:dispatch(SetLocale(LocalizationService.RobloxLocaleId))

    if TenFootInterface:IsEnabled() then
        self.store:dispatch(SetLayout(Constants3.Layout.TenFoot))
    end

    local var1 = Constants.ApplyDisplayScale(Constants.TopBarHeight)
    if not RobloxGui.IgnoreGuiInset then
        self.store:dispatch(SetGuiInset(var1))
    end

    self:_mount()

    self:_connectListeners()

    return self
end

return tbl1.new()
