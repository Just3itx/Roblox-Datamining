-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local AppPage = require(ServerTriggeredModalsParent.RobloxAppEnums).AppPage
local PromptsEntryPoint = require(script.Parent.Parent.PromptsEntryPoint)

local SharedFlags = require(ServerTriggeredModalsParent.SharedFlags)
local bool1 = game:DefineFastFlag("LuaAppPromptsHomepageConfigName", false)
local FFlagEdpGameLeavePromptsHandlerEnabled = SharedFlags.FFlagEdpGameLeavePromptsHandlerEnabled
local FFlagEdpOpenPromptsHandlerEnabled = SharedFlags.FFlagEdpOpenPromptsHandlerEnabled
local FFlagLuaAppEnableSduiHomePage = SharedFlags.FFlagLuaAppEnableSduiHomePage
local FFlagChatPushUpsellPromptsEnabled = SharedFlags.FFlagChatPushUpsellPromptsEnabled
local FFlagNotificationStreamPromptsHandlerEnabled = SharedFlags.FFlagNotificationStreamPromptsHandlerEnabled

local tbl1 = {
    [PromptsEntryPoint.HomepageLaunch] = (bool1 or FFlagLuaAppEnableSduiHomePage)
        and {
            appPage = AppPage.Home,
            surfaceKey = "Prompts",
            configKey = "Prompts" .. PromptsEntryPoint.HomepageLaunch
        }
        or {
            appPage = AppPage.Home,
            surfaceKey = AppPage.Home,
            configKey = AppPage.Home
        },
    [PromptsEntryPoint.SelfUserProfileOpen] = {
        appPage = AppPage.ProfilePlatform,
        surfaceKey = AppPage.ProfilePlatform,
        configKey = "ProfileCompletion"
    },
    [PromptsEntryPoint.ChartsLaunch] = {
        appPage = AppPage.Games,
        surfaceKey = "ChartsPrompts",
        configKey = "Prompts" .. PromptsEntryPoint.ChartsLaunch
    },
    [PromptsEntryPoint.ExperienceDetailsPageSessionEnd] = FFlagEdpGameLeavePromptsHandlerEnabled
        and {
            appPage = AppPage.ExperienceDetail,
            surfaceKey = "ExperienceDetailsPrompts",
            configKey = "Prompts" .. PromptsEntryPoint.ExperienceDetailsPageSessionEnd
        }
        or nil,
    [PromptsEntryPoint.ExperienceDetailsPageOpen] = FFlagEdpOpenPromptsHandlerEnabled
        and {
            appPage = AppPage.ExperienceDetail,
            surfaceKey = "ExperienceDetailsOpenPrompts",
            configKey = "Prompts" .. PromptsEntryPoint.ExperienceDetailsPageOpen
        }
        or nil,
    [PromptsEntryPoint.ChatLandingOpen] = FFlagChatPushUpsellPromptsEnabled
        and {
            appPage = AppPage.Chat,
            surfaceKey = "ChatLandingPrompts",
            configKey = "Prompts" .. PromptsEntryPoint.ChatLandingOpen
        }
        or nil,
    [PromptsEntryPoint.NotificationStreamOpen] = FFlagNotificationStreamPromptsHandlerEnabled
        and {
            appPage = AppPage.Notifications,
            surfaceKey = "NotificationStreamPrompts",
            configKey = "Prompts" .. PromptsEntryPoint.NotificationStreamOpen
        }
        or nil
}

local function getEntryPointSurfaceConfig(arg1, str1: string?)
    local var1 = tbl1[arg1]
    assert(var1 ~= nil, `PromptsHandler: missing surface config for entry point "{arg1}"`)

    if not (FFlagEdpGameLeavePromptsHandlerEnabled or FFlagEdpOpenPromptsHandlerEnabled) or str1 == nil then
        return var1
    end

    return {
        appPage = var1.appPage,
        surfaceKey = var1.surfaceKey,
        configKey = `{var1.configKey}-{str1}`
    }
end

return getEntryPointSurfaceConfig
