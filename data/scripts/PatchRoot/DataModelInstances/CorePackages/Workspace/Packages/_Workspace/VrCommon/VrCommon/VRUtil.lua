-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrCommonParent = script:FindFirstAncestor("VrCommon").Parent

local MockableProxyServices = require(VrCommonParent.MockableProxyServices)

local engineFeature = game:GetEngineFeature("EnableVRUpdate3")

local VRService = MockableProxyServices.VRService

local module = {}

function module.RayPlaneIntersection(ray, arg1, arg2)
    arg1 = arg1.unit
    ray = ray.Unit

    local var1 = arg1:Dot(ray.Direction)
    if var1 == 0 then
        return nil
    end

    local var2 = arg1:Dot(arg2 - ray.Origin) / var1

    if var2 < 0 then
        return nil
    end

    return ray.Origin + ray.Direction * var2
end

function module.GetUserCFrameWorldSpace(arg1)
    local userCFrame = VRService:GetUserCFrame(arg1)

    if not workspace.CurrentCamera.HeadLocked then
        userCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head):Inverse() * userCFrame
    end

    return workspace.CurrentCamera.CFrame * (CFrame.new(userCFrame.p * workspace.CurrentCamera.HeadScale) * (userCFrame - userCFrame.p))
end

function module.getCurrentControllerType(): string
    local vrDeviceName = engineFeature and VRService.VRDeviceName or nil

    local var1 = vrDeviceName:match("Oculus")
        or vrDeviceName:match("Meta")
        or vrDeviceName:match("OpenXr")
        or vrDeviceName:match("OpenXR")

    return if vrDeviceName:match("Vive") then "Vive" elseif vrDeviceName:match("Rift") then "Rift" elseif vrDeviceName:match("Index") then "Index" elseif var1 then "Touch" else "Rift"
end

return module
