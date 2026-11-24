-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    Vector3.new(1, 1, 1),
    Vector3.new(1, 1, -1),
    Vector3.new(1, -1, 1),
    Vector3.new(1, -1, -1),
    Vector3.new(-1, 1, 1),
    Vector3.new(-1, 1, -1),
    Vector3.new(-1, -1, 1),
    Vector3.new(-1, -1, -1)
}

local function isCharacter(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1:IsA("Model") and arg1:FindFirstChildOfClass("Humanoid") ~= nil
end

local function selectSnapshotSources(tbl2)
    local cameraCFramePosition = tbl2.cameraCFrame.Position
    local var1 = tbl2.cameraCFrame:Inverse()
    local num1 = math.rad(tbl2.fovMargin)
    local num2 = math.rad(tbl2.fieldOfView * 0.5)
    local num3 = math.atan(math.tan(num2) * tbl2.aspect)
    local num4 = math.tan(math.min(num2 + num1, math.rad(88)))
    local num5 = math.tan(math.min(num3 + num1, math.rad(88)))

    local function isInView(arg1): boolean
        local var2 = arg1.Size * 0.5
        local cFrame = arg1.CFrame
        local num6 = 0
        local num7 = 0
        local num8 = 0
        local num9 = 0
        local num10 = 0
        local num11 = 0
        for _, vec3 in tbl1 do
            local var3 = var1 * (cFrame * (var2 * vec3))
            local var4 = -var3.Z
            local var5 = var4 * num5
            local var6 = var4 * num4
            if var4 <= 0 then
                num6 += 1
            end
            if tbl2.maxDepth < var4 then
                num7 += 1
            end
            if var5 < var3.X then
                num8 += 1
            end
            if var5 < -var3.X then
                num9 += 1
            end
            if var6 < var3.Y then
                num10 += 1
            end
            if var6 < -var3.Y then
                num11 += 1
            end
        end
        local num12 = #tbl1
        return num6 ~= num12 and num7 ~= num12 and num8 ~= num12 and num9 ~= num12 and num10 ~= num12 and num11 ~= num12
            or (arg1.Position - cameraCFramePosition).Magnitude - var2.Magnitude <= tbl2.nearRadius
    end

    local function nearestCharacter(arg1)
        local parent = arg1.Parent

        while parent ~= nil and parent ~= tbl2.root do
            if isCharacter(parent) then
                return parent
            end
            parent = parent.Parent
        end
        return nil
    end

    local tbl3 = {}
    local tbl4 = {}
    local tbl5 = ({})

    local function addCharacter(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        if not tbl5[arg1] then
            tbl5[arg1] = true
            table.insert(tbl4, arg1)
        end
    end

    if tbl2.localCharacter ~= nil then
        addCharacter(tbl2.localCharacter)
    end

    for _, descendant in tbl2.root:GetDescendants() do
        if not descendant:IsA("BasePart") or descendant:IsA("Terrain") or not isInView(descendant) then
            continue
        end

        local var2 = nearestCharacter(descendant)
        if var2 ~= nil then
            addCharacter(var2)
        else
            tbl5[descendant] = true
            table.insert(tbl3, descendant)
        end
    end

    local function isUnderCandidate(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        local parent = arg1.Parent
        while parent ~= nil and parent ~= tbl2.root do
            if tbl5[parent] then
                return true
            end
            parent = parent.Parent
        end
        return false
    end

    local looseParts = {}
    for _, value in tbl3 do
        if not isUnderCandidate(value) then
            table.insert(looseParts, value)
        end
    end
    local characters = {}
    for _, value in tbl4 do
        if not isUnderCandidate(value) then
            table.insert(characters, value)
        end
    end

    return { looseParts = looseParts, characters = characters }
end

return selectSnapshotSources
