-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrSpatialUiParent = script:FindFirstAncestor("VrSpatialUi").Parent
local VRUtil = require(VrSpatialUiParent.VrCommon).VRUtil

local num1 = game:DefineFastInt("SpatialUIHeadLookDotNoMovementThreshold", 990) / 1000

local module = {}

module.__index = module

function module:getCurrentStableCameraCFrame()
    return self.lastCameraCFrame
end

function module:updateAndCheckCameraMoved(): boolean
    local lastUserHeadCFrame = VRUtil.GetUserCFrameWorldSpace(Enum.UserCFrame.Head)
    if not self.lastUserHeadCFrame then
        self.lastUserHeadCFrame = lastUserHeadCFrame
        self.lastCameraCFrame = workspace.CurrentCamera.CFrame
        return true
    end
    local bool1 = workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable
    local bool2 = self.lastUserHeadCFrame.LookVector:Dot(lastUserHeadCFrame.LookVector) < num1

    if bool1 and not bool2 then
        return false
    end

    self.lastUserHeadCFrame = lastUserHeadCFrame
    self.lastCameraCFrame = workspace.CurrentCamera.CFrame
    return true
end

function module.new()
    local tbl1 = { lastUserHeadCFrame = nil, lastCameraCFrame = nil }

    setmetatable(tbl1, module)
    return tbl1
end

return module
