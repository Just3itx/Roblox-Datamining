-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local UIBlox = require(scriptParent.UIBlox)

return {
    config = function(arg1)
        if arg1.UIBloxConfig then
            UIBlox.init(arg1.UIBloxConfig)
        end

        return {
            Analytics = require(script.Analytics),
            Components = require(script.Components),
            Conversation = require(script.Conversation),
            Dictionary = require(script.Dictionary),
            User = require(script.User),
            Utils = require(script.Utils),
            RoactLayout = require(script.RoactLayout),
            RoactPaginator = require(script.RoactPaginator),
            RoduxTools = require(script.RoduxTools),
            populate = require(script.populate),
            TestingAnalytics = require(script.TestingAnalytics),
            ReleaseHelpers = require(script.ReleaseHelpers),
            Flags = require(script.Flags),
            StoryMiddleware = require(script.StoryMiddleware),
            Context = require(script.Context)
        }
    end
}
