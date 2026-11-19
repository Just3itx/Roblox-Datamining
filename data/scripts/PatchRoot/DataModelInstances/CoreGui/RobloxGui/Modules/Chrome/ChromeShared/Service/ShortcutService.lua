-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")
local ChromeUtils = require(ChromeShared.Service.ChromeUtils)

local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local LocalizationService = game:GetService("LocalizationService")
local var1 = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization.new(LocalizationService.RobloxLocaleId)

local AppCommonLib = require(CorePackages.Workspace.Packages.AppCommonLib)

local _Chrome = require(CorePackages.Workspace.Packages.Chrome)

local Signal = AppCommonLib.Signal
local AvailabilitySignal = ChromeUtils.AvailabilitySignal
local AvailabilitySignalState = ChromeUtils.AvailabilitySignalState

local FFlagGamepadIconSupportCheck = require(CorePackages.Workspace.Packages.SharedFlags).FFlagGamepadIconSupportCheck

local module = ({})
module.__index = module

local function _handleShortcutEvent(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(actionName: string, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end

        for k, _shortcut in tbl1._shortcuts do
            if _shortcut.actionName and _shortcut.actionName == actionName then
                return tbl1:activateShortcut(k) or Enum.ContextActionResult.Sink
            end
        end
        return Enum.ContextActionResult.Pass
    end
end

function module.new()
    return (setmetatable({
        _shortcuts = {},
        _shortcutBarList = {},
        _shortcutBarHiddenOverrides = {},
        onShortcutBarChanged = Signal.new(),
        _boundShortcuts = {}
    }, module))
end

function module:registerShortcut(arg1)
    if self._shortcuts[arg1.id] then
        warn(string.format("shortcut " .. arg1.id .. " already registered", debug.traceback()))
    end

    if arg1.label then
        arg1.label = var1:Format(arg1.label)
    end
    arg1.displayPriority = arg1.displayPriority or 0
    if arg1.availability == nil then
        arg1.availability = AvailabilitySignal.new(AvailabilitySignalState.Available)
    end

    arg1.availability:connect(function()
        self:shortcutChanged(arg1)
    end)

    arg1.icon = UserInputService:GetImageForKeyCode(arg1.keyCode)

    self._shortcuts[arg1.id] = arg1
end

function module:activateShortcut(arg1)
    if self._shortcuts[arg1] then
        local _shortcut = self._shortcuts[arg1]

        if _shortcut.activated then
            return _shortcut.activated()
        end
    end
    return nil
end

function module:shortcutChanged(_)
    self:updateShortcutBar(self:getCurrentShortcutBar())
end

function module:updateShortcutBar(_currentShortcutBar)
    self:_unbindAllShortcuts()
    self._currentShortcutBar = _currentShortcutBar

    if self._shortcutBarHidden then
        self.onShortcutBarChanged:fire(nil)
        return
    end
    self.onShortcutBarChanged:fire(_currentShortcutBar)

    if _currentShortcutBar and self._shortcutBarList[_currentShortcutBar] then
        self:_bindShortcutBar(_currentShortcutBar)
    end
end

function module:configureShortcutBar(arg1, arg2)
    self._shortcutBarList[arg1] = arg2
end

function module.setShortcutBar(arg1, _currentShortcutBar)
    if arg1._currentShortcutBar ~= _currentShortcutBar then
        arg1:updateShortcutBar(_currentShortcutBar)
    end
end

function module:setHideShortcutBar(arg1, bool1: boolean?)
    if self._shortcutBarHiddenOverrides[arg1] == bool1 then
        return
    end

    if bool1 then
        self._shortcutBarHiddenOverrides[arg1] = bool1
    else
        self._shortcutBarHiddenOverrides[arg1] = nil
    end

    local bool2 = false
    for _, value in pairs(self._shortcutBarHiddenOverrides) do
        if value then
            bool2 = true
            break
        end
    end

    self._shortcutBarHidden = bool2
    self:updateShortcutBar(self._currentShortcutBar)
end

function module.getHideShortcutBar(arg1)
    return arg1._shortcutBarHidden
end

function module:getShortcut(arg1)
    return self._shortcuts[arg1]
end

function module:getShortcutsFromBar(arg1, _)
    if not arg1 then
        return {}
    end
    local shortcutsFromBar = {}

    for _, value in self._shortcutBarList[arg1] do
        if not self._shortcuts[value] then
            warn(string.format("shortcut " .. value .. " not found", debug.traceback()))
        else
            local _shortcut = self._shortcuts[value]

            if _shortcut.availability:get() ~= AvailabilitySignalState.Unavailable
                and (not FFlagGamepadIconSupportCheck
                    or UserInputService:GamepadSupports(UserInputService:GetLastInputType(), _shortcut.keyCode))
            then
                table.insert(shortcutsFromBar, _shortcut)
            end
        end
    end

    return shortcutsFromBar
end

function module:getCurrentShortcutBar()
    return self._currentShortcutBar
end

function module:_bindShortcutBar(arg1)
    for _, value in self._shortcutBarList[arg1] do
        local _shortcut = self._shortcuts[value]
        if not (_shortcut and _shortcut.actionName) then
            continue
        end

        self:_unbindShortcut(value)
        if _shortcut.availability:get() ~= AvailabilitySignalState.Unavailable then
            self:_bindShortcut(value)
        end
    end
end

function module:_unbindShortcutBar(arg1)
    if not arg1 then
        return
    end

    for _, value in self._shortcutBarList[arg1] do
        local _shortcut = self._shortcuts[value]
        if _shortcut and _shortcut.actionName then
            self:_unbindShortcut(value)
        end
    end
end

function module:_bindShortcut(arg1)
    local _shortcut = self._shortcuts[arg1]
    if _shortcut and _shortcut.actionName then
        local functionToBind = _handleShortcutEvent(self)
        ContextActionService:BindCoreAction(_shortcut.actionName, functionToBind, false, _shortcut.keyCode)
        self._boundShortcuts[_shortcut.actionName] = true
    end
end

function module:_unbindShortcut(arg1)
    local _shortcut = self._shortcuts[arg1]
    if _shortcut and _shortcut.actionName then
        ContextActionService:UnbindCoreAction(_shortcut.actionName)
        self._boundShortcuts[_shortcut.actionName] = false
    end
end

function module:_unbindAllShortcuts()
    for k, _boundShortcut in self._boundShortcuts do
        if _boundShortcut then
            ContextActionService:UnbindCoreAction(k)
            self._boundShortcuts[k] = false
        end
    end
end

return module
