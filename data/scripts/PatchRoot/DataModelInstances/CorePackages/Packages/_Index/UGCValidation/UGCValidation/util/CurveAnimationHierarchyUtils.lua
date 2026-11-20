-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local AssetCalculator = require(scriptParentParent.util.AssetCalculator)

local module = {}

local var1 = nil

function module.getBodyPartToParentMap()
    var1 = var1 or AssetCalculator.getBodyPartsToParents()

    return var1
end

module.humanoidRootPartName = "HumanoidRootPart"
module.FaceControlsName = "FaceControls"

function module.folderHasAnimationTracks(arg1)
    local position = arg1:FindFirstChild("Position")
    local rotation = arg1:FindFirstChild("Rotation")
    local isVector3Curve = position ~= nil and position:IsA("Vector3Curve")
    return isVector3Curve or rotation ~= nil and (rotation:IsA("EulerRotationCurve") or rotation:IsA("RotationCurve"))
end

function module.isBodyPartFolderNameValid(humanoidRootPartName: string): boolean
    return module.getBodyPartToParentMap()[humanoidRootPartName] ~= nil or humanoidRootPartName == module.humanoidRootPartName
end

function module.getBodyPartFolderRoot(arg1)
    for _, child in arg1:GetChildren() do
        if child:IsA("Folder") and module.isBodyPartFolderNameValid(child.Name) then
            return child
        end
    end
    return nil
end

function module.areChildrenAcceptable(arg1, tbl1)
    if not arg1 then
        return true
    end

    local function findAndRemoveMatching(arg2)
        for value, value2 in tbl1 do
            if value2.ClassName == arg2.ClassName and value2.Name == arg2.Name then
                table.remove(tbl1, value)
                return true
            end
        end

        return false
    end

    for _, child in arg1:GetChildren() do
        if not findAndRemoveMatching(child) then
            return false
        end
    end

    return true
end

function module.calculateAcceptableChildBodyPartFolders(str1: string)
    local acceptableChildBodyPartFolders = {}
    for value, value2 in module.getBodyPartToParentMap() do
        if value2 == str1 then
            table.insert(acceptableChildBodyPartFolders, { ClassName = "Folder", Name = value })
        end
    end

    return acceptableChildBodyPartFolders
end

function module.calculateAcceptableCurveChildrenArray()
    return {
        { ClassName = "FloatCurve", Name = "X" },
        { ClassName = "FloatCurve", Name = "Y" },
        { ClassName = "FloatCurve", Name = "Z" }
    }
end

function module.containsGrandChildren(arg1): boolean
    return if arg1 then #arg1:GetDescendants() > #arg1:GetChildren() else false
end

return module
