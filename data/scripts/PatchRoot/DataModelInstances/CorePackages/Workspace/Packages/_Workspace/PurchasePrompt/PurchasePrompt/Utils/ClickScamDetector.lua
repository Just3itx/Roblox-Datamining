-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local Cryo = require(PurchasePromptParent.PurchasePromptDeps).Cryo

local module = {}
module.__index = module

function module.new(_options)
    _options = Cryo.Dictionary.join(
        { clickSpeedThreshold = 3, clickTimeWindow = 1, initialDelay = 1, buttonInput = nil },
        _options or {}
    )
    local tbl1 = {
        _inputConnection = nil,
        _clickCount = 0,
        _startTime = tick(),
        _options = _options
    }

    setmetatable(tbl1, module)

    tbl1._inputConnection = UserInputService.InputBegan:Connect(function(input: InputObject)
        tbl1:_onInput(input)
    end)

    return tbl1
end

function module:_onInput(arg1)
    local userInputType = arg1.UserInputType
    local bool1 = not (self._options.buttonInput == nil) and arg1.KeyCode == self._options.buttonInput
    local bool2 = userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch

    if bool1 or bool2 then
        self._clickCount += 1

        delay(self._options.clickTimeWindow, function()
            self._clickCount -= 1
        end)
    end
end

function module:isClickValid(): boolean
    if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCurrentPosition then
        return false
    end

    if tick() - self._startTime < self._options.initialDelay then
        return false
    end

    return self._clickCount / self._options.clickTimeWindow < self._options.clickSpeedThreshold
end

function module:destroy()
    self._inputConnection:Disconnect()
end

return module
