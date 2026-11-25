-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent

local Signal = require(scriptParentParent.AppCommonLib).Signal

local tbl1 = {
    [Enum.Platform.XBoxOne] = true,
    [Enum.Platform.XBox360] = true,
    [Enum.Platform.WiiU] = true,
    [Enum.Platform.PS3] = true,
    [Enum.Platform.PS4] = true,
    [Enum.Platform.PS5] = true,
    [Enum.Platform.Ouya] = true,
    [Enum.Platform.AndroidTV] = true
}

local bool1 = false
local signal = Signal.new()
local screenGui = nil
local screenGui2 = nil
local tbl2 = { left = 0, top = 0, right = 0, bottom = 0 }

function diffInsets(arg1, arg2): boolean
    return arg1.top ~= arg2.top or arg1.bottom ~= arg2.bottom or arg1.left ~= arg2.left or arg1.right ~= arg2.right
end

local var1 = nil
function handleSizeChange()
    local hardwareSafeAreaInsets = getHardwareSafeAreaInsets()
    if not diffInsets(hardwareSafeAreaInsets, tbl2) then
        return
    end

    tbl2 = hardwareSafeAreaInsets
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
        screenGui.Parent = CoreGui
        screenGui.ScreenInsets = Enum.ScreenInsets.None
        screenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(handleSizeChange)
        screenGui:GetPropertyChangedSignal("AbsolutePosition"):Connect(handleSizeChange)
    end

    if not screenGui2 then
        screenGui2 = Instance.new("ScreenGui")
        screenGui2.Name = "_DeviceTestGui"
        screenGui2.Parent = CoreGui
        screenGui2.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
        screenGui2:GetPropertyChangedSignal("AbsoluteSize"):Connect(handleSizeChange)
        screenGui2:GetPropertyChangedSignal("AbsolutePosition"):Connect(handleSizeChange)
    end

    handleSizeChange()
    bool1 = true
end

function getHardwareSafeAreaInsets()
    local absolutePosition = screenGui.AbsolutePosition
    local absoluteSize = screenGui.AbsoluteSize
    local absolutePosition2 = screenGui2.AbsolutePosition

    local var2 = absolutePosition2 - absolutePosition
    local var3 = absolutePosition + screenGui.AbsoluteSize - (absolutePosition2 + screenGui2.AbsoluteSize)

    if tbl1[UserInputService:GetPlatform()] then
        local var4 = absoluteSize * 0.05
        var2 += var4
        var3 += var4
    end

    return {
        left = math.round(var2.X),
        top = math.round(var2.Y),
        right = math.round(var3.X),
        bottom = math.round(var3.Y)
    }
end

return {
    connect = function(_, arg1)
        init()
        return signal:connect(arg1)
    end,
    deviceInsets = function()
        init()
        return tbl2
    end,
    diffInsets = diffInsets,
    hasExtraPlatformInset = function(): boolean
        return false
    end,
    fullscreenGui = function()
        init()
        return screenGui
    end
}
