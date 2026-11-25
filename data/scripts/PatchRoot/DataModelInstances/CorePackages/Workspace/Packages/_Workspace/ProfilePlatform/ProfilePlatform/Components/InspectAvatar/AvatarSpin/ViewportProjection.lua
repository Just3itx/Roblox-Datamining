-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.worldToViewport(cFrame: CFrame, fieldOfView: number, vector2: Vector2, vec1: vector): (Vector2, number)
    local localPoint = cFrame:PointToObjectSpace(vec1)
    local num1 = -localPoint.Z
    if num1 <= 0.001 or vector2.X <= 0 or vector2.Y <= 0 then
        return Vector2.zero, math.min(num1, 0)
    end
    local num2 = math.tan(math.rad(fieldOfView) / 2)
    local var1 = num2 * vector2.X / vector2.Y
    local var2 = localPoint.X / num1 / var1
    local num3 = localPoint.Y / num1 / num2
    return Vector2.new((var2 + 1) * 0.5 * vector2.X, (1 - num3) * 0.5 * vector2.Y), num1
end

function module.viewportToRay(cFrame: CFrame, num1: number, vector2: Vector2, vector2_2: Vector2)
    if vector2.X <= 0 or vector2.Y <= 0 then
        return cFrame.LookVector
    end
    local num2 = math.tan(math.rad(num1) / 2)
    local var1 = num2 * vector2.X / vector2.Y
    local var2 = vector2_2.X / vector2.X * 2 - 1
    local var3 = 1 - vector2_2.Y / vector2.Y * 2
    local x = var2 * var1
    local y = var3 * num2
    return cFrame:VectorToWorldSpace(Vector3.new(x, y, -1)).Unit
end

function module.isInsideViewport(vector2: Vector2, vector2_2: Vector2, num1: number): boolean
    return vector2.X >= -num1 and vector2.Y >= -num1 and vector2.X <= vector2_2.X + num1 and vector2.Y <= vector2_2.Y + num1
end

function module.projectBounds(arg1, tbl1): {height: number, width: number, x: number, y: number}?
    local var1, var2 = arg1:GetBoundingBox()
    local huge = math.huge
    local huge2 = math.huge
    local huge3 = -math.huge
    local huge4 = -math.huge
    for _, value in { -0.5, 0.5 } do
        for _, value2 in { -0.5, 0.5 } do
            for _, value3 in { -0.5, 0.5 } do
                local x = value * var2.X
                local y = value2 * var2.Y
                local z = value3 * var2.Z
                local var3 = var1:PointToWorldSpace(Vector3.new(x, y, z))
                local var4, var5 = module.worldToViewport(tbl1.cameraCFrame, tbl1.fieldOfView, tbl1.viewportSize, var3)

                if var5 > 0 then
                    huge = math.min(huge, var4.X)
                    huge2 = math.min(huge2, var4.Y)
                    huge3 = math.max(huge3, var4.X)
                    huge4 = math.max(huge4, var4.Y)
                end
            end
        end
    end
    return if huge == math.huge then nil else {
        x = huge,
        y = huge2,
        width = huge3 - huge,
        height = huge4 - huge2
    }
end
return module
