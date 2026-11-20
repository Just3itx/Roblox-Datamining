-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AssetService = game:GetService("AssetService")

local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local tryYield = require(scriptParentParent.util.tryYield)

local module = {}

local function orthoProjectCoordinate(axis1: vector, axis2: vector, vec1: vector): Vector2 -- Luacid: Inlined by compiler; 3 call sites recovered
    local x = axis1:Dot(vec1)
    local y = axis2:Dot(vec1)

    return Vector2.new(x, y)
end

local function shouldRenderTriangle(vec1: vector, vec2: vector): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return vec1:Dot(vec2) < 0
end

local function shouldRenderTriangle_UNIT_TEST(vec1: vector, vec2: vector): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not not shouldRenderTriangle(vec1, vec2)
end

module.shouldRenderTriangle_UNIT_TEST = shouldRenderTriangle_UNIT_TEST

local function getScreenCoordinatesForTriangle(orderedVerts, vector2: Vector2, tbl1, pos: vector, vec1: vector)
    local orderedVert = orderedVerts[1]
    local orderedVert2 = orderedVerts[2]
    local orderedVert3 = orderedVerts[3]

    local var1 = CFrame.new(pos):Inverse() * orderedVert
    local var2 = CFrame.new(pos):Inverse() * orderedVert2
    local var3 = CFrame.new(pos):Inverse() * orderedVert3

    local var4 = vec1 / 2
    local var5 = (var1 + var4) / vec1
    local var6 = (var2 + var4) / vec1
    local var7 = (var3 + var4) / vec1

    return orthoProjectCoordinate(tbl1.axis1, tbl1.axis2, var5) * (vector2 - Vector2.new(1, 1)), orthoProjectCoordinate(tbl1.axis1, tbl1.axis2, var6) * (vector2 - Vector2.new(1, 1)), orthoProjectCoordinate(tbl1.axis1, tbl1.axis2, var7) * (vector2 - Vector2.new(1, 1))
end

function module.rasterMesh(tbl1, vector2: Vector2, tbl2, pos: vector, vec1: vector, arg1)
    local editableImage = AssetService:CreateEditableImage({ Size = vector2 })

    for _, value in tbl1 do
        if shouldRenderTriangle_UNIT_TEST(value.normal, tbl2.normal) then
            local var1, var2, var3 = getScreenCoordinatesForTriangle(value.orderedVerts, editableImage.Size, tbl2, pos, vec1)
            editableImage:DrawTriangle(var1, var2, var3, Color3.new(1, 1, 1), 0)
            tryYield(arg1)
        end
    end
    return editableImage
end

return module
