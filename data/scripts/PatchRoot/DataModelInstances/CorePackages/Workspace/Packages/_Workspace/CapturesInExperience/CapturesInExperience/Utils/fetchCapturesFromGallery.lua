-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CaptureService = game:GetService("CaptureService")

local _Types = require(scriptParentParent.Types)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

local FFlagCaptureServiceRetrieveCapturesSafeguard = require(scriptParentParent.Flags.FFlagCaptureServiceRetrieveCapturesSafeguard)

local function fetchCapturesFromGallery()
    if not FFlagEnableCapturesGalleryRetrievalCoreScript then
        if not FFlagCaptureServiceRetrieveCapturesSafeguard then
            return CaptureService:RetrieveCaptures()
        end

        local success, result = pcall(function()
            return CaptureService:RetrieveCaptures()
        end)
        if success then
            return result
        end

        warn("Failed to retrieve captures from gallery")
        return {}
    end

    local success, result = pcall(function()
        local var1, var2 = CaptureService:ReadCapturesFromGalleryAsync()
        return if var1 == Enum.ReadCapturesFromGalleryResult.Success then var2 else nil
    end)

    if not (success and result) then
        warn("Failed to retrieve captures from gallery")
        return {}
    end

    local result2 = {}
    local currentPage = result:GetCurrentPage()
    for _, value in ipairs(currentPage) do
        table.insert(result2, value)
    end
    return result2
end

return fetchCapturesFromGallery
