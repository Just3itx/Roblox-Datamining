-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Easing = require(script.Parent.Easing)
local _ItemAnchors = require(script.Parent.ItemAnchors)
local ViewportProjection = require(script.Parent.ViewportProjection)

local module = {}

function module.anchorPosition(arg1)
    return arg1.part.CFrame:PointToWorldSpace(arg1.offset)
end

function module.facingWeight(arg1, cFrame: CFrame, position: vector, vec1: vector)
    local normal = arg1.normal
    if not normal then
        return arg1.weight
    end
    local num1 = cFrame:VectorToWorldSpace(normal):Dot((position - vec1).Unit)
    return Easing.smoothstep(math.cos(math.rad(arg1.zeroDegrees)), math.cos(math.rad(arg1.fullDegrees)), num1) * arg1.weight
end

function module.evaluate(tbl1, tbl2, func1: (...any) -> (...any))
    local cameraCFramePosition = tbl2.cameraCFrame.Position
    local result = {}
    for _, value in tbl1 do
        local var1 = nil
        for _, anchor in value.anchors do
            local var2 = module.anchorPosition(anchor)
            local facing = module.facingWeight(anchor, tbl2.rootCFrame, cameraCFramePosition, var2)
            local position, var5 = ViewportProjection.worldToViewport(tbl2.cameraCFrame, tbl2.fieldOfView, tbl2.viewportSize, var2)

            local weight = if facing > 0
                and var5 > 0
                and ViewportProjection.isInsideViewport(position, tbl2.viewportSize, -4)
                and func1(cameraCFramePosition, var2, anchor) then facing else 0
            if var1 ~= nil and not (var1.weight < weight) then
                continue
            end

            var1 = {
                itemId = value.itemId,
                position = position,
                facing = facing,
                weight = weight
            }
        end
        if var1 then
            table.insert(result, var1)
        end
    end
    return result
end

function module.visibleCharacterParams(arg1, arg2): RaycastParams
    local filterDescendantsInstances = {}
    for _, child in arg1:GetChildren() do
        if child ~= arg2 then
            table.insert(filterDescendantsInstances, child)
        end
    end
    for _, descendant in arg2:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Transparency >= 1 then
            table.insert(filterDescendantsInstances, descendant)
        end
    end
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = filterDescendantsInstances
    return raycastParams
end

function module.createRaycastCheck(arg1, arg2)
    local var1 = module.visibleCharacterParams(arg1, arg2)
    return function(vec1: vector, vec2: vector, arg3): boolean
        local var2 = vec2 - vec1
        local var3 = arg1:Raycast(vec1, var2 * 1.02, var1)
        return var3 == nil
            or (if var3.Instance == arg3.target or var3.Instance:IsDescendantOf(arg3.target) then true else var3.Distance >= var2.Magnitude - 0.08)
    end
end

return module
