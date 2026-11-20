-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Constants)
local _Types = require(scriptParentParent.util.Types)

local module = {}
local var1 = nil

local flags = scriptParentParent.flags
local getFFlagUGCValidationAllowHRDUpload = require(flags.getFFlagUGCValidationAllowHRDUpload)
local getFFlagDebugAllowHRDUploadOnBundleBackend = require(flags.getFFlagDebugAllowHRDUploadOnBundleBackend)

local getFingerFlatSuffixes = {
    "Index",
    "Middle",
    "Pinky",
    "Ring",
    "Thumb"
}
local function buildDrdSchema(str1: string)
    local drdSchema = ({})

    for _, value in getFingerFlatSuffixes do
        local str2 = `{str1}Hand{value}`
        local str3 = `{str2}1`
        drdSchema[str3] = {
            ClassName = "Bone",
            _children = {
                [`{str2}2`] = {
                    ClassName = "Bone",
                    _children = {
                        [`{str2}3`] = { ClassName = "Bone" }
                    }
                }
            }
        }
    end

    return drdSchema
end

local tbl2 = {
    HeadBase = {
        ClassName = "Bone",
        _children = {
            FaceCenterAttachment = { ClassName = "Attachment" },
            FaceFrontAttachment = { ClassName = "Attachment" },
            HairAttachment = { ClassName = "Attachment" },
            HatAttachment = { ClassName = "Attachment" }
        }
    }
}

local tbl3 = {
    Spine = {
        ClassName = "Bone",
        _children = {
            Chest = {
                ClassName = "Bone",
                _children = {
                    BodyBackAttachment = { ClassName = "Attachment" },
                    BodyFrontAttachment = { ClassName = "Attachment" },
                    NeckRigAttachment = { ClassName = "Attachment" },
                    NeckAttachment = { ClassName = "Attachment" },
                    LeftClavicle = {
                        ClassName = "Bone",
                        _children = {
                            LeftCollarAttachment = { ClassName = "Attachment" },
                            LeftShoulderRigAttachment = { ClassName = "Attachment" }
                        }
                    },
                    RightClavicle = {
                        ClassName = "Bone",
                        _children = {
                            RightCollarAttachment = { ClassName = "Attachment" },
                            RightShoulderRigAttachment = { ClassName = "Attachment" }
                        }
                    }
                }
            }
        }
    }
}

local tbl4 = {
    LeftToeBase = { ClassName = "Bone" }
}

local tbl5 = {
    RightToeBase = { ClassName = "Bone" }
}

local drdSchema = buildDrdSchema("Left")
local drdSchema2 = buildDrdSchema("Right")

module.JointRotationName = "JointRotation"

local bool1 = false

function module.setIsBackendBundleUpload(bool2: boolean)
    bool1 = bool2
end

function module.checkFlagEnabledForAllowHrd(): boolean
    return if getFFlagUGCValidationAllowHRDUpload() then true else not not (getFFlagDebugAllowHRDUploadOnBundleBackend() and bool1)
end

local jointLabels = nil
local jointLabels2 = nil

function module.getHrdJointLabels()
    if jointLabels == nil then
        jointLabels = Instance.new("HumanoidRigDescription"):GetJointLabels()
    end
    return jointLabels
end

function module.getDrdJointLabels()
    if jointLabels2 == nil then
        jointLabels2 = Instance.new("DigitsRigDescription"):GetJointLabels()
    end
    return jointLabels2
end

function module.getJointNameWhitelist()
    if var1 ~= nil then
        return var1
    end

    var1 = {}
    for value, _ in Constants.R15_STANDARD_JOINT_NAMES do
        var1[value] = true
    end

    for _, value in module.getHrdJointLabels() do
        var1[value.Name] = true
    end

    for _, value in module.getDrdJointLabels() do
        var1[`LeftHand{value.Name}`] = true
        var1[`RightHand{value.Name}`] = true
    end

    return var1
end

function module.getNameWhitelistOfClassInSchema(_children, className: string)
    local nameWhitelistOfClassInSchema = ({})
    for k, _child in _children do
        if _child.ClassName == className then
            nameWhitelistOfClassInSchema[k] = true
        end

        if _child._children == nil then
            continue
        end

        for value, value2 in module.getNameWhitelistOfClassInSchema(_child._children, className) do
            nameWhitelistOfClassInSchema[value] = value2
        end
    end

    return nameWhitelistOfClassInSchema
end

function module.getSchemaFlatHierarchyList(_children, tbl6)
    local schemaFlatHierarchyList = ({})
    for k, _child in _children do
        local path = table.clone(tbl6)
        table.insert(path, k)

        local tbl7 = {
            ClassName = _child.ClassName,
            path = path
        }
        schemaFlatHierarchyList[k] = tbl7

        if _child._children == nil then
            continue
        end

        for value, value2 in module.getSchemaFlatHierarchyList(_child._children, path) do
            schemaFlatHierarchyList[value] = value2
        end
    end

    return schemaFlatHierarchyList
end

function module.getFingerFlatSuffixes()
    return getFingerFlatSuffixes
end

function module.getDrdSchema(str1: string)
    if str1 == "Left" then
        return drdSchema
    elseif str1 == "Right" then
        return drdSchema2
    end
    error("Invalid side: " .. str1)
end

function module.getAvatarBoneSchema(str1: string)
    if str1 == "Head" then
        return tbl2
    elseif str1 == "UpperTorso" then
        return tbl3
    elseif str1 == "LeftFoot" then
        return tbl4
    elseif str1 == "RightFoot" then
        return tbl5
    elseif str1 == "LeftHand" then
        return drdSchema
    elseif str1 == "RightHand" then
        return drdSchema2
    end

    return {}
end

return module
