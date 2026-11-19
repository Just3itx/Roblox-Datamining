-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal

local _Chrome = require(CorePackages.Workspace.Packages.Chrome)

local ViewportUtil = require(ChromeShared.Service.ViewportUtil)
local Constants = require(ChromeShared.Unibar.Constants)

local FFlagChromeWindowSignalConstraintsToggle = require(CorePackages.Workspace.Packages.SharedFlags).FFlagChromeWindowSignalConstraintsToggle

local function getConstrainedWindowSize(xOffset: number, yOffset: number, bool1: boolean?): UDim2
    local var1 = ViewportUtil.mobileDevice:get()
    local var2 = ViewportUtil.screenSize:get()
    local bool2 = var2.Y > var2.X

    if var1 and not (FFlagChromeWindowSignalConstraintsToggle and bool1) then
        if bool2 then
            yOffset = math.min(yOffset, Constants.MAX_HEIGHT_PORTRAIT)
            xOffset = math.min(xOffset, Constants.MAX_WIDTH_PORTRAIT)
        elseif not bool2 then
            yOffset = math.min(yOffset, Constants.MAX_HEIGHT_LANDSCAPE)
            xOffset = math.min(xOffset, Constants.MAX_WIDTH_LANDSCAPE)
        end
    end

    return UDim2.new(0, xOffset, 0, yOffset)
end

local module = {}
module.__index = module

function module.new(num1: number?, num2: number?, _isLarge: boolean?, bool1: boolean?)
    return (setmetatable({
        _state = if FFlagChromeWindowSignalConstraintsToggle then getConstrainedWindowSize(num1 or Constants.DEFAULT_WIDTH, num2 or Constants.DEFAULT_HEIGHT, bool1 or false) else getConstrainedWindowSize(num1 or Constants.DEFAULT_WIDTH, num2 or Constants.DEFAULT_HEIGHT),
        _isLarge = _isLarge or false,
        _ignoreConstraints = if FFlagChromeWindowSignalConstraintsToggle then bool1 or false else nil,
        _changeSignal = Signal.new()
    }, module))
end

function module:connect(arg1)
    return self._changeSignal:connect(arg1)
end

function module:requestSize(num1: number, num2: number)
    local uDim2 = if FFlagChromeWindowSignalConstraintsToggle then getConstrainedWindowSize(num1, num2, self._ignoreConstraints) else getConstrainedWindowSize(num1, num2)

    if self._state ~= uDim2 then
        self._state = uDim2
        self._changeSignal:fire(uDim2)
    end
end

function module:toggleIsLarge()
    local _isLarge = not self._isLarge
    self._isLarge = _isLarge
    self._changeSignal:fire(_isLarge)
end

function module:get()
    return self._state
end

function module:getIsLarge()
    return self._isLarge
end

function module:updateConstraints()
    self:requestSize(self._state.Width.Offset, self._state.Height.Offset)
end

return module
