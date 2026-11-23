-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local SduiSharedUtilities = require(AppChatParent.SduiSharedUtilities)
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer

local SduiConstants = require(script.Parent.SduiConstants)

local function isBlankPayload(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 == nil
        or (if typeof(arg1) == "string" then string.match(arg1, "^%s*$") ~= nil else typeof(arg1) == "table" and next(arg1) == nil)
end

local function seedConversationTopModalSduiPayload(tbl1, str1: string)
    local configKey = SduiConstants.getConversationTopModalConfigKey(str1)
    local sduiApiStore = getSduiApiStore()

    if isBlankPayload(tbl1) then
        sduiApiStore.clearConfigEntries(configKey)
        return
    end

    local partyChatResponse = require(AppChatParent.ServiceContractsProto).apppageplatform.partychat.party_chat.PartyChatResponse
    local decodedResponse = partyChatResponse.jsonDecode(tbl1)

    sduiApiStore.seedFromDecodedResponse({
        surfaceKey = SduiConstants.SurfaceKey,
        configKey = configKey,
        decodedResponse = decodedResponse,
        loadTimer = SduiLoadTimer.createLoadTimer(SduiConstants.SurfaceKey),
        apiProto = partyChatResponse,
        replace = true
    })
end

return seedConversationTopModalSduiPayload
