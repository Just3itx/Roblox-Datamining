-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(_browserTrackerLayerData, _userLayerData, arg1, _initializeDelay, _userId: number?)
    local tbl1 = {
        _browserTrackerLoadingStatus = Enum.IXPLoadingStatus.Initialized,
        _userLoadingStatus = arg1 and Enum.IXPLoadingStatus.Initialized or Enum.IXPLoadingStatus.None,
        _userId = _userId or 0,
        _browserTrackerLayerData = _browserTrackerLayerData,
        _userLayerData = _userLayerData,
        _initializeDelay = _initializeDelay or 0.1,
        _exposureEventsFired = {}
    }

    tbl1._browserTrackerBindableEvent = Instance.new("BindableEvent")
    tbl1.OnBrowserTrackerLayerLoadingStatusChanged = tbl1._browserTrackerBindableEvent.Event

    tbl1._userBindableEvent = Instance.new("BindableEvent")
    tbl1.OnUserLayerLoadingStatusChanged = tbl1._userBindableEvent.Event

    setmetatable(tbl1, module)
    return tbl1
end

function module:_SetBrowserTrackerIXPLoadingStatus(_browserTrackerLoadingStatus)
    if self._browserTrackerLoadingStatus ~= _browserTrackerLoadingStatus then
        self._browserTrackerLoadingStatus = _browserTrackerLoadingStatus
        self._browserTrackerBindableEvent:Fire(_browserTrackerLoadingStatus)
    end
end

function module:_SetUserIXPLoadingStatus(_userLoadingStatus, _userId)
    if self._userLoadingStatus ~= _userLoadingStatus or self._userId ~= _userId then
        self._userLoadingStatus = _userLoadingStatus
        self._userId = _userId
        self._userBindableEvent:Fire(self._userLoadingStatus, self._userId)
    end
end

function module.RegisterUserLayers(_, _) end

function module:InitializeUserLayers(_userId)
    if self._userLoadingStatus == Enum.IXPLoadingStatus.Initialized and (self._userId == 0 or _userId == self._userId) then
        return
    end
    self:_SetUserIXPLoadingStatus(Enum.IXPLoadingStatus.Pending, _userId)
    spawn(function()
        wait(self._initializeDelay)
        self:_SetUserIXPLoadingStatus(Enum.IXPLoadingStatus.Initialized, _userId)
    end)
end

function module:GetBrowserTrackerLayerVariables(arg1)
    return if self._browserTrackerLoadingStatus == Enum.IXPLoadingStatus.Initialized then self._browserTrackerLayerData[arg1] else {}
end

function module:GetUserLayerVariables(arg1)
    return if self._userLoadingStatus == Enum.IXPLoadingStatus.Initialized then self._userLayerData[arg1] else {}
end

function module:ClearUserLayers()
    self._userLoadingStatus = Enum.IXPLoadingStatus.None
    self._userId = 0
    self._userBindableEvent:Fire(self._userLoadingStatus, self._userId)
end

function module:GetBrowserTrackerLayerLoadingStatus()
    return self._browserTrackerLoadingStatus
end

function module:GetUserLayerLoadingStatus()
    return self._userLoadingStatus
end

function module:GetBrowserTrackerStatusForLayer(_)
    return self._browserTrackerLoadingStatus
end

function module:GetUserStatusForLayer(_)
    return self._userLoadingStatus
end

function module:LogUserLayerExposure(arg1)
    table.insert(self._exposureEventsFired, arg1)
end

function module:LogBrowserTrackerLayerExposure(arg1)
    table.insert(self._exposureEventsFired, arg1)
end

return module
