-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Types = require(scriptParentParent.util.Types)
local AssetTraversalUtils = require(scriptParentParent.util.AssetTraversalUtils)
local ConstantsInterface = require(scriptParentParent.ConstantsInterface)
local R15plusUtils = require(scriptParentParent.util.R15plusUtils)
local getAttachmentCFrameInPartSpace = require(scriptParentParent.util.getAttachmentCFrameInPartSpace)

return function(arg1, arg2, arg3, assetType, arg4)
    local tbl1 = {}
    if Enum.AssetType.DynamicHead == assetType then
        AssetTraversalUtils.calculateBounds(assetType, arg3, CFrame.new(), tbl1, arg4)

        arg1.CFrame = CFrame.new()
        arg2.CFrame = CFrame.new()

        arg1.Size = arg2.Size
    else
        local var1 = AssetTraversalUtils.assetHierarchy[assetType]
        AssetTraversalUtils.traverseHierarchy(nil, arg3, assetType, nil, CFrame.new(), var1.root, var1, tbl1, arg4)

        local function moveParts(arg5, str1: string?, cFrame: CFrame, str2: string, arg6) -- Luacid: Inlined by compiler; 1 call site recovered
            local var2 = arg5:FindFirstChild(str2)

            if str1 then
                local var3 = arg5:FindFirstChild(str1)
                local rigAttachmentToParent = ConstantsInterface.getRigAttachmentToParent(assetType, str2)
                local var4 = var3:FindFirstChild(rigAttachmentToParent, R15plusUtils.checkFlagEnabledForAllowHrd())

                local var5 = var2:FindFirstChild(rigAttachmentToParent, R15plusUtils.checkFlagEnabledForAllowHrd())

                cFrame = cFrame * getAttachmentCFrameInPartSpace(var4) * getAttachmentCFrameInPartSpace(var5):Inverse()
            end
            var2.CFrame = cFrame
            if not arg6.children then
                return
            end

            for k, child in arg6.children do
                moveParts(arg5, str2, cFrame, k, child)
            end
        end

        moveParts(arg2, false, CFrame.new(), var1.root, var1)
        local _vec3 = Vector3.new()
        local _vec3_2 = Vector3.new()
        local var2 = if tbl1.maxOverall then tbl1.maxOverall else Vector3.new()
        local var3 = if tbl1.minOverall then tbl1.minOverall else Vector3.new()

        if tbl1.minOverall == nil or tbl1.maxOverall == nil then
            return false
        end
        arg1.Size = Vector3.new(var2.X - var3.X, var2.Y - var3.Y, var2.Z - var3.Z)
        arg1.Position = Vector3.new(var3.X + arg1.Size.X / 2, var3.Y + arg1.Size.Y / 2, var3.Z + arg1.Size.Z / 2)
    end

    return true
end
