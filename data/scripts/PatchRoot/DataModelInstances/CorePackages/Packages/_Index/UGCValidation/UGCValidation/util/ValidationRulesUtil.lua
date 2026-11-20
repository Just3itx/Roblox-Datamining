-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarCreationService = game:GetService("AvatarCreationService")

local module = {
    rigAttachmentToParentMap = {
        Head = "NeckRigAttachment",
        UpperTorso = "WaistRigAttachment",
        LowerTorso = "RootRigAttachment",
        RightHand = "RightWristRigAttachment",
        RightLowerArm = "RightElbowRigAttachment",
        RightUpperArm = "RightShoulderRigAttachment",
        LeftHand = "LeftWristRigAttachment",
        LeftLowerArm = "LeftElbowRigAttachment",
        LeftUpperArm = "LeftShoulderRigAttachment",
        RightFoot = "RightAnkleRigAttachment",
        RightLowerLeg = "RightKneeRigAttachment",
        RightUpperLeg = "RightHipRigAttachment",
        LeftFoot = "LeftAnkleRigAttachment",
        LeftLowerLeg = "LeftKneeRigAttachment",
        LeftUpperLeg = "LeftHipRigAttachment"
    }
}

function module.getRules(arg1)
    if not arg1.rules then
        arg1.rules = AvatarCreationService:GetValidationRules()
    end

    return arg1.rules
end

function module.getBodyPartMaxTrianglesRule(arg1, arg2)
    return arg1:getRules().MeshRules.BodyPartMaxTriangles[arg2]
end

function module.getMakeupRules(arg1)
    local makeupRules = arg1:getRules().MakeupRules
    local makeupRules2 = {}
    for value, value2 in makeupRules do
        if value ~= "ExcludeUVBounds" and value ~= "IncludeUVBounds" then
            makeupRules2[value] = value2
        end
    end

    local assetUvBounds = ({})
    for k, excludeUvBound in makeupRules.ExcludeUVBounds do
        if not assetUvBounds[k] then
            assetUvBounds[k] = {}
        end

        for _, value in excludeUvBound do
            table.insert(assetUvBounds[k], { isIncludeBound = false, MinBound = value.MinBound, MaxBound = value.MaxBound })
        end
    end

    for k, includeUvBound in makeupRules.IncludeUVBounds do
        if not assetUvBounds[k] then
            assetUvBounds[k] = {}
        end

        table.insert(
            assetUvBounds[k],
            {
                isIncludeBound = true,
                MinBound = includeUvBound.MinBound,
                MaxBound = includeUvBound.MaxBound
            }
        )
    end
    makeupRules2.AssetUVBounds = assetUvBounds

    return makeupRules2
end

function module.getAccessoryRules(arg1, arg2)
    for value, value2 in arg1:getRules().AccessoryRules do
        local tbl1 = {
            rigidAllowed = value2.RigidAllowed,
            attachmentNames = {},
            bounds = {}
        }
        for _, attachment in value2.Attachments do
            table.insert(tbl1.attachmentNames, attachment.Name)
            local bounds = tbl1.bounds
            local attachmentName = attachment.Name
            bounds[attachmentName] = {
                size = attachment.Size,
                offset = attachment.Offset
            }
        end
        arg2[value] = tbl1
    end
end

function module.getBodyPartRules(arg1, arg2)
    for value, value2 in arg1:getRules().BodyPartRules do
        local tbl1 = {
            isBodyPart = true,
            bounds = {},
            subParts = {}
        }
        for k, bound in value2.Bounds do
            local bounds = tbl1.bounds
            local tbl2 = {
                minSize = bound.MinSize,
                maxSize = bound.MaxSize
            }
            bounds[k] = tbl2
        end

        for k, subPart in value2.SubParts do
            local tbl2 = {
                rigAttachmentToParent = {},
                otherAttachments = {}
            }
            local var1 = module.rigAttachmentToParentMap[k]
            for name, value4 in subPart do
                if var1 == name then
                    tbl2.rigAttachmentToParent = {
                        name = name,
                        bounds = {
                            min = value4.LowerBound,
                            max = value4.UpperBound
                        }
                    }
                else
                    local otherAttachments = tbl2.otherAttachments
                    local tbl3 = {
                        bounds = {
                            min = value4.LowerBound,
                            max = value4.UpperBound
                        }
                    }
                    otherAttachments[name] = tbl3
                end
            end

            tbl1.subParts[k] = tbl2
        end
        arg2[value] = tbl1
    end
end

function module.getFullBodyRulesBounds(arg1)
    local fullBodyRulesBounds = ({})
    for k, bound in arg1:getRules().FullBodyRules.Bounds do
        local tbl1 = {
            minSize = bound.MinSize,
            maxSize = bound.MaxSize
        }
        fullBodyRulesBounds[k] = tbl1
    end

    return fullBodyRulesBounds
end

function module.getLCSizeLimit(_, arg1, arg2)
    for _, attachment in module:getRules().AccessoryRules[arg1].Attachments do
        if arg2:FindFirstChild(attachment.Name) then
            return true, attachment.Size
        end
    end
    return false, nil
end

return module
