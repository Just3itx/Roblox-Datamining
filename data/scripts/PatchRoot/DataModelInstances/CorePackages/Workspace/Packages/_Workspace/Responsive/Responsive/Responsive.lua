-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local VRService = game:GetService("VRService")

local ResponsiveParent = script:FindFirstAncestor("Responsive").Parent

local StandardBreakpoints = require(script.Parent.CommonConfigs.StandardBreakpoints)

local InputMode = require(script.Parent.InputMode)
local Signal = require(ResponsiveParent.AppCommonLib).Signal
local FindFirstAncestorWithTag = require(script.Parent.FindFirstAncestorWithTag)

local var1 = (setmetatable({}, { __mode = "k" }))

local tbl1 = {}
tbl1.__index = tbl1

local rules = StandardBreakpoints.rules

local tbl2 = {}
tbl2.__index = tbl2

function tbl2.new(_config)
    local tbl3 = {
        _hasSizeRules = false,
        _hasInputRules = false,
        _config = _config or {},
        _currentRule = { Key = "Default" },
        _currentKey = "Default"
    }

    local bool1 = false
    local bool2 = false

    for _, value in _config do
        bool1 = bool1
            or value.minWidth ~= nil
            or value.maxWidth ~= nil
            or value.minHeight ~= nil
            or value.maxHeight ~= nil
            or value.maxRatio ~= nil
            or value.minRatio ~= nil

        bool2 = bool2 or value.preferredInput ~= nil or value.lastInput ~= nil
    end

    tbl3._hasSizeRules = bool1
    tbl3._hasInputRules = bool2

    return (setmetatable(tbl3, tbl2))
end

function tbl2:hasSizeRules()
    return self._hasSizeRules
end

function tbl2:hasInputRules()
    return self._hasInputRules
end

function tbl2:currentRule()
    return self._currentRule
end

function tbl2:currentKey()
    return self._currentKey
end

function tbl2:resolve(num1: number, num2: number, preferredInput: string, lastInput: string, spatial: boolean): boolean
    local str1 = "Default"
    local tbl3 = {}

    local num3 = num1 / num2

    for _, value in self._config do
        if (value.minWidth == nil or value.minWidth <= num1)
            and (value.maxWidth == nil or num1 <= value.maxWidth)
            and (value.minHeight == nil or value.minHeight <= num2)
            and (value.maxHeight == nil or num2 <= value.maxHeight)
            and (value.minRatio == nil or value.minRatio <= num3)
            and (value.maxRatio == nil or num3 <= value.maxRatio)
            and (value.preferredInput == nil or preferredInput == value.preferredInput)
            and (value.lastInput == nil or lastInput == value.lastInput)
            and (value.spatial == nil or spatial == value.spatial)
        then
            str1 = value.Key
            tbl3 = value
            break
        end
    end

    if str1 == self._currentKey then
        return false
    end

    self._currentKey = str1
    self._currentRule = tbl3
    return true
end

function tbl1.new()
    local tbl3 = {
        _layerCollectorSizeConnection = nil,
        _inputModeConnection = nil,
        _vrEnabledConnection = nil,
        _vrEnabled = VRService.VREnabled,
        _changed = Signal.new(),
        _absoluteSize = Vector2.zero,
        _hasInputRules = false,
        _hasSizeRules = false,
        _refCount = 1,
        _configResolvers = {
            default = {}
        }
    }
    local self = setmetatable(tbl3, tbl1)

    tbl3._inputModeConnection = InputMode.connect(function()
        if tbl3._hasInputRules then
            self:resolve()
        end
    end)

    tbl3._vrEnabledConnection = VRService:GetPropertyChangedSignal("VREnabled"):Connect(function()
        tbl3._vrEnabled = VRService.VREnabled
        self:resolve()
    end)

    return self
end

function tbl1:incRef()
    self._refCount += 1
end

