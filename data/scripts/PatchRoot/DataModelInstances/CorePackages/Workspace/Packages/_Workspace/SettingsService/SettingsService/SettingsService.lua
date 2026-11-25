-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local LocalizationService = game:GetService("LocalizationService")

local Signals = require(scriptParentParent.Signals)

local _Types = require(scriptParent.Types)
local SettingEnum = require(scriptParent.SettingEnum)
local ValueChangedSignal = require(scriptParent.ValueChangedSignal)
local Localization = require(scriptParentParent.InExperienceLocales).Localization

local module = ({})
module.__index = module

function module.new()
    local tbl1 = {}
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    tbl1._localization = Localization.new(robloxLocaleId)
    tbl1._settings = {}
    tbl1._signals = {}
    tbl1._disposables = {}
    return (setmetatable(tbl1, module))
end

function module:registerSetting(arg1)
    self._disposables[arg1.id] = {}
    if arg1.alreadyLocalized == nil then
        arg1.alreadyLocalized = true
    end
    local var1, setAvailability = Signals.createSignal(true)
    if arg1.onAvailabilityChanged then
        table.insert(self._disposables[arg1.id], Signals.createEffect(function(arg2)
            local var3 = var1(arg2)
            arg1.onAvailabilityChanged(var3)
        end))
    end

    if arg1.initialAvailability ~= nil then
        setAvailability(arg1.initialAvailability)
    end
    local var3, setVisibility = Signals.createSignal(true)
    if arg1.onVisibilityChanged then
        table.insert(self._disposables[arg1.id], Signals.createEffect(function(arg2)
            local var5 = var3(arg2)
            arg1.onVisibilityChanged(var5)
        end))
    end

    if arg1.initialVisibility ~= nil then
        setVisibility(arg1.initialVisibility)
    end
    self._signals[arg1.id] = {
        availability = var1,
        setAvailability = setAvailability,
        visibility = var3,
        setVisibility = setVisibility
    }
    arg1.subscribeAvailable = var1
    arg1.subscribeVisible = var3
    if not arg1.alreadyLocalized then
        arg1.label = self:_updateLocalization(arg1.label)
        arg1.description = self:_updateLocalization(arg1.description)
    end

    local var5

    if arg1.field_type == SettingEnum.Selector then
        var5 = self:_registerSelector(arg1)
    elseif arg1.field_type == SettingEnum.Slider then
        var5 = self:_registerSlider(arg1)
    elseif arg1.field_type == SettingEnum.Dropdown then
        var5 = self:_registerDropdown(arg1)
    elseif arg1.field_type == SettingEnum.TextButton then
        var5 = self:_registerTextButton(arg1)
    elseif arg1.field_type == SettingEnum.Toggle then
        var5 = self:_registerToggle(arg1)
    else
        error(tostring(arg1.field_type) .. " is not a valid field_type")
        var5 = arg1
    end

    self._settings[var5.id] = var5
    return var5
end

function module:setting(arg1)
    if not self._settings[arg1] then
        error("No setting registered with id: " .. arg1)
    end
    return self._settings[arg1]
end

function module:updateSetting(arg1, tbl1)
    assert(typeof(self:setting(arg1)) == "table", "No setting registered with id: " .. arg1)
    if tbl1.available ~= nil then
        self._signals[arg1].setAvailability(tbl1.available)
    end
    if tbl1.visible ~= nil then
        self._signals[arg1].setVisibility(tbl1.visible)
    end
end

function module:disconnect()
    for _, value in self._disposables do
        for _, value2 in value do
            value2()
        end
    end
    self._disposables = {}
    self._signals = {}
    self._settings = {}
end

function module:_updateLocalization(arg1)
    if arg1 == nil then
        return nil
    end
    local _localization = self._localization
    if typeof(arg1) == "string" then
        return _localization:Format(arg1)
    end
    return _localization:Format(arg1.key, arg1.args)
end

function module:_registerToggle<T>(arg1: T): T
    return arg1
end

function module:_registerOptions<T>(bool1: boolean, tbl1): {T}
    for _, value in ipairs(tbl1) do
        if not bool1 then
            value.text = self:_updateLocalization(value.text)
        end
        local var1 = value.initialAvailability == nil or value.initialAvailability

        if value.onAvailabilityChanged then
            value.onAvailabilityChanged(var1)
        end
    end
    return tbl1
end

function module:_registerSlider(arg1)
    if not arg1.alreadyLocalized then
        arg1.sliderLeftLabel = self:_updateLocalization(arg1.sliderLeftLabel)
        arg1.sliderRightLabel = self:_updateLocalization(arg1.sliderRightLabel)
    end
    return arg1
end

function module:_registerTextButton(arg1)
    if not arg1.alreadyLocalized then
        arg1.text = self:_updateLocalization(arg1.text)
    end
    return arg1
end

function module:_registerDropdown(arg1)
    if not arg1.alreadyLocalized then
        arg1.placeholder = self:_updateLocalization(arg1.placeholder)
    end
    arg1.onMenuOpenChange = arg1.onMenuOpenChange or ValueChangedSignal.new(nil)
    arg1.options = self:_registerOptions(arg1.alreadyLocalized, arg1.options)
    return arg1
end

function module:_registerSelector(arg1)
    if not arg1.alreadyLocalized then
        arg1.placeholder = self:_updateLocalization(arg1.placeholder)
    end
    arg1.options = self:_registerOptions(arg1.alreadyLocalized, arg1.options)
    return arg1
end

return module
