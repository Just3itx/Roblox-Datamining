-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local function getHeadAttachments(arg1)
    local headAttachments = {}
    local head = arg1:FindFirstChild("Head")
    if head then
        for _, child in pairs(head:GetChildren()) do
            if child:IsA("Attachment") then
                headAttachments[child.Name] = true
            end
        end
    end
    return headAttachments
end

local function makeRotatedCorner(num1: number, num2: number, num3: number, vec1: vector, cFrame: CFrame) -- Luacid: Inlined by compiler; 1 call site recovered
    return cFrame * Vector3.new(num1 * vec1.X, num2 * vec1.Y, num3 * vec1.Z)
end

local function growExtentsToIncludePoint(vec1: vector, vec2: vector, vec3: vector): (vector, Vector3)
    vec1 = Vector3.new(math.min(vec3.X, vec1.X), math.min(vec3.Y, vec1.Y), math.min(vec3.Z, vec1.Z))

    return vec1, Vector3.new(math.max(vec3.X, vec2.X), math.max(vec3.Y, vec2.Y), math.max(vec3.Z, vec2.Z))
end

local function growExtentsToInclude(vec1: vector, vec2: vector, arg1, cFrame: CFrame, cFrame2: CFrame?, num1: number?): (vector | Vector3, vector | Vector3)
    local var1 = arg1.Size / 2

    for i = -1, 1, 2 do
        for j = -1, 1, 2 do
            for k = -1, 1, 2 do
                local rotatedCorner = makeRotatedCorner(i, j, k, var1, arg1.CFrame)

                if cFrame2 and num1 then
                    local var2 = cFrame2:Inverse() * rotatedCorner

                    rotatedCorner = cFrame2 * Vector3.new(var2.X, math.max(num1, var2.Y), var2.Z)
                end

                local var2 = cFrame * rotatedCorner
                vec1, vec2 = growExtentsToIncludePoint(vec1, vec2, var2)
            end
        end
    end

    return vec1, vec2
end

local function initExtents(): (Vector3, Vector3) -- Luacid: Inlined by compiler; 3 call sites recovered
    return Vector3.new(math.huge, math.huge, math.huge), Vector3.new(-math.huge, -math.huge, -math.huge)
end

local function recursiveCalculateExtents(vec1: vector, vec2: vector, arg1, cFrame: CFrame, str1: string?)
    str1 = str1 or ""

    assert(str1, "indent is non-nil. Silence type checker.")
    str1 ..= "  "
    for _, child in pairs(arg1:GetChildren()) do
        if child:IsA("BasePart") then
            vec1, vec2 = growExtentsToInclude(vec1, vec2, child, cFrame)
        end
        vec1, vec2 = recursiveCalculateExtents(vec1, vec2, child, cFrame, str1)
    end
    return vec1, vec2
end

function module.CalculateModelExtents(arg1, cFrame: CFrame)
    local vec3, vec3_2 = initExtents()
    local cFrame2 = cFrame:Inverse()
    local var1, var2 = recursiveCalculateExtents(vec3, vec3_2, arg1, cFrame2, "  ")
    return var1, var2
end

function module.CalculateHeadExtents(arg1, cFrame: CFrame)
    local vec3, vec3_2 = initExtents()
    local head = arg1:FindFirstChild("Head")
    if not head then
        return vec3, vec3_2
    end

    local cFrame2 = cFrame:Inverse()

    local var1 = -head.Size.Y / 2

    local var2, var3 = growExtentsToInclude(vec3, vec3_2, head, cFrame2)

    local headAttachments = getHeadAttachments(arg1)

    for _, child in pairs(arg1:GetChildren()) do
        if not child:IsA("Accoutrement") then
            continue
        end

        local handle = child:FindFirstChild("Handle")
        if not handle then
            continue
        end

        local attachment = handle:FindFirstChildWhichIsA("Attachment")

        if not attachment or headAttachments[attachment.Name] then
            var2, var3 = growExtentsToInclude(var2, var3, handle, cFrame2, head.CFrame, var1)
        end
    end

    return var2, var3
end

function module.CalculateBodyPartsExtents(cFrame: CFrame, tbl1)
    local vec3, vec3_2 = initExtents()
    local cFrame2 = cFrame:Inverse()

    for _, value in pairs(tbl1) do
        vec3, vec3_2 = growExtentsToInclude(vec3, vec3_2, value, cFrame2, cFrame)
    end

    return vec3, vec3_2
end

function module.AllocateDebugExtentParts(): {Part}
    local result = {}
    for i = 1, 8 do
        local part = Instance.new("Part")
        part.Parent = workspace
        part.Name = "DebugExtentPart" .. tostring(i)
        part.Shape = Enum.PartType.Ball
        part.Size = Vector3.new(0.25, 0.25, 0.25)
        part.Anchored = true
        part.CanCollide = false
        result[#result + 1] = part
    end
    return result
end

function module.PositionDebugExtentParts(tbl1, vec1: vector, vec2: vector, cFrame: CFrame)
    for i = 0, 1 do
        for j = 0, 1 do
            for k = 0, 1 do
                local num1 = i + j * 2 + k * 4 + 1
                local vec3 = Vector3.new(i == 0 and vec1.X or vec2.X, j == 0 and vec1.Y or vec2.Y, k == 0 and vec1.Z or vec2.Z)
                tbl1[num1].Position = cFrame * vec3
            end
        end
    end
end

return module
