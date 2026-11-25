-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlaceInfoRoduxParent = script:FindFirstAncestor("PlaceInfoRodux").Parent

local GenerateStringId = require(PlaceInfoRoduxParent.AppCommonLib).GenerateStringId

local PlaceInfoModel = require(script.Parent.PlaceInfoModel)

local module = {}

function module.mock()
    local placeInfoModel = PlaceInfoModel.new()

    placeInfoModel.builder = "builder"
    placeInfoModel.builderId = GenerateStringId()
    placeInfoModel.description = "description"
    placeInfoModel.imageToken = GenerateStringId()
    placeInfoModel.isPlayable = true
    placeInfoModel.name = "name"
    placeInfoModel.placeId = GenerateStringId()
    placeInfoModel.price = 0
    placeInfoModel.reasonProhibited = nil
    placeInfoModel.universeId = GenerateStringId()
    placeInfoModel.universeRootPlaceId = GenerateStringId()
    placeInfoModel.url = "url"

    return placeInfoModel
end

setmetatable(module, { __index = PlaceInfoModel })

return module
