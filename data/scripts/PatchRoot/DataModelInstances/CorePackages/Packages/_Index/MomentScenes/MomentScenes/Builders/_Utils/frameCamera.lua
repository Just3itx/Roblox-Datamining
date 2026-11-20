-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local avatarFloorPosition = require(script.Parent.avatarFloorPosition)

local MomentScenesParent = script:FindFirstAncestor("MomentScenes").Parent
local var1 = require(MomentScenesParent.SafeFlags).createGetFString("MomentScenesFrameCameraPadding", "2")

local function cameraPadding(): number -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = tonumber(var1())
    return if var2 == nil or var2 <= 0 then 2 else var2
end

local function headTopAboveRoot(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg2.Position.Y - arg1.Position.Y + 0.5 * arg2.Size.Y
end

local function emptyFit(): (CFrame, Vector3, number)
    return CFrame.lookAt(Vector3.new(0, 2.5, 8), Vector3.new(0, 2, 0)), Vector3.new(0, 2, 0), 8
end

local function distanceToFit(vec1: vector, num1: number): number
    local num2 = math.rad(num1) / 2
    local num3 = math.atan(math.tan(num2) * 0.5625)
    return math.max(
        if math.tan(num2) > 0 then vec1.Y / 2 / math.tan(num2) else 8,
        if math.tan(num3) > 0 then vec1.X / 2 / math.tan(num3) else 8,
        1
    ) * cameraPadding()
end

local function fitBox(vec1: vector, vec2: vector, num1: number): (CFrame, Vector3, number?)
    local var2 = vec2 - vec1
    local target = (vec1 + vec2) / 2
    local z = distanceToFit(var2, num1)
    return CFrame.lookAt(target + Vector3.new(0, 0, z), target), target, z
end

return {
    fitStandingCharacters = function(tbl1, num1: number)
        local vec3 = Vector3.new(math.huge, math.huge, math.huge)
        local vec3_2 = Vector3.new(-math.huge, -math.huge, -math.huge)
        local bool1 = false
        for _, value in tbl1 do
            local humanoidRootPart = value:FindFirstChild("HumanoidRootPart")
            local head = value:FindFirstChild("Head")
            local var2 = avatarFloorPosition.heightForCharacter(value)
            if humanoidRootPart == nil
                or not humanoidRootPart:IsA("BasePart")
                or head == nil
                or not head:IsA("BasePart")
                or var2 == nil
            then
                continue
            end

            local var3 = var2 + headTopAboveRoot(humanoidRootPart, head)

            local var4 = var3 * 0.24
            local humanoidRootPartPosition = humanoidRootPart.Position
            vec3 = Vector3.new(
                math.min(vec3.X, humanoidRootPartPosition.X - var4),
                math.min(vec3.Y, 0),
                math.min(vec3.Z, humanoidRootPartPosition.Z - 0.75)
            )
            vec3_2 = Vector3.new(
                math.max(vec3_2.X, humanoidRootPartPosition.X + var4),
                math.max(vec3_2.Y, var3),
                math.max(vec3_2.Z, humanoidRootPartPosition.Z + 0.75)
            )
            bool1 = true
        end

        if not bool1 then
            return emptyFit()
        end
        return fitBox(vec3, vec3_2, num1)
    end,
    fitStandingFace = function(tbl1, num1: number)
        local vec3 = Vector3.new(math.huge, math.huge, math.huge)
        local vec3_2 = Vector3.new(-math.huge, -math.huge, -math.huge)
        local bool1 = false
        for _, value in tbl1 do
            local humanoidRootPart = value:FindFirstChild("HumanoidRootPart")
            local head = value:FindFirstChild("Head")
            local var2 = avatarFloorPosition.heightForCharacter(value)
            if humanoidRootPart == nil
                or not humanoidRootPart:IsA("BasePart")
                or head == nil
                or not head:IsA("BasePart")
                or var2 == nil
            then
                continue
            end

            local var3 = var2 + headTopAboveRoot(humanoidRootPart, head)

            local humanoidRootPartPosition = humanoidRootPart.Position
            vec3 = Vector3.new(
                math.min(vec3.X, humanoidRootPartPosition.X - 0.7),
                math.min(vec3.Y, var3 - 2),
                math.min(vec3.Z, humanoidRootPartPosition.Z - 0.5)
            )
            vec3_2 = Vector3.new(
                math.max(vec3_2.X, humanoidRootPartPosition.X + 0.7),
                math.max(vec3_2.Y, var3),
                math.max(vec3_2.Z, humanoidRootPartPosition.Z + 0.5)
            )
            bool1 = true
        end

        if not bool1 then
            return emptyFit()
        end
        return fitBox(vec3, vec3_2, num1)
    end
}
