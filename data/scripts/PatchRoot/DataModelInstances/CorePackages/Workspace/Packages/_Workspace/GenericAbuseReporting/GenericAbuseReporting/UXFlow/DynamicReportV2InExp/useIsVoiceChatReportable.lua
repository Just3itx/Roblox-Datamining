-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)

local VOICE_JOIN_PROGRESS = require(GenericAbuseReportingParent.VoiceChatCore).Constants.VOICE_JOIN_PROGRESS

return {
    useIsVoiceChatReportable = function(tbl1)
        local function computeIsVoiceChatReportable() -- Luacid: Inlined by compiler; 1 call site recovered
            return tbl1:UserVoiceEnabled() and tbl1:GetVoiceJoinProgress() ~= VOICE_JOIN_PROGRESS.Suspended
        end

        local var1, var2 = React.useState(computeIsVoiceChatReportable)

        React.useEffect(function()
            local bool1 = true
            local function recheck()
                if not bool1 then
                    return
                end
                var2((computeIsVoiceChatReportable()))
            end

            tbl1:asyncInit():andThen(recheck):catch(recheck)

            local connection = tbl1.VoiceJoinProgressChanged.Event:Connect(recheck)

            return function()
                bool1 = false
                connection:Disconnect()
            end
        end, { tbl1 })

        return var1
    end
}
