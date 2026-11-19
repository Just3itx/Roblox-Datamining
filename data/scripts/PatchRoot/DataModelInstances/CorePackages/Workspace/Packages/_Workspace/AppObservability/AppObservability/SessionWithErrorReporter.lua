-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local module = {}
module.__index = module

function module.new(_eventConfig, _reportingInterval: number?)
    local self = setmetatable({
        _eventConfig = _eventConfig,
        _lastReportedTimestampBySeverity = {},
        _reportingInterval = _reportingInterval or 300,
        _lastReportedEventBySeverity = {}
    }, module)

    self._lastReportedTimestampBySeverity.NO_SEVERITY = nil
    self._lastReportedEventBySeverity.NO_SEVERITY = nil

    return self
end

function module:getCurrentTimeStamp(): number
    return os.time()
end

function module:reportEvent(count: number, customFields, tagSeverity: string?)
    local currentTimeStamp = self:getCurrentTimeStamp()
    local str1 = tagSeverity or "NO_SEVERITY"

    local var1 = self._lastReportedTimestampBySeverity[str1]
    if var1 ~= nil and not (currentTimeStamp - var1 >= self._reportingInterval) then
        return
    end

    if tagSeverity ~= nil then
        if customFields == nil then
            customFields = { tag_severity = tagSeverity }
        elseif type(customFields) == "table" then
            customFields.tag_severity = tagSeverity
        end
    end

    TelemetryService:LogCounter(self._eventConfig, { customFields = customFields }, count or 1)

    self._lastReportedTimestampBySeverity[str1] = currentTimeStamp
    self._lastReportedEventBySeverity[str1] = { count = count, customFields = customFields }
end

return module
