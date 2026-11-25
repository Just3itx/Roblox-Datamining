-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local RoactCompat = require(Songbird.Parent.Dev.RoactCompat)
local MusicTestingUtils = require(Songbird.Parent.Dev.MusicTestingUtils)

return {
    name = Songbird.Name,
    roact = RoactCompat,
    storyRoots = { Songbird.Components },
    mapStory = function(arg1)
        return function(arg2)
            return RoactCompat.createElement(
                MusicTestingUtils.ContextProviders,
                {
                    theme = arg2.theme,
                    overlayGui = arg2.focus,
                    host = arg2.host
                },
                RoactCompat.createElement(arg1, arg2)
            )
        end
    end
}
