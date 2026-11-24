-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)
local Signals = require(GenericAbuseReportingParent.Signals)

local VoiceChatServiceManagerContext = React.createContext(nil)

local function createVoiceSpeakingStore()
    local var1, var2 = Signals.createSignal({})
    local tbl1 = ({})
    local tbl2 = ({})

    local function pruneCache() -- Luacid: Inlined by compiler; 1 call site recovered
        local now = os.clock()
        for value, value2 in tbl2 do
            if now - value2 > 300 then
                tbl1[value] = nil
                tbl2[value] = nil
            end
        end
    end

    return {
        getIsSpeaking = function(str1: string)
            tbl2[str1] = os.clock()
            if not tbl1[str1] then
                tbl1[str1] = Signals.createComputed(function(arg1): boolean
                    return var1(arg1)[str1] == true
                end)
            end
            return tbl1[str1]
        end,
        setParticipants = function(tbl3)
            pruneCache()
            var2(tbl3)
        end
    }
end

local function buildParticipantsMap(arg1)
    local participantsMap = {}
    for k, value in pairs(arg1) do
        participantsMap[tostring(k)] = value.isSignalActive == true
    end
    return participantsMap
end

return {
    useVoiceSpeakingStore = function()
        local var1 = React.useContext(VoiceChatServiceManagerContext)

        local var2 = React.useRef(nil)
        if not var2.current then
            var2.current = createVoiceSpeakingStore()
        end
        local current = var2.current

        React.useEffect(function()
            if not var1 then
                return
            end

            if var1.participants then
                current.setParticipants((buildParticipantsMap(var1.participants)))
            end

            local connection = var1.participantsUpdate.Event:Connect(function(arg1)
                current.setParticipants((buildParticipantsMap(arg1)))
            end)

            return function()
                connection:Disconnect()
            end
        end, { var1, current.setParticipants })

        return current
    end,
    createVoiceSpeakingStore = createVoiceSpeakingStore,
    VoiceChatServiceManagerContext = VoiceChatServiceManagerContext
}
