-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getModelBox(arg1)
    local var1, var2 = arg1:GetBoundingBox()

    if var2 == Vector3.new(0, 0, 0) then
        return nil
    end
    local var3 = nil
    local var4 = nil
    for i = -1, 1, 2 do
        for j = -1, 1, 2 do
            for k = -1, 1, 2 do
                local var5 = var1:PointToWorldSpace(var2 * Vector3.new(i, j, k) / 2)
                if var3 == nil then
                    var3 = var5
                else
                    var3 = var3:Min(var5)
                end

                if var4 == nil then
                    var4 = var5
                else
                    var4 = var4:Max(var5)
                end
            end
        end
    end

    return {
        center = var1.Position,
        minimum = var3,
        maximum = var4
    }
end
return getModelBox
