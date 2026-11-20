-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)

local Constants = require(scriptParentParent.Constants)
local R15plusUtils = require(scriptParentParent.util.R15plusUtils)
local flags = scriptParentParent.flags
local getFFlagUGCValidationEnforceHRDUpload = require(flags.getFFlagUGCValidationEnforceHRDUpload)
local tbl1 = { LeftHand = "LeftHand", RightHand = "RightHand" }

local function createIndividualBodyPartSchema(arg1, str1: string, _)
    local subPart = Constants.ASSET_TYPE_INFO[arg1].subParts[str1]

    local tbl2 = {
        ClassName = "MeshPart",
        Name = { str1 },
        _children = {
            {
                Name = { "AvatarPartScaleType" },
                ClassName = "StringValue"
            },
            {
                Name = { str1, str1 .. "WrapTarget", "WrapTarget" },
                ClassName = "WrapTarget"
            },
            {
                Name = { "SurfaceAppearance" },
                ClassName = "SurfaceAppearance",
                _optional = true
            }
        }
    }

    table.insert(tbl2._children, { Name = { subPart.rigAttachmentToParent.name }, ClassName = "Attachment" })

    for k in pairs(subPart.otherAttachments) do
        table.insert(tbl2._children, { Name = { k }, ClassName = "Attachment" })
    end

    if R15plusUtils.checkFlagEnabledForAllowHrd() then
        table.insert(tbl2._children, {
            Name = { "HumanoidRigDescription" },
            ClassName = "HumanoidRigDescription",
            _optional = not getFFlagUGCValidationEnforceHRDUpload()
        })

        if tbl1[str1] ~= nil then
            local str2 = `{tbl1[str1]}Description`
            table.insert(
                tbl2._children,
                {
                    Name = { "DigitsRigDescription", str2 },
                    ClassName = "DigitsRigDescription",
                    _optional = true
                }
            )
        end

        local avatarBoneSchema = R15plusUtils.getAvatarBoneSchema(str1)
        local nameWhitelistOfClassInSchema = R15plusUtils.getNameWhitelistOfClassInSchema(avatarBoneSchema, "Attachment")
        for _, _child in tbl2._children do
            if _child.ClassName == "Attachment" and nameWhitelistOfClassInSchema[_child.Name[1]] then
                _child._optional = true
            end

            if not string.find(_child.Name[1], "ShoulderRigAttachment") then
                continue
            end

            if _child._children == nil then
                _child._children = {}
            end

            table.insert(
                _child._children,
                {
                    Name = { R15plusUtils.JointRotationName },
                    ClassName = "Attachment",
                    _optional = true
                }
            )
        end

        for value, value2 in (R15plusUtils.getNameWhitelistOfClassInSchema(avatarBoneSchema, "Bone")) do
            if not value2 then
                continue
            end

            table.insert(tbl2._children, { Name = { value }, ClassName = "Bone", _optional = true, _ignoreDescendants = true })
        end
    end

    return tbl2
end

return createIndividualBodyPartSchema
