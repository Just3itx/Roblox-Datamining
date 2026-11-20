-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(_enabler, _slider)
    return (setmetatable({ _enabler = _enabler, _slider = _slider, _isShowing = false, _showCount = 0 }, module))
end

function module:isShowing()
    return self._isShowing
end

function module:show(savedQualitySetting)
    local bool1 = savedQualitySetting == Enum.SavedQualitySetting.Automatic
    local num1 = if bool1 then 1 else 2
    local bool2 = self._enabler:GetSelectedIndex() ~= num1
    local bool3 = not bool1 and self._slider:GetValue() ~= savedQualitySetting.Value

    if not (bool2 or bool3) then
        return
    end
    self._isShowing = true
    self._showCount += 1
    local _showCount = self._showCount
    if bool2 then
        self._enabler:SetSelectionIndex(num1)
    end
    if bool3 then
        self._slider:SetValue(savedQualitySetting.Value)
    end

    task.defer(function()
        if self._showCount == _showCount then
            self._isShowing = false
        end
    end)
end

return module
