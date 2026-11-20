-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local FetchAllDesiredData = require(scriptParentParentParent.validationSystem.dataFetchModules.FetchAllDesiredData)

local tbl1 = { ColorMap = true, NormalMap = true }

local module = {
    categories = { ValidationEnums.UploadCategory.RIGID_ACCESSORY },
    requiredData = {},
    conditionalData = { ValidationEnums.SharedDataMember.meshTextures },
    expectedFailures = {}
}
local function getIsOpaque(editable)
    local var1 = editable:ReadPixelsBuffer(Vector2.new(0, 0), editable.Size)
    for i = 0, buffer.len(var1) - 1, 4 do
        if buffer.readu8(var1, i + 3) < 255 then
            return false
        end
    end
    return true
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local meshTextures = arg2.meshTextures

    if not meshTextures or meshTextures == FetchAllDesiredData.DATA_FETCH_FAILURE then
        arg1:fetchError("Failed to load texture data for surface appearance opacity check")
        return
    end

    local descendants = rootInstance:GetDescendants()
    table.insert(descendants, rootInstance)

    for _, descendant in descendants do
        if not descendant:IsA("MeshPart") then
            continue
        end

        local surfaceAppearance = descendant:FindFirstChildWhichIsA("SurfaceAppearance")
        if not surfaceAppearance then
            continue
        end

        if surfaceAppearance.AlphaMode ~= Enum.AlphaMode.Overlay then
            local saOpacityInvalidAlphaMode = ErrorSourceStrings.Keys.SAOpacity_InvalidAlphaMode
            local tbl2 = {
                FullName = descendant:GetFullName()
            }
            arg1:fail(saOpacityInvalidAlphaMode, tbl2, surfaceAppearance)
        end

        local var1 = meshTextures[descendant.Name]
        if not (var1 and var1.isPBR) then
            continue
        end

        for fieldName, _ in tbl1 do
            local var2 = var1[fieldName]
            if not var2 then
                continue
            end

            if not var2.editable then
                local saOpacityFailedToLoadTexture = ErrorSourceStrings.Keys.SAOpacity_FailedToLoadTexture
                local tbl2 = {
                    FullName = surfaceAppearance:GetFullName(),
                    FieldName = fieldName
                }
                arg1:fail(saOpacityFailedToLoadTexture, tbl2, surfaceAppearance)
            elseif not getIsOpaque(var2.editable) then
                local saOpacityTextureNotOpaque = ErrorSourceStrings.Keys.SAOpacity_TextureNotOpaque
                local tbl2 = {
                    FullName = surfaceAppearance:GetFullName() .. "." .. fieldName
                }
                arg1:fail(saOpacityTextureNotOpaque, tbl2, surfaceAppearance)
            end
        end
    end
end

return module
