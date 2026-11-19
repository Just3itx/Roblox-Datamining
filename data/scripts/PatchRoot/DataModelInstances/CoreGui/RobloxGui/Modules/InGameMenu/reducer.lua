-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.InGameMenuDependencies).Cryo

local scriptParent = script.Parent

local SetMenuOpen = require(scriptParent.Actions.SetMenuOpen)
local SetMainPageMoreMenuOpen = require(scriptParent.Actions.SetMainPageMoreMenuOpen)
local SetCurrentPage = require(scriptParent.Actions.SetCurrentPage)
local SetScreenSize = require(scriptParent.Actions.SetScreenSize)
local StartLeavingGame = require(scriptParent.Actions.StartLeavingGame)
local CancelLeavingGame = require(scriptParent.Actions.CancelLeavingGame)
local SetControlLayout = require(scriptParent.Actions.SetControlLayout)
local SetRespawning = require(scriptParent.Actions.SetRespawning)
local SetCurrentZone = require(scriptParent.Actions.SetCurrentZone)
local SetControllerBarHeight = require(scriptParent.Actions.SetControllerBarHeight)
local DecrementControllerBar = require(scriptParent.Actions.DecrementControllerBar)
local IncrementControllerBar = require(scriptParent.Actions.IncrementControllerBar)

local navigationReducer = require(script.navigationReducer)
local respawn = require(script.respawn)
local invites = require(script.invites)
local gameInfo = require(script.gameInfo)
local report = require(script.report)
local friends = require(script.friends)
local displayOptions = require(script.displayOptions)
local nativeClosePrompt = require(script.nativeClosePrompt)
local voiceState = require(scriptParent.Parent.VoiceChat.Reducers.voiceState)

local Constants = require(scriptParent.Resources.Constants)
local Controls = require(scriptParent.Resources.Controls)

local tbl1 = {}
tbl1[SetMenuOpen.name] = function(arg1, arg2)
    local isMainPageMoreMenuOpen = if arg2.isMenuOpen then nil else false
    return Cryo.Dictionary.join(arg1, {
        isMenuOpen = arg2.isMenuOpen,
        isMainPageMoreMenuOpen = isMainPageMoreMenuOpen,
        currentZone = if arg1.isMenuOpen ~= arg2.isMenuOpen then 1 else nil
    })
end

tbl1[SetMainPageMoreMenuOpen.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { isMainPageMoreMenuOpen = arg2.isMainPageMoreMenuOpen })
end

tbl1[StartLeavingGame.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { leavingGame = true })
end

tbl1[CancelLeavingGame.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { leavingGame = false })
end

tbl1[SetCurrentPage.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, {
        menuPage = arg2.newPage,
        isMainPageMoreMenuOpen = false,
        currentZone = if arg2.newPage == Constants.InitalPageKey then 0 else 1
    })
end

tbl1[SetControlLayout.name] = function(arg1, arg2)
    local controlLayout = arg2.controlLayout

    return Cryo.Dictionary.join(arg1, { controlLayout = controlLayout })
end

tbl1[SetScreenSize.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { screenSize = arg2.newScreenSize })
end

tbl1[SetRespawning.name] = function(arg1, arg2)
    local isMainPageMoreMenuOpen = not arg2.respawning and arg1.isMainPageMoreMenuOpen
    return Cryo.Dictionary.join(arg1, { isMainPageMoreMenuOpen = isMainPageMoreMenuOpen })
end

tbl1[SetCurrentZone.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { currentZone = arg2.zone })
end

tbl1[SetControllerBarHeight.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { controllerBarHeight = arg2.controllerBarHeight })
end

tbl1[IncrementControllerBar.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { controllerBarCount = arg1.controllerBarCount + 1 })
end

tbl1[DecrementControllerBar.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { controllerBarCount = arg1.controllerBarCount - 1 })
end

local function reducer(arg1, arg2)
    arg1 = arg1 == nil
        and {
            controlLayout = Controls.ControlLayouts.KEYBOARD,
            isMenuOpen = false,
            leavingGame = false,
            currentZone = nil,
            menuPage = Constants.defaultPageKey,
            voiceState = nil,
            invites = invites(nil, arg2),
            respawn = respawn(nil, arg2),
            gameInfo = gameInfo(nil, arg2),
            friends = friends(nil, arg2),
            displayOptions = displayOptions(nil, arg2),
            screenSize = Vector2.new(0, 0),
            recording = false,
            isMainPageMoreMenuOpen = false,
            nativeClosePrompt = nativeClosePrompt(nil, arg2),
            controllerBarHeight = 0,
            controllerBarCount = 0
        }
        or arg1

    local var1 = tbl1[arg2.type]
    if var1 ~= nil then
        arg1 = var1(arg1, arg2)
    end
    arg1 = navigationReducer(arg1, arg2)

    arg1.respawn = respawn(arg1.respawn, arg2)
    arg1.invites = invites(arg1.invites, arg2)
    arg1.voiceState = voiceState(arg1.voiceState, arg2)
    arg1.gameInfo = gameInfo(arg1.gameInfo, arg2)
    arg1.report = report(arg1.report, arg2)
    arg1.friends = friends(arg1.friends, arg2)
    arg1.displayOptions = displayOptions(arg1.displayOptions, arg2)
    arg1.nativeClosePrompt = nativeClosePrompt(arg1.nativeClosePrompt, arg2)

    return arg1
end

return reducer
