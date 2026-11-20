-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local tbl1 = { InExpServer = true, InExpClient = true }

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD, ValidationEnums.UploadCategory.RIGID_ACCESSORY },
    requiredData = {},
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance

    local bool1 = tbl1[arg2.consumerConfig.source] == true

    local descendants = rootInstance:GetDescendants()
    table.insert(descendants, rootInstance)

    for _, descendant in descendants do
        if not descendant:IsA("MeshPart") then
            continue
        end

        local bool2 = descendant.TextureID ~= ""
        if bool1 and not bool2 then
            local textureContent = descendant.TextureContent
            bool2 = textureContent.Uri ~= nil and textureContent.Uri ~= "" or textureContent.Object ~= nil
        end
        local surfaceAppearance = descendant:FindFirstChildWhichIsA("SurfaceAppearance")

        if bool2 then
            if surfaceAppearance then
                local surfaceAppearanceTextureAndSaBothDefined = ErrorSourceStrings.Keys.SurfaceAppearance_TextureAndSABothDefined
                local tbl2 = {
                    MeshPartFullName = descendant:GetFullName()
                }
                arg1:fail(surfaceAppearanceTextureAndSaBothDefined, tbl2, descendant)
            end
        elseif not surfaceAppearance then
            local surfaceAppearanceMissingSa = ErrorSourceStrings.Keys.SurfaceAppearance_MissingSA
            local tbl2 = {
                MeshPartFullName = descendant:GetFullName()
            }
            arg1:fail(surfaceAppearanceMissingSa, tbl2, descendant)
        end
    end
end

return module
