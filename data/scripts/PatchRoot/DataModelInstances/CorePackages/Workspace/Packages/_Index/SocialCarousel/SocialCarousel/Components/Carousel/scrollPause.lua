-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    SETTLE_SECONDS = 0.15,
    initialState = function()
        return { canvasX = nil, canvasY = nil, idleSeconds = 0, interacting = false }
    end,
    advance = function(tbl1, canvasX: number, num1: number, bool1: boolean?, canvasY: number?)
        local var1 = if canvasY == nil then tbl1.canvasY else canvasY

        if tbl1.canvasX == nil then
            return { canvasX = canvasX, canvasY = var1, idleSeconds = 0.15, interacting = false }
        end

        local bool2 = not (canvasY == nil) and canvasY ~= tbl1.canvasY

        if canvasX ~= tbl1.canvasX or bool2 then
            return { canvasX = canvasX, canvasY = var1, idleSeconds = 0, interacting = true }
        end

        if bool1 == true then
            return {
                canvasX = canvasX,
                canvasY = var1,
                idleSeconds = tbl1.idleSeconds + math.max(num1, 0),
                interacting = true
            }
        end

        if not tbl1.interacting then
            return tbl1
        end

        local idleSeconds = tbl1.idleSeconds + math.max(num1, 0)
        return {
            canvasX = canvasX,
            canvasY = var1,
            idleSeconds = idleSeconds,
            interacting = idleSeconds < 0.15
        }
    end,
    isPointerHold = function(userInputType): boolean
        return userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch
    end,
    pointerIsInside = function(vector2: Vector2, vector2_2: Vector2, vector2_3: Vector2): boolean
        if vector2_2.X <= 0 or vector2_2.Y <= 0 then
            return false
        end
        return vector2_3.X >= vector2.X
            and vector2_3.Y >= vector2.Y
            and vector2_3.X <= vector2.X + vector2_2.X
            and vector2_3.Y <= vector2.Y + vector2_2.Y
    end
}
