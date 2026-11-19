-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local StarterGui = game:GetService("StarterGui")

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal

local _Chrome = require(CorePackages.Workspace.Packages.Chrome)

local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls

local AvailabilitySignalState = { Unavailable = 0, Loading = 1, Available = 2, Pinned = 3 }

local AvailabilitySignal = {}
AvailabilitySignal.__index = AvailabilitySignal

function AvailabilitySignal.new(_state: number)
    return (setmetatable({
        _state = _state or AvailabilitySignalState.Unavailable,
        _forceUnavailable = not FFlagEnableConsoleExpControls and nil,
        _changeSignal = Signal.new()
    }, AvailabilitySignal))
end

function AvailabilitySignal:connect(arg1)
    return self._changeSignal:connect(arg1)
end

function AvailabilitySignal:set(_state: number)
    if self._state == _state then
        return
    end

    self._state = _state
    if not (FFlagEnableConsoleExpControls and self._forceUnavailable) then
        self._changeSignal:fire(_state)
    end
end

function AvailabilitySignal:get()
    return if FFlagEnableConsoleExpControls and self._forceUnavailable then AvailabilitySignalState.Unavailable else self._state
end

function AvailabilitySignal.available(arg1)
    arg1:set(AvailabilitySignalState.Available)
end

function AvailabilitySignal.loading(arg1)
    arg1:set(AvailabilitySignalState.Loading)
end

function AvailabilitySignal.unavailable(arg1)
    arg1:set(AvailabilitySignalState.Unavailable)
end

function AvailabilitySignal.pinned(arg1)
    arg1:set(AvailabilitySignalState.Pinned)
end

function AvailabilitySignal:forceUnavailable()
    if not FFlagEnableConsoleExpControls or self._forceUnavailable then
        return
    end

    self._forceUnavailable = true

    if self._state ~= AvailabilitySignalState.Unavailable then
        self._changeSignal:fire(AvailabilitySignalState.Unavailable)
    end
end

function AvailabilitySignal:unforceUnavailable()
    if not FFlagEnableConsoleExpControls or not self._forceUnavailable then
        return
    end

    self._forceUnavailable = false

    if self._state ~= AvailabilitySignalState.Unavailable then
        self._changeSignal:fire(self._state)
    end
end

local NotifySignal = {}
NotifySignal.__index = NotifySignal

function NotifySignal.new(_excludeFromTotalCounts: boolean?)
    return (setmetatable({
        _value = { type = "empty", value = nil },
        _changeSignal = Signal.new(),
        _excludeFromTotalCounts = _excludeFromTotalCounts or false
    }, NotifySignal))
end

function NotifySignal:setExcludeFromTotalCounts(_excludeFromTotalCounts: boolean)
    self._excludeFromTotalCounts = _excludeFromTotalCounts
end

function NotifySignal:excludeFromTotalCounts()
    return self._excludeFromTotalCounts
end

function NotifySignal:connect(func1: (...any) -> (...any))
    return self._changeSignal:connect(func1)
end

function NotifySignal:get()
    return self._value
end

function NotifySignal:clear()
    if not self._value or self._value.type == "empty" then
        return
    end

    self._value = { type = "empty", value = nil }
    self._changeSignal:fire(self._value)
end

function NotifySignal:fireCount(value: number)
    local _value = { type = "count", value = value }
    if self._value ~= _value then
        self._value = _value
        self._changeSignal:fire(self._value)
    end
end

function NotifySignal:isEmpty()
    return self._value and self._value.type == "empty"
end

local ObservableValue = {}
ObservableValue.__index = ObservableValue

function ObservableValue.new(_value)
    return (setmetatable({ _value = _value, _changeSignal = Signal.new() }, ObservableValue))
end

function ObservableValue:get()
    return self._value
end

function ObservableValue:setMomentary(_value, num1: number, arg1)
    if self._value ~= _value then
        self._value = _value
        self._changeSignal:fire(_value)
    end

    local _momentaryClearThread = self._momentaryClearThread
    if _momentaryClearThread then
        task.cancel(_momentaryClearThread)
    end

    self._momentaryClearThread = task.delay(num1, function()
        self._momentaryClearThread = nil
        self.set(self, arg1)
    end)
end

function ObservableValue:set(_value)
    local _momentaryClearThread = self._momentaryClearThread
    if _momentaryClearThread then
        task.cancel(_momentaryClearThread)
        self._momentaryClearThread = nil
    end

    if self._value ~= _value then
        self._value = _value
        self._changeSignal:fire(_value)
    end
end

function ObservableValue:signal()
    return self._changeSignal
end

function ObservableValue:connect(callback, arg1)
    local connection = self._changeSignal:connect(callback)
    if arg1 == true then
        callback(self._value)
    end
    return connection
end

local MappedSignal = {}
MappedSignal.__index = MappedSignal
function MappedSignal.new(_signal, _fetchMapFunction, _eventReceiver: ((...any) -> (...any))?)
    if not _signal then
        error("No signal provided to MappedSignal")
    end
    if not _fetchMapFunction then
        error("No fetchMapFunction provided to MappedSignal")
    end
    return (setmetatable(
        {
            _signal = _signal,
            _fetchMapFunction = _fetchMapFunction,
            _eventReceiver = _eventReceiver
        },
        MappedSignal
    ))
end

function MappedSignal:connect(callback)
    if not self._signal then
        warn("MappedSignal: Missing signal")
        return function() end
    end

    local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
        if self._eventReceiver then
            self._eventReceiver()
        end
        callback(self._fetchMapFunction())
    end
    local connection = self._signal:connect(func1)
    func1()
    return connection
end

function MappedSignal:get()
    return self._fetchMapFunction()
end

function setCoreGuiAvailability(tbl6, coreGuiType: Enum.CoreGuiType, callback: ((...any) -> (...any))?)
    local function updateAvailable() -- Luacid: Inlined by compiler; 1 call site recovered
        local coreGuiEnabled = StarterGui:GetCoreGuiEnabled(coreGuiType)
        if callback then
            callback(coreGuiEnabled)
        elseif coreGuiEnabled then
            tbl6.availability:available()
        else
            tbl6.availability:unavailable()
        end
    end

    local connection = StarterGui.CoreGuiChangedSignal:Connect(updateAvailable)
    updateAvailable()
    return connection
end

return {
    MappedSignal = MappedSignal,
    AvailabilitySignal = AvailabilitySignal,
    AvailabilitySignalState = AvailabilitySignalState,
    NotifySignal = NotifySignal,
    ObservableValue = ObservableValue,
    setCoreGuiAvailability = setCoreGuiAvailability
}
