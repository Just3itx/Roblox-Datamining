-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SceneUnderstanding = script:FindFirstAncestor("SceneUnderstanding")

local ViewportQueryOptions = require(SceneUnderstanding.options.ViewportQueryOptions)

local function queryViewport(camera, func1: (...any) -> (...any), arg1)
    local viewportQueryOptions = ViewportQueryOptions.new(arg1)

    local num1 = 0
    local num2 = 1
    local num3 = 0
    local num4 = 0

    local num5 = 1
    local num6 = 0
    local maxScreenDivisions = viewportQueryOptions.maxScreenDivisions

    local num7 = math.ceil(maxScreenDivisions / 2) - 1

    local result = {}
    for _ = 1, maxScreenDivisions * maxScreenDivisions do
        local vector2 = Vector2.new(
            (num1 + 0.5 + num7) * (camera.ViewportSize.X / maxScreenDivisions),
            (num3 + 0.5 + num7) * (camera.ViewportSize.Y / maxScreenDivisions)
        )
        local var1 = camera:ScreenPointToRay(vector2.X, vector2.Y)

        local raycastResult = workspace:Raycast(var1.Origin, var1.Direction * viewportQueryOptions.maxDistance, viewportQueryOptions.raycastParams)

        if raycastResult
            and raycastResult.Instance
            and not table.find(result, raycastResult.Instance)
            and func1(raycastResult.Instance)
        then
            table.insert(result, raycastResult.Instance)

            if #result >= viewportQueryOptions.limit then
                return result
            end
        end

        num1 += num2
        num3 += num4
        num6 += 1

        if num6 ~= num5 then
            continue
        end

        num6 = 0

        local num8 = -num4

        if num2 == 0 then
            num5 += 1
            num4 = num2
            num2 = num8
        else
            num4 = num2
            num2 = num8
        end
    end

    return result
end

return queryViewport
