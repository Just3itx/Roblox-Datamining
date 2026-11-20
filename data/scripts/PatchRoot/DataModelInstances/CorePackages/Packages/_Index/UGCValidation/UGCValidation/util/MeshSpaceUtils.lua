-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local BoundsDataUtils = require(scriptParentParent.util.BoundsDataUtils)
local getAttachmentCFrameInPartSpace = require(scriptParentParent.util.getAttachmentCFrameInPartSpace)

local module = {}

local function toWorldSpace(vec1: vector, boundsDimensions: vector) -- Luacid: Inlined by compiler; 2 call sites recovered
    return vec1 * (boundsDimensions / 2)
end

local function calculateLocalSpaceTransform(cFrame: CFrame, cFrame2: CFrame) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = cFrame.Rotation:Inverse() * cFrame2.Rotation
    local pos = cFrame.Rotation:Inverse() * (cFrame2.Position - cFrame.Position)

    return CFrame.new(pos) * var1
end

function module.clampAttachmentToBounds(arg1, arg2, arg3, num1: number?)
    num1 = num1 or 0.001

    local var1 = arg2.cframe * getAttachmentCFrameInPartSpace(arg1)

    local boundsCenters = BoundsDataUtils.calculateBoundsCenters(arg2.boundsData)
    local boundsDimensions = BoundsDataUtils.calculateBoundsDimensions(arg2.boundsData)
    assert(boundsCenters, "meshCenterPos is nil")
    assert(boundsDimensions, "meshDimensions is nil")

    local var2 = var1.Position - boundsCenters
    local var3 = toWorldSpace(arg3.min, boundsDimensions)
    local var4 = toWorldSpace(arg3.max, boundsDimensions)

    local tbl1 = ({})
    for _, value in { "X", "Y", "Z" } do
        tbl1[value] = {}
        local var5 = tbl1[value]
        local var6 = tbl1[value]
        local min = var3[value] + num1
        local max = var4[value] - num1
        var5.min = min
        var6.max = max

        if not (tbl1[value].min > tbl1[value].max) then
            continue
        end

        local var9 = (var3[value] + var4[value]) * 0.5
        local var10 = tbl1[value]
        local var11 = tbl1[value]
        var10.min = var9
        var11.max = var9
    end

    local var5 = boundsCenters + Vector3.new(
        math.clamp(var2.X, tbl1.X.min, tbl1.X.max),
        math.clamp(var2.Y, tbl1.Y.min, tbl1.Y.max),
        math.clamp(var2.Z, tbl1.Z.min, tbl1.Z.max)
    )
    local cFrame = var1.Rotation + var5

    return calculateLocalSpaceTransform(arg2.cframe, cFrame)
end

return module
