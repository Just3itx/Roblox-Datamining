-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Types = require(scriptParentParent.util.Types)
local calculateMinMax = require(scriptParentParent.util.calculateMinMax)
local getExpectedPartSize = require(scriptParentParent.util.getExpectedPartSize)
local ConstantsInterface = require(scriptParentParent.ConstantsInterface)
local getPartNamesInHierarchyOrder = require(scriptParentParent.util.getPartNamesInHierarchyOrder)
local R15plusUtils = require(scriptParentParent.util.R15plusUtils)
local getAttachmentCFrameInPartSpace = require(scriptParentParent.util.getAttachmentCFrameInPartSpace)
local module = {}

function module.calculateBounds(arg1, arg2, cFrame: CFrame, arg3, arg4)
    if arg4 then
        local expectedPartSize = getExpectedPartSize(arg2, arg4)
        local minMeshCorner, maxMeshCorner = calculateMinMax(
            arg3.minMeshCorner,
            arg3.maxMeshCorner,
            cFrame:PointToWorldSpace(-(expectedPartSize / 2)),
            cFrame:PointToWorldSpace(-(expectedPartSize / 2))
        )
        arg3.minMeshCorner = minMeshCorner
        arg3.maxMeshCorner = maxMeshCorner

        local var1, var2 = calculateMinMax(
            arg3.minMeshCorner,
            arg3.maxMeshCorner,
            cFrame:PointToWorldSpace(expectedPartSize / 2),
            cFrame:PointToWorldSpace(expectedPartSize / 2)
        )
        arg3.minMeshCorner = var1
        arg3.maxMeshCorner = var2
    else
        local minMeshCorner, maxMeshCorner = calculateMinMax(
            arg3.minMeshCorner,
            arg3.maxMeshCorner,
            cFrame:PointToWorldSpace(-(arg2.Size / 2)),
            cFrame:PointToWorldSpace(-(arg2.Size / 2))
        )
        arg3.minMeshCorner = minMeshCorner
        arg3.maxMeshCorner = maxMeshCorner

        local var1, var2 = calculateMinMax(
            arg3.minMeshCorner,
            arg3.maxMeshCorner,
            cFrame:PointToWorldSpace(arg2.Size / 2),
            cFrame:PointToWorldSpace(arg2.Size / 2)
        )
        arg3.minMeshCorner = var1
        arg3.maxMeshCorner = var2
    end

    for _, value in ConstantsInterface.getAttachments(arg1, arg2.Name) do
        local var1 = arg2:FindFirstChild(value, R15plusUtils.checkFlagEnabledForAllowHrd())
        assert(var1)

        if string.match(var1.Name, "RigAttachment$") ~= nil then
            local var2 = cFrame * getAttachmentCFrameInPartSpace(var1)
            local minRigAttachment, maxRigAttachment = calculateMinMax(arg3.minRigAttachment, arg3.maxRigAttachment, var2.Position, var2.Position)
            arg3.minRigAttachment = minRigAttachment
            arg3.maxRigAttachment = maxRigAttachment
        end
    end

    local minOverall, maxOverall = calculateMinMax(arg3.minOverall, arg3.maxOverall, arg3.minMeshCorner, arg3.maxMeshCorner)
    arg3.minOverall = minOverall
    arg3.maxOverall = maxOverall

    local var1, var2 = calculateMinMax(arg3.minOverall, arg3.maxOverall, arg3.minRigAttachment, arg3.maxRigAttachment)
    arg3.minOverall = var1
    arg3.maxOverall = var2
end

function module.traverseHierarchy(arg1, arg2, arg3, str1: string?, cFrame: CFrame, str2: string, arg4, arg5, arg6)
    assert(arg1 ~= nil ~= ((arg2 and arg3) ~= nil))
    local var1 = if arg1 then arg1[str2] else arg2:FindFirstChild(str2)
    assert(var1)
    local var2

    if str1 then
        local var3 = if arg1 then arg1[str1] else arg2:FindFirstChild(str1)
        assert(var3)

        local rigAttachmentToParent = ConstantsInterface.getRigAttachmentToParent(arg3, str2)

        local var4 = var3:FindFirstChild(rigAttachmentToParent, R15plusUtils.checkFlagEnabledForAllowHrd())
        assert(var4)

        local var5 = var1:FindFirstChild(rigAttachmentToParent, R15plusUtils.checkFlagEnabledForAllowHrd())
        assert(var5)

        var2 = cFrame * getAttachmentCFrameInPartSpace(var4) * getAttachmentCFrameInPartSpace(var5):Inverse()
    else
        var2 = CFrame.new()
    end
    module.calculateBounds(arg3, var1, var2, arg5, arg6)

    if not arg4.children then
        return
    end

    for k, child in arg4.children do
        module.traverseHierarchy(arg1, arg2, arg3, str2, var2, k, child, arg5, arg6)
    end
end

local var1 = nil
local function initRigParentToChild()
    if var1 then
        return
    end
    var1 = {}

    for _, assetType in {
        Enum.AssetType.LeftArm,
        Enum.AssetType.RightArm,
        Enum.AssetType.LeftLeg,
        Enum.AssetType.RightLeg
    } do
        local partNamesInHierarchyOrder = getPartNamesInHierarchyOrder(assetType)
        var1[assetType] = {}
        for i = 1, #partNamesInHierarchyOrder - 1 do
            var1[assetType][partNamesInHierarchyOrder[i]] = partNamesInHierarchyOrder[i + 1]
        end
    end
end

function module.getAssetRigChild(arg1, str1: string)
    initRigParentToChild()

    return assert(var1[arg1], "Invalid asset type")[str1]
end

module.assetHierarchy = {
    [Enum.AssetType.DynamicHead] = { root = "Head" },
    [Enum.AssetType.Torso] = {
        root = "LowerTorso",
        children = {
            UpperTorso = {}
        }
    },
    [Enum.AssetType.LeftArm] = {
        root = "LeftUpperArm",
        children = {
            LeftLowerArm = {
                children = {
                    LeftHand = {}
                }
            }
        }
    },
    [Enum.AssetType.RightArm] = {
        root = "RightUpperArm",
        children = {
            RightLowerArm = {
                children = {
                    RightHand = {}
                }
            }
        }
    },
    [Enum.AssetType.LeftLeg] = {
        root = "LeftUpperLeg",
        children = {
            LeftLowerLeg = {
                children = {
                    LeftFoot = {}
                }
            }
        }
    },
    [Enum.AssetType.RightLeg] = {
        root = "RightUpperLeg",
        children = {
            RightLowerLeg = {
                children = {
                    RightFoot = {}
                }
            }
        }
    }
}

return module
