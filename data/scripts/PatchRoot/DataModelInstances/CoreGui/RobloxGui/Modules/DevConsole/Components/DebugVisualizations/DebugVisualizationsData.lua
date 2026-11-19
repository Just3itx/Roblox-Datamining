-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Signal = require(script.Parent.Parent.Parent.Signal)

local ChartHeaderNames = require(script.Parent.Parent.Parent.Constants).DebugVisualizationsFormatting.ChartHeaderNames

local DebugVisualizationsStaticContent = require(script.Parent.DebugVisualizationsStaticContent)
local bool1 = game:DefineFastFlag("SlimDevConsole2", false)
local bool2 = game:DefineFastFlag("SlimTintContextFilter", false)
local bool3 = game:DefineFastFlag("SlimTintModeTelemetry", false)
local DebugVisualizationsTelemetry = require(script.Parent.DebugVisualizationsTelemetry)

local tbl1 = {}
tbl1[ChartHeaderNames[1]] = function(arg1, arg2): boolean
    return arg1.name < arg2.name
end

tbl1[ChartHeaderNames[2]] = function(arg1, arg2)
    if arg1.settingInfo.Value == arg2.settingInfo.Value then
        return arg1.name < arg2.name
    end

    return arg1.settingInfo.Value
end

tbl1[ChartHeaderNames[3]] = function(arg1, arg2): boolean
    if arg1.settingInfo.Type == arg2.settingInfo.Type then
        return arg1.name < arg2.name
    end

    return arg1.settingInfo.Type < arg2.settingInfo.Type
end

tbl1[ChartHeaderNames[4]] = function(arg1, arg2): boolean
    return arg1.name < arg2.name
end

local module = {}
module.__index = module

function module.new()
    local result = {}
    setmetatable(result, module)

    result._visualizationsUpdated = Signal.new()
    result._visualizationsData = {}
    result._visualizationCounter = 0
    result._sortedVisualizationData = {}
    result._sortType = ChartHeaderNames[3]
    result._isRunning = false
    return result
end

function module:setSortType(_sortType)
    if tbl1[_sortType] then
        self._sortType = _sortType
        table.sort(self._sortedVisualizationData, tbl1[self._sortType])
        self._visualizationsUpdated:Fire(self._sortedVisualizationData)
        return
    end
    error(string.format("attempted to pass invalid sortType: %s", tostring(_sortType)), 2)
end

function module:getSortType()
    return self._sortType
end

function module:Signal()
    return self._visualizationsUpdated
end

function module:getCurrentData()
    return self._sortedVisualizationData
end

function module:updateDebugVisualizationDataEntry(name, arg1)
    if arg1 == nil then
        self._visualizationsData[name] = nil
        for k, value in pairs(self._sortedVisualizationData) do
            if value.name == name then
                table.remove(self._sortedVisualizationData, k)
                return
            end
        end

        return
    end

    if self._visualizationsData[name] then
        self._visualizationsData[name] = arg1
        return
    end

    self._visualizationCounter += 1
    self._visualizationsData[name] = arg1
    table.insert(self._sortedVisualizationData, {
        name = name,
        settingInfo = self._visualizationsData[name],
        valueChangeCallback = function(arg2, arg3)
            self:_toggleValue(arg2, arg3)
        end,
        counter = self._visualizationCounter
    })
end

function module:isRunning()
    return self._isRunning
end

function module:_toggleValue(arg1, arg2)
    if bool1 then
        local var1 = self._visualizationsData[arg1]
        if var1 and var1.Kind == "Dropdown" then
            local var2 = settings():GetService(var1.Service)
            var2[var1.Setter](var2, arg2)
            var1.Value = arg2
            if bool3 and arg1 == "SlimTintMode" then
                DebugVisualizationsTelemetry.logSlimTintModeSelected(arg2)
            end
            table.sort(self._sortedVisualizationData, tbl1[self._sortType])
            self._visualizationsUpdated:Fire(self._sortedVisualizationData)
            return
        end
    end

    local physics = settings().Physics
    if physics[arg1] == nil then
        return
    end

    if arg2 and self._visualizationsData[arg1].Type == "Box" then
        for _, value in pairs(self._visualizationsData) do
            if value.Type == "Box" and physics[value.Name] ~= nil then
                physics[value.Name] = false
                self._visualizationsData[value.Name].Value = false
            end
        end
    end

    physics[arg1] = arg2
    self._visualizationsData[arg1].Value = arg2

    table.sort(self._sortedVisualizationData, tbl1[self._sortType])
    self._visualizationsUpdated:Fire(self._sortedVisualizationData)
end

function _constructInfo(arg1, arg2)
    local var1 = nil
    local var2 = nil
    local enumItems = nil

    if bool1 and arg2.kind == "Dropdown" then
        local success, result = pcall(function()
            return settings():GetService(arg2.service)
        end)
        if success and result then
            var1 = result[arg2.getter](result)
            if bool2 then
                local availableTintModes = result:GetAvailableTintModes(Enum.SlimViewContext.Player, true)
                enumItems = {}
                var2 = {}
                for i, value in ipairs(availableTintModes) do
                    enumItems[i] = Enum.SlimTintMode[value]
                    var2[i] = value
                end
            else
                enumItems = var1.EnumType:GetEnumItems()
                var2 = {}
                for i, enumItem in ipairs(enumItems) do
                    var2[i] = enumItem.Name
                end
            end
        end
    else
        local physics = settings().Physics

        if physics[arg1] == nil then
            var1 = false
        else
            var1 = physics[arg1]
        end
    end

    local str1 = ""
    for i, tag in ipairs(arg2.tags) do
        str1 = (str1 .. tag) .. (if i == #arg2.tags then "" else ", ")
    end

    local tbl2 = {
        Name = arg2.name,
        Value = var1,
        Type = arg2.type,
        Kind = if bool1 then arg2.kind else nil,
        Tags = arg2.tags,
        Tagstring = str1,
        Description = arg2.description,
        LearnMoreUrl = if bool1 then arg2.learnMoreUrl else nil
    }

    if bool1 and arg2.kind == "Dropdown" then
        tbl2.DropDownList = var2
        tbl2.EnumItems = enumItems
        tbl2.Service = arg2.service
        tbl2.Setter = arg2.setter
    end

    return tbl2
end

function module:start()
    for k, value in pairs(DebugVisualizationsStaticContent) do
        self:updateDebugVisualizationDataEntry(k, _constructInfo(k, value))
    end
    table.sort(self._sortedVisualizationData, tbl1[self._sortType])
    self._isRunning = true
end

function module:stop()
    self._isRunning = false
end

return module
