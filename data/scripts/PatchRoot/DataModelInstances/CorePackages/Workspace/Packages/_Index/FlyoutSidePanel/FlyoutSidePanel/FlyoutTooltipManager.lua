-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local _dailyCount = game:DefineFastInt("IAFlyoutTooltipMaxShownCount", 5)
local num2 = game:DefineFastInt("IAFlyoutDailyTooltipMaxShownCount", 3)

local tbl1 = {}

tbl1.__index = tbl1

local function isSameDate(num3: number, num4: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = os.date("*t", num3)
    local var2 = os.date("*t", num4)
    return var1.year == var2.year and var1.month == var2.month and var1.day == var2.day
end

local function readStorage()
    local success, result = pcall(function(): string
        return AppStorageService:GetItem("IAFlyoutEntryPointTooltip")
    end)
    if success and result then
        if result == "FLYOUT_OPENED" then
            return 0, 0, 0
        end

        if string.find(result, ",") then
            local var1, var2, var3 = string.match(result, "(%d+),(%d+),(%d+)")
            local num3 = tonumber(var1) or 0
            local num4 = tonumber(var2) or 0
            local var4 = tonumber(var3)

            if var4 then
                return num3, num4, var4
            end
        end
    end
    return 0, 0, 0
end

function tbl1.new()
    return (setmetatable({
        _hasChecked = false,
        _dailyCount = 0,
        _totalCount = 0,
        _getTime = function(): number
            return os.time()
        end
    }, tbl1))
end

function tbl1:setTimeProvider(_getTime: (...any) -> (...any))
    self._getTime = _getTime
end

function tbl1:flyoutSidePanelOpened()
    if not (self._dailyCount < _dailyCount) then
        return
    end

    self._dailyCount = _dailyCount
    local var1 = self:_getTime()
    local str1 = string.format("%d,%d,%d", var1, self._dailyCount, self._totalCount)
    AppStorageService:SetItem("IAFlyoutEntryPointTooltip", str1)
    AppStorageService:Flush()
end

function tbl1:getTooltipCount()
    return self._totalCount
end

function tbl1:tooltipSeenTimeHelper(num3: number): boolean
    if not isSameDate(self:_getTime(), num3) then
        self._dailyCount = 0
    end

    return self._dailyCount < num2 and self._totalCount < _dailyCount
end

function tbl1:updateTooltipAppStorageValue()
    self._dailyCount += 1
    self._totalCount += 1
    local var1 = self:_getTime()
    local str1 = string.format("%d,%d,%d", var1, self._dailyCount, self._totalCount)
    AppStorageService:SetItem("IAFlyoutEntryPointTooltip", str1)
    AppStorageService:Flush()
end

function tbl1:isTooltipActive()
    if self._hasChecked then
        return false
    end
    self._hasChecked = true

    local num3, num1, _totalCount = readStorage()
    self._dailyCount = num1
    self._totalCount = _totalCount
    if self._dailyCount >= _dailyCount or self._totalCount >= _dailyCount then
        return false
    end

    if not self:tooltipSeenTimeHelper(num3) then
        return false
    end

    self:updateTooltipAppStorageValue()
    return true
end

return tbl1.new()
