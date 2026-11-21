-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local AvatarExperienceNavigation = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation)
local useMakeupFtux = require(script.Parent.useMakeupFtux)

local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen

local num1 = game:DefineFastInt("AXMakeupReleaseFtuxPromptDelayMS", 500)

local function useCatalogPageMakeupReleaseFtuxHook(arg1, arg2, callback: (...any) -> (...any))
    local var1 = useMakeupFtux()
    local name = arg1 and arg1.opaque and arg1.opaque.name
    local routeName = arg2.state.routeName

    React.useEffect(function()
        local var2 = if var1.shouldShowMakeupReleasePrompt() and name == AvatarScreen.Catalog and routeName == name then task.delay(num1 / 1000, function()
            arg2.navigate(AvatarScreen.MakeupReleaseFtuxPrompt, {
                onView = function()
                    var1.setShownMakeupReleasePrompt()
                    callback()
                end,
                onDismiss = function()
                    var1.setShownMakeupReleasePrompt()
                end
            })
        end) else nil

        return function()
            if var2 then
                task.cancel(var2)
            end
        end
    end, {
        var1,
        arg2,
        name,
        routeName,
        callback
    })
end
return useCatalogPageMakeupReleaseFtuxHook
