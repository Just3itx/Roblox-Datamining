-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TnSAvatarIdentification = script:FindFirstAncestor("TnSAvatarIdentification")

local GetFFlagReportAnythingFixConvexHullCalculation = require(TnSAvatarIdentification.Flags.GetFFlagReportAnythingFixConvexHullCalculation)

local CoreGui = game:GetService("CoreGui")

local vector2 = Vector2.new(0, 0)
local vector2_2 = Vector2.new(math.huge, math.huge)

local function func1(vector2_3: Vector2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return vector2_3.Y < 0 or vector2_3.Y > 1 or vector2_3.X < 0 or vector2_3.X > 1
end

function worldToFullViewportPointNormalized(vec1: vector, arg1, tbl1)
    local var1, _ = arg1:WorldToViewportPoint(vec1)
    local vector2_3 = Vector2.new((var1.X + tbl1.insets.left) / tbl1.width, (var1.Y + tbl1.insets.top) / tbl1.height)
    return vector2_3, var1.Z, not func1(vector2_3) and var1.Z > 0
end

function getViewportCorners(tbl1, arg1, tbl2)
    local vector2_3 = vector2_2
    local vector2_4 = vector2
    local num1 = 0
    for _, value in ipairs(tbl1) do
        assert(tbl2, "getViewportCorners requires viewportInfo")
        local other, _, var1 = worldToFullViewportPointNormalized(value, arg1, tbl2)

        if not var1 then
            other = Vector2.new(math.clamp(other.X, 0, 1), math.clamp(other.Y, 0, 1))
        end

        if not GetFFlagReportAnythingFixConvexHullCalculation() or var1 then
            num1 += 1
        end

        vector2_3 = vector2_3:Min(other)
        vector2_4 = vector2_4:Max(other)
    end

    if num1 <= 2 then
        return vector2_2, vector2
    end

    return vector2_3, vector2_4
end

function shouldIgnoreLocalCharacter(arg1): boolean
    local head = arg1:FindFirstChild("Head")
    return if head and head:IsA("BasePart") then head.LocalTransparencyModifier >= 0.95 else false
end

function getLocalCharacterPosition(arg1)
    local humanoidRootPart = arg1:FindFirstChild("HumanoidRootPart")
    return if humanoidRootPart then humanoidRootPart.Position else nil
end

return {
    getViewportInfo = function()
        assert(CoreGui, "getViewportInfo requires CoreGui to be available")

        local _fullscreenTestGuiAvatarId = CoreGui:FindFirstChild("_FullscreenTestGui_AvatarID")
        if not _fullscreenTestGuiAvatarId then
            _fullscreenTestGuiAvatarId = Instance.new("ScreenGui")
            _fullscreenTestGuiAvatarId.Name = "_FullscreenTestGui_AvatarID"
            _fullscreenTestGuiAvatarId.Parent = CoreGui
            _fullscreenTestGuiAvatarId.ScreenInsets = Enum.ScreenInsets.None
        end

        local _deviceTestGuiAvatarId = CoreGui:FindFirstChild("_DeviceTestGui_AvatarID")
        if not _deviceTestGuiAvatarId then
            _deviceTestGuiAvatarId = Instance.new("ScreenGui")
            _deviceTestGuiAvatarId.Name = "_DeviceTestGui_AvatarID"
            _deviceTestGuiAvatarId.Parent = CoreGui
            _deviceTestGuiAvatarId.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
        end

        local var1 = _deviceTestGuiAvatarId.AbsolutePosition - _fullscreenTestGuiAvatarId.AbsolutePosition
        local var2 = _fullscreenTestGuiAvatarId.AbsolutePosition + _fullscreenTestGuiAvatarId.AbsoluteSize - (_deviceTestGuiAvatarId.AbsolutePosition + _deviceTestGuiAvatarId.AbsoluteSize)
        local insets = {
            left = var1.X,
            top = var1.Y,
            right = var2.X,
            bottom = var2.Y
        }
        return {
            width = _fullscreenTestGuiAvatarId.AbsoluteSize.X,
            height = _fullscreenTestGuiAvatarId.AbsoluteSize.Y,
            insets = insets
        }
    end,
    getViewportCorners = getViewportCorners,
    worldToFullViewportPointNormalized = worldToFullViewportPointNormalized,
    shouldIgnoreLocalCharacter = shouldIgnoreLocalCharacter,
    getLocalCharacterPosition = getLocalCharacterPosition,
    defaultMin = vector2_2
}
