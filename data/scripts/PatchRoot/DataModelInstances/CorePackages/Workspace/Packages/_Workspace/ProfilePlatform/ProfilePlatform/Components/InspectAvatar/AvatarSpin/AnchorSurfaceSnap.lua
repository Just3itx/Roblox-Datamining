-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ItemAnchors = require(script.Parent.ItemAnchors)

local module = {}

local function perpendicularAxes(unit: vector) -- Luacid: Inlined by compiler; 1 call site recovered
    local unitY = unit.Y
    local unit2 = unit:Cross(if math.abs(unitY) < 0.9 then Vector3.new(0, 1, 0) else Vector3.new(1, 0, 0)).Unit
    return unit2, unit:Cross(unit2).Unit
end

local function medoid(tbl1)
    local var1 = tbl1[1]
    local huge = math.huge
    for _, value in tbl1 do
        local num1 = 0
        for _, value2 in tbl1 do
            num1 += (value - value2).Magnitude
        end
        if num1 < huge then
            var1 = value
            huge = num1
        end
    end

    return var1
end

local function isSnappable(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local part = arg1.part
    return part:IsDescendantOf(arg1.target) and part:FindFirstChildWhichIsA("SpecialMesh") == nil
end

function module.snapAnchor(arg1, arg2, cFrame: CFrame, vec1: vector)
    if not isSnappable(arg2) then
        return arg2
    end
    local part = arg2.part
    local var1 = part.CFrame:PointToWorldSpace(arg2.offset)
    local normal = arg2.normal
    local var2 = if normal then cFrame:VectorToWorldSpace(normal) else vec1 - var1

    if var2.Magnitude < 1e-6 then
        return arg2
    end
    local unit = var2.Unit
    local var3, unit2 = perpendicularAxes(unit)
    local var4 = part.Size.Magnitude / 2

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Include
    raycastParams.FilterDescendantsInstances = { arg2.target }

    local tbl1 = {}
    for i = 0, 6 do
        for j = 0, 6 do
            local var5 = (i / 6 * 2 - 1) * var4
            local var6 = (j / 6 * 2 - 1) * var4
            local var7 = arg1:Raycast(var1 + unit * (var4 * 2) + var3 * var5 + unit2 * var6, -unit * (var4 * 4), raycastParams)
            if var7 then
                table.insert(tbl1, var7.Position)
            end
        end
    end
    if #tbl1 == 0 then
        return arg2
    end

    local var5 = table.clone(arg2)
    var5.offset = part.CFrame:PointToObjectSpace(medoid(tbl1) + unit * 0.02)
    return var5
end

function module.snap(arg1, tbl1, cFrame: CFrame, vec1: vector)
    local result = {}
    for _, value in tbl1 do
        local anchors = {}
        for _, anchor in value.anchors do
            table.insert(anchors, module.snapAnchor(arg1, anchor, cFrame, vec1))
        end
        table.insert(result, { itemId = value.itemId, anchors = anchors })
    end
    return result
end

return module
