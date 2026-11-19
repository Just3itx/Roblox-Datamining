-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
require(CorePackages.Packages.UIBlox).init(require(CorePackages.Workspace.Packages.RobloxAppUIBloxConfig))

local StoryStore = require(script.Parent.Helpers.StoryStore)
local ChatSettings = require(script.Parent.ChatSettings)

Roact.setGlobalConfig({ elementTracing = true, propValidation = true })

return {
    roact = Roact,
    mapStory = function(arg1)
        return function(arg2)
            return Roact.createElement(
                RoactRodux.StoreProvider,
                { store = StoryStore },
                {
                    Story = Roact.createElement(arg1, Cryo.Dictionary.join(arg2, { chatSettings = ChatSettings }))
                }
            )
        end
    end
}
