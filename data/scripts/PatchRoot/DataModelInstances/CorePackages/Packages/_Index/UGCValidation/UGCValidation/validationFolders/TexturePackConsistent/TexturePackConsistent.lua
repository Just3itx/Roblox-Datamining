-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local TexturePackUtils = require(scriptParentParentParent.util.TexturePackUtils)

local getFFlagUGCValidateTexturePack = require(scriptParentParentParent.flags.getFFlagUGCValidateTexturePack)
local getFFlagUGCValidateTexturePackOnRCCOnly = require(scriptParentParentParent.flags.getFFlagUGCValidateTexturePackOnRCCOnly)
local getFFlagUGCValidationAllowFullVaas = require(scriptParentParentParent.flags.getFFlagUGCValidationAllowFullVaas)

local tbl1 = { Publish = true, Backend = true, InExpServer = true, Internal = true }

local tbl2 = { InExpServer = true, InExpClient = true }

local module = {
    categories = {
        ValidationEnums.UploadCategory.TORSO_AND_LIMBS,
        ValidationEnums.UploadCategory.DYNAMIC_HEAD,
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH,
        ValidationEnums.UploadCategory.RIGID_ACCESSORY
    },
    requiredData = {},
    expectedFailures = {}
}
function module.run(arg1, arg2)
    if not getFFlagUGCValidateTexturePack() then
        return
    end

    local rootInstance = arg2.rootInstance
    local consumerConfig = arg2.consumerConfig

    if tbl2[consumerConfig.source] == true then
        return
    end

    local bool1 = if getFFlagUGCValidationAllowFullVaas() and consumerConfig.isVaaS then consumerConfig.validationEnv == ValidationEnums.ValidationEnv.Backend else tbl1[consumerConfig.source] == true
    local uploadCategory = arg2.uploadCategory
    local bool2 = uploadCategory == ValidationEnums.UploadCategory.TORSO_AND_LIMBS
        or uploadCategory == ValidationEnums.UploadCategory.DYNAMIC_HEAD

    if getFFlagUGCValidateTexturePackOnRCCOnly() then
        if bool1 then
            for _, value in (TexturePackUtils.findSurfaceAppearancesMissingTexturePacks(rootInstance, bool2)) do
                local texturePackInvalidUrl = ErrorSourceStrings.Keys.TexturePackInvalidURL
                local tbl3 = {
                    SurfaceAppearanceName = value:GetFullName()
                }
                arg1:fail(texturePackInvalidUrl, tbl3, value)
            end
        end
    else
        for _, value in (TexturePackUtils.findSurfaceAppearancesMissingTexturePacks(rootInstance, bool2)) do
            local texturePackInvalidUrl = ErrorSourceStrings.Keys.TexturePackInvalidURL
            local tbl3 = {
                SurfaceAppearanceName = value:GetFullName()
            }
            arg1:fail(texturePackInvalidUrl, tbl3, value)
        end
    end

    for _, value in TexturePackUtils.findSurfaceAppearancesWithTexturePacks(rootInstance) do
        local success, result = pcall(function(): boolean
            return UGCValidationService:DoesSurfaceAppearanceMatchTexturePackAsync(value)
        end)

        if not success then
            if bool1 then
                arg1:forceError(`Failed to download TexturePack for SurfaceAppearance '{value:GetFullName()}'.`)
            end

            local texturePackDownloadFailed = ErrorSourceStrings.Keys.TexturePack_DownloadFailed
            local tbl3 = {
                SurfaceAppearanceName = value:GetFullName()
            }
            arg1:fail(texturePackDownloadFailed, tbl3, value)
        elseif not result then
            local texturePackMismatch = ErrorSourceStrings.Keys.TexturePack_Mismatch
            local tbl3 = {
                SurfaceAppearanceName = value:GetFullName()
            }
            arg1:fail(texturePackMismatch, tbl3, value)
        end
    end
end

return module
