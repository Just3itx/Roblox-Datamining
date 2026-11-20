-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

require(CorePackages.Packages.UIBlox).init(require(CorePackages.Workspace.Packages.RobloxAppUIBloxConfig))

Roact.setGlobalConfig({ elementTracing = true, propValidation = true })

return {
    roact = Roact,
    mapStory = function(arg1)
        return function(arg2)
            return Roact.createElement(arg1, arg2)
        end
    end
}
