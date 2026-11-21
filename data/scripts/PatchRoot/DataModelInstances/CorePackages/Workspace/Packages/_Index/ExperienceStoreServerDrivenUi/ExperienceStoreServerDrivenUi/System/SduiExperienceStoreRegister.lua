-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStoreServerDrivenUi = script:FindFirstAncestor("ExperienceStoreServerDrivenUi")
local ExperienceStoreServerDrivenUiParent = ExperienceStoreServerDrivenUi.Parent
local React = require(ExperienceStoreServerDrivenUiParent.React)

local FFlagSduiGameItemsComponent = require(ExperienceStoreServerDrivenUiParent.SharedFlags).FFlagSduiGameItemsComponent
local FFlagSduiLocalFeedFilter = require(ExperienceStoreServerDrivenUiParent.SharedFlags).FFlagSduiLocalFeedFilter

local registerExperienceStoreActions = require(ExperienceStoreServerDrivenUi.Actions.registerExperienceStoreActions)

local registerExperienceStoreComponents = require(ExperienceStoreServerDrivenUi.System.registerExperienceStoreComponents)

return React.memo(function() -- name: SduiExperienceStoreRegister
    React.useEffect(function()
        registerExperienceStoreActions()
        if FFlagSduiGameItemsComponent or FFlagSduiLocalFeedFilter then
            registerExperienceStoreComponents()
        end
    end, {})
    return nil
end)
