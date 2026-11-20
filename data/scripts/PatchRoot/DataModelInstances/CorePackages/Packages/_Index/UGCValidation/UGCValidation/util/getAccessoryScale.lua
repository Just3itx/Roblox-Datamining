-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Players = game:GetService("Players")

local bool1 = game:DefineFastFlag("HumanoidParentNil", false)

local tbl1 = {}
local var1 = nil
local var2 = nil
if not bool1 then
    if game:GetEngineFeature("AsyncRenamesUsedInLuaApps") then
        var1 = Players:CreateHumanoidModelFromDescriptionAsync(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15)
    else
        var1 = Players:CreateHumanoidModelFromDescription(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15)
    end

    var2 = var1:FindFirstChildOfClass("Humanoid")
    assert(var2, "Humanoid must exist in character model")

    local bodyTypeScale = var2:FindFirstChild("BodyTypeScale")
    local bodyProportionScale = var2:FindFirstChild("BodyProportionScale")

    bodyTypeScale.Value = 0
    bodyProportionScale.Value = 0

    for _, descendant in pairs(var1:GetDescendants()) do
        if not descendant:IsA("BasePart") then
            continue
        end

        for _, child in descendant:GetChildren() do
            if child:IsA("Attachment") then
                tbl1[child.Name] = var2:GetBodyPartR15(descendant)
            end
        end
    end
end

return function(arg1, arg2)
    if bool1 and var1 == nil then
        if game:GetEngineFeature("AsyncRenamesUsedInLuaApps") then
            var1 = Players:CreateHumanoidModelFromDescriptionAsync(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15)
        else
            var1 = Players:CreateHumanoidModelFromDescription(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15)
        end

        var2 = var1:FindFirstChildOfClass("Humanoid")
        assert(var2, "Humanoid must exist in character model")

        local bodyTypeScale = var2:FindFirstChild("BodyTypeScale")
        local bodyProportionScale = var2:FindFirstChild("BodyProportionScale")

        bodyTypeScale.Value = 0
        bodyProportionScale.Value = 0

        for _, descendant in pairs(var1:GetDescendants()) do
            if not descendant:IsA("BasePart") then
                continue
            end

            for _, child in descendant:GetChildren() do
                if child:IsA("Attachment") then
                    tbl1[child.Name] = var2:GetBodyPartR15(descendant)
                end
            end
        end
    end

    if var2 == nil then
        return Vector3.new(1, 1, 1)
    end
    return var2:GetAccessoryHandleScale(arg1, tbl1[arg2.Name])
end
