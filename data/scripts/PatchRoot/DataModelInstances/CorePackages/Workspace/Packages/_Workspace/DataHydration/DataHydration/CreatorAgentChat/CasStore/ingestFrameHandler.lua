-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AcpProtocol = require(script.Parent.Parent.Acp.AcpProtocol)
local _createTurnHandle = require(script.Parent.Parent.createTurnHandle)
local _types = require(script.Parent.Parent.types)

return {
    ingestFrame = function(tbl1, arg1, arg2)
        assert(arg1 and (arg1.kind == "notification" or arg1.kind == "response"), "ingestFrame requires an IncomingFrame")
        local var1

        if arg1.kind == "notification" then
            local sessionId = arg1.notification.params and arg1.notification.params.sessionId
            if typeof(sessionId) ~= "string" or sessionId == "" then
                warn(("[CAS] dropped notification without sessionId: %s"):format(arg1.notification.method))
                return
            end

            if arg1.notification.method == AcpProtocol.Notifications.SessionUpdate then
                local update = arg1.notification.params and arg1.notification.params.update
                local sequenceNumber = if arg2 == nil then nil else arg2.sequenceNumber

                if update ~= nil and typeof(sequenceNumber) == "number" then
                    local sessionByCasSessionId = tbl1.getSessionByCasSessionId(sessionId)
                    if sessionByCasSessionId == nil then
                        local universeId = arg1.notification.params and arg1.notification.params.universeId
                        if typeof(universeId) == "number" then
                            sessionByCasSessionId = tbl1.getSessionForProject(universeId, nil, sessionId)
                        end
                    end
                    if sessionByCasSessionId ~= nil then
                        sessionByCasSessionId.ingestRealtimeUpdate(update, sequenceNumber)
                    end
                end
            end

            var1 = tbl1.getActiveTurnBySession(sessionId)
            if var1 == nil then
                return
            end
        else
            local id = arg1.response.id
            if id == nil then
                warn("[CAS] dropped response frame with no id")
                return
            end
            local str1 = tostring(id)
            var1 = tbl1.getActiveTurnByRequestId(str1)
            if var1 == nil then
                tbl1.logger:debug(`[CAS] no active handle for response id={str1}`)
                return
            end
        end

        if var1 == nil then
            return
        end

        var1.dispatchFrame(arg1, arg2)
        if var1.isDone() then
            tbl1.onTurnDone(var1)
        end
    end
}
