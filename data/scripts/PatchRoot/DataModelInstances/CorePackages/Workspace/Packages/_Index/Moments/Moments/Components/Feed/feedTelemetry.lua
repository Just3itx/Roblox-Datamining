-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _FeedTypes = require(script.Parent.FeedTypes)

return {
    createNoopTelemetry = function()
        return {
            logView = function(_, _) end,
            logAction = function(_, _, _)
                return nil
            end
        }
    end,
    createRecordingTelemetry = function()
        local views = {}
        local actions = {}

        return {
            views = views,
            actions = actions,
            logView = function(attribution, info)
                table.insert(views, { attribution = attribution, info = info })
            end,
            logAction = function(actionType, attribution, payload)
                table.insert(actions, { actionType = actionType, attribution = attribution, payload = payload })

                return nil
            end
        }
    end
}
