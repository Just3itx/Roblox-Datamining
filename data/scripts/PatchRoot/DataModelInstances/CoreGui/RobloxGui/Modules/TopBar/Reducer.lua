-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local CrossExperienceVoice = require(CorePackages.Workspace.Packages.CrossExperienceVoice)
local CrossExperience = require(CorePackages.Workspace.Packages.CrossExperience)
local createPersistenceMiddleware = CrossExperience.Middlewares.createPersistenceMiddleware

local FFlagTopBarSignalizeHealthBar = require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeHealthBar
local GetFFlagEnableCrossExpVoice = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableCrossExpVoice

local scriptParent = script.Parent

local FFlagTopBarDeprecateCoreGuiRodux = require(scriptParent.Flags.FFlagTopBarDeprecateCoreGuiRodux)
local FFlagTopBarDeprecateChatRodux = require(scriptParent.Flags.FFlagTopBarDeprecateChatRodux)

local DisplayOptions = require(script.DisplayOptions)
local CoreGuiEnabled = require(script.CoreGuiEnabled)
local Health = require(script.Health)
local MoreMenu = require(script.MoreMenu)
local Chat = require(script.Chat)
local Respawn = require(script.Respawn)
local GameInfo = require(script.GameInfo)

local tbl1 = {
    displayOptions = DisplayOptions,
    coreGuiEnabled = 0,
    health = 0,
    moreMenu = 0,
    chat = 0,
    respawn = 0,
    gameInfo = 0
}

if FFlagTopBarDeprecateCoreGuiRodux then
    CoreGuiEnabled = nil
end

tbl1.coreGuiEnabled = CoreGuiEnabled
if FFlagTopBarSignalizeHealthBar then
    Health = nil
end

tbl1.health = Health
tbl1.moreMenu = MoreMenu
if FFlagTopBarDeprecateChatRodux then
    Chat = nil
end

tbl1.chat = Chat
tbl1.respawn = Respawn
tbl1.gameInfo = GameInfo

if GetFFlagEnableCrossExpVoice() then
    local var1 = createPersistenceMiddleware({ storeKey = CrossExperience.Constants.STORAGE_CEV_STORE_KEY }).restore()
    local crossExperienceVoice = if var1 and var1.Squad and var1.Squad.CrossExperienceVoice then var1.Squad.CrossExperienceVoice else nil
    tbl1.Squad = Rodux.combineReducers({ CrossExperienceVoice = CrossExperienceVoice.installReducer(crossExperienceVoice) })
end

return (Rodux.combineReducers(tbl1))
