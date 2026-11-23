-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local HttpService = game:GetService("HttpService")

local Foundation = require(AppChatParent.Foundation)

local getRbxThumb = Foundation.Utility.getRbxThumb
local ThumbnailType = Foundation.Enums.ThumbnailType

local function getMediaContentUri(assetId: number, captureType, str1: string?): string -- Luacid: Inlined by compiler; 1 call site recovered
    local str2 = `rbxassetid://{assetId}`
    if captureType ~= Enum.CaptureType.Video or str1 == nil then
        return str2
    elseif require(AppChat.Flags.FFlagAppChatMomentShareCardPermissionContextFix) and game.GameId == 0 then
        return `{str2}&accessContext={str1}`
    end
    return `{str2}&accessContext={str1}&permissionContext=ignoreUniverse`
end

local function buildMomentShareCardMedia(tbl1): {captureType: number, content: number, posterContent: number}?
    local assetId = tbl1.assetId
    local captureType = tbl1.captureType
    if assetId == nil or captureType == nil then
        return nil
    end

    local assetAccessContext = tbl1.assetAccessContext
    local var1 = if assetAccessContext == nil or assetAccessContext == "" then nil else HttpService:UrlEncode(assetAccessContext)
    local uri = if assetId > 0 then Content.fromUri(
        if var1 ~= nil then `{getRbxThumb(ThumbnailType.Asset, assetId)}&accessContext={var1}` else getRbxThumb(ThumbnailType.Asset, assetId)
    ) else nil
    return {
        content = Content.fromUri((getMediaContentUri(assetId, captureType, var1))),
        posterContent = uri,
        captureType = captureType
    }
end

return buildMomentShareCardMedia
