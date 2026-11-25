-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local SduiSharedUtilities = require(ServerDrivenUiParent.SduiSharedUtilities)
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer

local SduiV2OmniFeedConstants = require(ServerDrivenUi.Migration.SduiV2OmniFeedConstants)

local function seedHomeOmniSduiV2Payload(tbl1, surfaceKey: string, arg1)
    local loadTimer = arg1 or SduiLoadTimer.createLoadTimer(surfaceKey)

    local homePageResponse = require(ServerDrivenUiParent.ServiceContractsProto).apppageplatform.home.home_page.HomePageResponse

    local decodedResponse = homePageResponse.jsonDecode(tbl1)

    getSduiApiStore().seedFromDecodedResponse({
        surfaceKey = surfaceKey,
        configKey = SduiV2OmniFeedConstants.HomeConfigKey,
        decodedResponse = decodedResponse,
        loadTimer = loadTimer,
        apiProto = homePageResponse
    })
end

return seedHomeOmniSduiV2Payload