function tbl1:destroy()
    if self._refCount > 1 then
        self._refCount -= 1
        return
    end

    if self._layerCollectorSizeConnection then
        self._layerCollectorSizeConnection:Disconnect()
        self._layerCollectorSizeConnection = nil
    end
    if self._inputModeConnection then
        self._inputModeConnection:disconnect()
        self._inputModeConnection = nil
    end
    if self._vrEnabledConnection then
        self._vrEnabledConnection:Disconnect()
        self._vrEnabledConnection = nil
    end
    self._changed = nil
    for value, value2 in var1 do
        if value2 == self then
            var1[value] = nil
        end
    end
end

function tbl1:connect(arg1)
    if self._changed == nil then
        error("Connecting to dead signal!")
    end
    return self._changed:connect(arg1)
end

function tbl1:currentRule(str1: string?)
    return self._configResolvers[str1 or "default"]:currentRule()
end

function tbl1:currentKey(str1: string?)
    return self._configResolvers[str1 or "default"]:currentKey()
end

function tbl1:updateAbsoluteSize(arg1)
    local absoluteSize = arg1.AbsoluteSize

    if arg1:IsA("LayerCollector") then
        local success, result = pcall(function()
            return arg1.IgnoreGuiInset
        end)
        if success and result then
            local vector2, _vector2 = GuiService:GetGuiInset()
            absoluteSize += vector2
        end
    end

    if absoluteSize.X == self._absoluteSize.X and absoluteSize.Y == self._absoluteSize.Y then
        return
    end

    self._absoluteSize = absoluteSize
    if self._hasSizeRules then
        self:resolve()
    end
end

function tbl1:resolve()
    if not self._configResolvers then
        return
    end

    local _absoluteSizeX = self._absoluteSize.X or 1
    local _absoluteSizeY = self._absoluteSize.Y or 1
    local var2 = InputMode.preferred()
    local var3 = InputMode.last()
    local _vrEnabled = self._vrEnabled

    local bool1 = false
    for _, _configResolver in self._configResolvers do
        if _configResolver:resolve(_absoluteSizeX, _absoluteSizeY, var2, var3, _vrEnabled) then
            bool1 = true
        end
    end

    if bool1 then
        self._changed:fire()
    end
end

function is_array(arg1): boolean
    return type(arg1) == "table" and arg1[1] ~= nil
end

function tbl1:setConfig(default)
    default = is_array(default) and { default = default } or default

    local bool1 = false
    local bool2 = false
    local _configResolvers = ({})

    if default then
        for value, value2 in default do
            _configResolvers[value] = tbl2.new(value2)
            bool1 = bool1 or _configResolvers[value]:hasSizeRules()
            bool2 = bool2 or _configResolvers[value]:hasInputRules()
        end
    end

    self._hasInputRules = bool2
    self._hasSizeRules = bool1
    self._configResolvers = _configResolvers
    self:resolve()
end

function tbl1:setLocalInstance(arg1, arg2)
    if typeof(arg1) ~= "Instance" then
        error("setLocalInstance arg1 expects Instance")
        return
    end

    local var2 = if typeof(arg2) == "string" then FindFirstAncestorWithTag(arg1, arg2) or arg1 elseif typeof(arg2) == "Instance" then arg2 else arg1:FindFirstAncestorWhichIsA("LayerCollector")

    if var2 == nil then
        var2 = arg1
    end

    if self._layerCollectorSizeConnection then
        self._layerCollectorSizeConnection:Disconnect()
        self._layerCollectorSizeConnection = nil
    end

    if var2 then
        self._layerCollectorSizeConnection = var2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            self:updateAbsoluteSize(var2)
        end)
        self:updateAbsoluteSize(var2)
    end
end

return {
    DefaultKey = "Default",
    bindContainer = function(arg1, tbl3)
        local var2 = var1[arg1]
        local bool1 = tbl3 == nil
        if bool1 and var2 then
            var2:incRef()
            return var2
        end

        local var3 = tbl1.new()
        var3:setLocalInstance(arg1, arg1)
        var3:setConfig(tbl3 or rules)

        if bool1 then
            var1[arg1] = var3
        end

        return var3
    end
}
