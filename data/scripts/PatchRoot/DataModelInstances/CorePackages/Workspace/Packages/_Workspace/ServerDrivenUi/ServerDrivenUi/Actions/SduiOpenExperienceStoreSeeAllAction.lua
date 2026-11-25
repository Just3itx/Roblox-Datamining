-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")

local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage
local NavigateDown = require(ServerDrivenUiParent.NavigationRodux).Thunks.NavigateDown
local navigateToDevStoreSeeAll = require(ServerDrivenUiParent.ExperienceStoreServerDrivenUi).navigateToDevStoreSeeAll
local Display = require(ServerDrivenUiParent.Display)
local Responsive = require(ServerDrivenUiParent.Responsive)

local openSduiWebLink = require(ServerDrivenUi.Actions.openSduiWebLink)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local SharedFlags = require(ServerDrivenUiParent.SharedFlags)
local FFlagLuaAppDevStoreSeeAllSduiEnabled = SharedFlags.FFlagLuaAppDevStoreSeeAllSduiEnabled
local FFlagLuaAppDevStoreSeeAllSduiLogExposure = SharedFlags.FFlagLuaAppDevStoreSeeAllSduiLogExposure
local FStringLuaAppDevStoreSeeAllSduiIxpLayer = SharedFlags.FStringLuaAppDevStoreSeeAllSduiIxpLayer
local FFlagSduiCapabilityDevStoreSeeAllWebviewFallback = SharedFlags.FFlagSduiCapabilityDevStoreSeeAllWebviewFallback
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil

local function getIsCompactTouch() -- Luacid: unused: defined but never referenced
    local var1 = Display.GetDisplayStore(false).getViewportSize(false)
    local var2 = Responsive.GetInputModeStore(false).getPreferredInputType(false)
    return Responsive.getIsCompactTouch(var1, var2)
end

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenExperienceStoreSeeAll,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local universeId = actionParams.universeId
    if typeof(universeId) ~= "string" or universeId == "" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenExperienceStoreSeeAll,
            message = `Invalid or missing universeId: {tostring(universeId)}`,
            propName = "universeId"
        }, arg2.appPage)
        return
    end

    if FFlagLuaAppDevStoreSeeAllSduiLogExposure then
        IXPService:LogFlagLinkedUserLayerExposure(FStringLuaAppDevStoreSeeAllSduiIxpLayer)
    end

    if FFlagLuaAppDevStoreSeeAllSduiEnabled then
        navigateToDevStoreSeeAll(arg2.dependencies.getNavigation(), universeId)
        return
    end

    if FFlagSduiCapabilityDevStoreSeeAllWebviewFallback then
        local var1 = Display.GetDisplayStore(false).getViewportSize(false)
        local var2 = Responsive.GetInputModeStore(false).getPreferredInputType(false)
        if not Responsive.getIsCompactTouch(var1, var2) then
            openSduiWebLink(
                arg2,
                string.format("https://www.roblox.com/games/store-section/%s", universeId),
                "Feature.GameDetails.Label.Store"
            )
            return
        end
    end

    local tbl1 = {
        name = AppPage.PassesPage,
        detail = universeId
    }
    if FFlagSignalsNavP3Dispatch then
        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
        return
    end
    arg2.dependencies.dispatch(NavigateDown(tbl1))
end
