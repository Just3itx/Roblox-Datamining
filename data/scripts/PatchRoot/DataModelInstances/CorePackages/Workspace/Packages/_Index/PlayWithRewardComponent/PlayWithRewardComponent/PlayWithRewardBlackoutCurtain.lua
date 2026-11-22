-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CoreGui = game:GetService("CoreGui")

local module = {}
local var1 = nil

function module.show()
    if var1 and var1.Parent then
        return
    end

    local playWithRewardBlackoutCurtain = Instance.new("ScreenGui")
    playWithRewardBlackoutCurtain.Name = "PlayWithRewardBlackoutCurtain"
    playWithRewardBlackoutCurtain.DisplayOrder = 99
    playWithRewardBlackoutCurtain.IgnoreGuiInset = true

    local blackoutCurtainFrame = Instance.new("Frame")
    blackoutCurtainFrame.Name = "BlackoutCurtainFrame"
    blackoutCurtainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blackoutCurtainFrame.BackgroundTransparency = 0
    blackoutCurtainFrame.Size = UDim2.fromScale(1, 1)
    blackoutCurtainFrame.Active = true
    blackoutCurtainFrame.Parent = playWithRewardBlackoutCurtain

    playWithRewardBlackoutCurtain.Parent = CoreGui
    var1 = playWithRewardBlackoutCurtain
end

function module.hide()
    if var1 then
        var1:Destroy()
        var1 = nil
    end
end

return module
