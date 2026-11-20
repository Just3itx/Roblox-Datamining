-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local Signal = require(MomentsCommon.Utils.Signal)

local LocalPlayer = Players.LocalPlayer

local bool1 = false
local signal = Signal.new()
local screenGui = nil
local screenGui2 = nil
local tbl1 = { left = 0, top = 0, right = 0, bottom = 0 }

function diffInsets(arg1, arg2): boolean
    return arg1.top ~= arg2.top or arg1.bottom ~= arg2.bottom or arg1.left ~= arg2.left or arg1.right ~= arg2.right
end

function getHardwareSafeAreaInsets()
    local absolutePosition = screenGui.AbsolutePosition
    local absolutePosition2 = screenGui2.AbsolutePosition

    local var1 = absolutePosition2 - absolutePosition
    local var2 = absolutePosition + screenGui.AbsoluteSize - (absolutePosition2 + screenGui2.AbsoluteSize)

    return {
        left = math.round(var1.X),
        top = math.round(var1.Y),
        right = math.round(var2.X),
        bottom = math.round(var2.Y)
    }
end

local var1 = nil
function handleSizeChange()
    local hardwareSafeAreaInsets = getHardwareSafeAreaInsets()
    if not diffInsets(hardwareSafeAreaInsets, tbl1) then
        return
    end

    tbl1 = hardwareSafeAreaInsets
    if var1 then
        task.cancel(var1)
    end
    var1 = task.defer(function()
        var1 = nil
        signal:fire(hardwareSafeAreaInsets)
    end)
end

function init()
    if bool1 then
        return
    end

    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "_FullscreenTestGui"
        screenGui.Parent = LocalPlayer.PlayerGui
        screenGui.ScreenInsets = Enum.ScreenInsets.None
        screenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(handleSizeChange)
        screenGui:GetPropertyChangedSignal("AbsolutePosition"):Connect(handleSizeChange)
    end

    if not screenGui2 then
        screenGui2 = Instance.new("ScreenGui")
        screenGui2.Name = "_DeviceTestGui"
        screenGui2.Parent = LocalPlayer.PlayerGui
        screenGui2.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
        screenGui2:GetPropertyChangedSignal("AbsoluteSize"):Connect(handleSizeChange)
        screenGui2:GetPropertyChangedSignal("AbsolutePosition"):Connect(handleSizeChange)
    end

    handleSizeChange()
    bool1 = true
end

return {
    connect = function(_, arg1)
        init()
        return signal:connect(arg1)
    end,
    deviceInsets = function()
        init()
        return tbl1
    end,
    diffInsets = diffInsets,
    fullscreenGui = function()
        init()
        return screenGui
    end
}
