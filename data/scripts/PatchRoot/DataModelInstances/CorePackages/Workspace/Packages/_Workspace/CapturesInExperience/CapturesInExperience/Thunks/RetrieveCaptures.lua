-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CaptureService = game:GetService("CaptureService")

local CapturesRetrieved = require(scriptParentParent.Actions.CapturesRetrieved)
local Constants = require(scriptParentParent.Constants)
local _Types = require(scriptParentParent.Types)
local fetchCapturesFromGallery = require(scriptParentParent.Utils.fetchCapturesFromGallery)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

local FFlagCaptureServiceRetrieveCapturesSafeguard = require(scriptParentParent.Flags.FFlagCaptureServiceRetrieveCapturesSafeguard)
local FFlagCapturesFetchUseSharedUtility = require(scriptParentParent.Flags.FFlagCapturesFetchUseSharedUtility)

local function getSelectedCapture(state) -- Luacid: Inlined by compiler; 1 call site recovered
    local selectedCaptureIndex = state[Constants.RoduxKey].Carousel.SelectedCaptureIndex

    if selectedCaptureIndex == nil then
        return nil
    end

    return state[Constants.RoduxKey].Captures[selectedCaptureIndex]
end

return function()
    return function(arg1)
        local selectedCapture = getSelectedCapture((arg1:getState()))

        if FFlagCapturesFetchUseSharedUtility then
            local var1 = fetchCapturesFromGallery()
            arg1:dispatch(CapturesRetrieved(var1, selectedCapture))
            return
        end
        if FFlagEnableCapturesGalleryRetrievalCoreScript then
            local success, result = pcall(function()
                local var1, var2 = CaptureService:ReadCapturesFromGalleryAsync()
                return if var1 == Enum.ReadCapturesFromGalleryResult.Success then var2 else nil
            end)

            local tbl1 = {}
            if success then
                local currentPage = result:GetCurrentPage()
                for _, value in ipairs(currentPage) do
                    table.insert(tbl1, value)
                end
                arg1:dispatch(CapturesRetrieved(tbl1, selectedCapture))
                return
            end
            warn("Failed to retrieve captures from gallery")
        elseif FFlagCaptureServiceRetrieveCapturesSafeguard then
            local success, result = pcall(function()
                return CaptureService:RetrieveCaptures()
            end)
            if success then
                arg1:dispatch(CapturesRetrieved(result, selectedCapture))
                return
            end
            warn("Failed to retrieve captures from gallery")
        else
            local var1 = CaptureService:RetrieveCaptures()
            arg1:dispatch(CapturesRetrieved(var1, selectedCapture))
        end
    end
end
